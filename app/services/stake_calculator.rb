class StakeCalculator

  def initialize(options)
    @options = options
    @checkpoint = Checkpoint.find(options[:checkpoint_id])
  end

  def call
    move_participants
    @options[:participants].each do |participant, status|
      stakes_on(participant).each do |stake|
          StakeProcessor.new(stake, status).call
        end
    end
    @checkpoint.update(closed: true)
  end

  def move_participants
    @options[:participants].each do |participant, status|
      if status == "success"
        Participant.find_by(nickname: participant).update(position: @checkpoint.order)
      end
    end
  end

  def stakes_on(participant_nickname)
    stakes.where(participant_id: Participant.find_by(nickname: participant_nickname).id)
  end

  def stakes
    Stake.where(checkpoint_id: @checkpoint.id)
  end
end

{:checkpoint_id=>2, :participants=>{:bui=>"success", :nik=>"failure", :pes=>"success", :dim=>"failure"}}