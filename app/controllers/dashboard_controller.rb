class DashboardController < ApplicationController
  def index
    @participants = Participant.all
    @checkpoints = Checkpoint.all
    @count = Checkpoint.count
    # @leaders = User.all.sort_by(:points)
  end
end
