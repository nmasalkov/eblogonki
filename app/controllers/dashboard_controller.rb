class DashboardController < ApplicationController
  def index
    @participants = Participant.all
    @checkpoints = Checkpoint.all
    @count = Checkpoint.count
    @leaders = User.order("points DESC")
  end
end
