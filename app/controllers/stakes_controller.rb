class StakesController < ApplicationController

  before_action :authenticate_user!

  def create
    params.merge!({user_id: current_user.id})
    stake_creator = StakeCreator.new(params, current_user)
    if stake_creator.save
      redirect_to :root, :flash => { :success => "Ваша ставочка принята! Осталось #{current_user.points} ОЧКО(в)" }
    else
      redirect_to :root, :flash => { :error => stake_creator.errors.join("\n") }
    end

  end
end
