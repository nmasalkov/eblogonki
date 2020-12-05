class DashboardController < ApplicationController
  def index
    @participants = Participant.all
    @checkpoints = Checkpoint.order(:order)
    @count = Checkpoint.count
    @leaders = User.order("points DESC").limit(5)
    @logs = Log.all
  end
end
