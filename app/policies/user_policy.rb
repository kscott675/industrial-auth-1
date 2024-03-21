class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :user

  def initialize(current_user, user)
    @current_user = current_user
    @user = user
  end

  def show?
    true
  end

  def feed?
    user == current_user
  end

  def discover?
    user == current_user
  end

  def liked?
    profile_public?
  end
end
