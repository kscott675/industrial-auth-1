class PhotoPolicy < ApplicationPolicy
  attr_reader :user, :photo

  def initialize(user,photo)
    @user = user
    @photo = photo
  end 

  def show?
    profile_public?
  end

  def create?
    true
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end
end 
