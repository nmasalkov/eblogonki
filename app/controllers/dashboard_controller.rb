class DashboardController < ApplicationController
  def index
    @participants = Participant.all
    @checkpoints = Checkpoint.order(:order)
    @count = Checkpoint.count
    @leaders = User.order("points DESC").limit(5)
    @logs = Log.all.order("created_at DESC")
  end
end
