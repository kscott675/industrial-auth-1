class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed followers following discover ]
  before_action :authorize_profile_access, only: %i[ :show ]
  before_action only: [:index, :edit, :update, :destroy, :show] do
    authorize(@user || User)
  
  end

  def show
    authorize_profile_access
    authorize @user
  end

  def feed
    authorize @user
  end

  private

  def set_user
    if params[:username]
      @user = User.find_by!(username: params.fetch(:username))
    else
      @user = current_user
    end
  end
end
