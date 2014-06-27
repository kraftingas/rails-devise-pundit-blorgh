class UserPolicy < AccessPolicy
  #attr_reader :current_user, :model

  #def initialize(current_user, model)
    #@current_user = current_user
    #@user = model
  #end

  def index?
    #return false if @current_user.nil?
    #unless @current_user.admin?
      #raise AuthorizationError, 'Access for administrators only.'
    #end
    true
  end

  def show?
    unless @current_user.admin? or @current_user == @user
      raise AuthorizationError, 'Access denied to user profile.'
    end
    #true
  end

  def update?
    @current_user.admin?
  end

  def destroy?
    return false if @current_user == @user
    @current_user.admin?
  end
  
  def permitted_attributes
    if @current_user.admin?
      [:role]
    else
      [:name, :email]
    end
  end
  
  class AuthorizationError < StandardError
  end
  
  class Scope < Struct.new(:current_user, :model)
    def resolve
      if current_user.admin?
        model.all
      else
        model.where(role: current_user.role)
      end
    end
  end

end
