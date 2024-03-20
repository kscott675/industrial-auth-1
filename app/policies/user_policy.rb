class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :user

  def initialize(current_user, user)
    @current_user = current_user
    @user = user
  end

  def show?
    user_authorized?
  end

  def feed?
    true
  end

  def discover?
    true
  end

  def liked?
    show_content?
  end

  def show_content?
    user == current_user ||
    !user.private? ||
    user.followers.include?(current_user)
  end

  private

  def user_authorized?
    user == current_user ||
    !user.private? ||
    user.followers.include?(current_user)
  end
end
