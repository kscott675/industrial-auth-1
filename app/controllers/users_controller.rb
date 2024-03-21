class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed followers following discover ]
  before_action only: [:index, :edit, :update, :destroy, :show, :feed] do
    authorize(@user || User)
  end
  before_action :authorize_profile_access, only: %i[ :show ]

  def show
    authorize_profile_access
  end

  def feed
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
