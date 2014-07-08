class UsersController < ApplicationController
  before_filter :authenticate_user!
  #after_action :verify_authorized
  #after_action :verify_policy_scoped
  
  rescue_from UserPolicy::AuthorizationError, with: :user_not_authorized

  def index
    #if current_user.admin?
      #@users = User.all
    #else
      #@users = User.where("role = ?", User.roles[current_user.role])
    #end
    #authorize User
    #@users = UserPolicy::Scope.new(current_user, User).resolve
    @users = policy_scope(User).oldest
  end

  def show
    @user = User.find(params[:id])
    #@users = policy_scope(Access)
    @posts = Post.where(user_id: @user.id).order(:id)
    #authorize @user
    @user_comments = @user.user_comments(@user).size
    #authorize Access
  end

  def update
    @user = User.find(params[:id])
    @user.avatar = params[:file]
    #u.avatar = File.open('somewhere')
    #u.save!
    #u.avatar.url # => '/url/to/file.png'
    #u.avatar.current_path # => 'path/to/file.png'
    #u.avatar.identifier # => 'file.png'
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end
  
  #galima ir kiekviename kontrolery atskirai apsirasyti, tada override'ina initializers.
  #def user_not_authorized
    #flash[:alert] = "No way! This operation is not allowed."
    #redirect_to (request.referrer || root_path)
  #end

  private

  def secure_params
    params.require(:user).permit(*policy(@user || User).permitted_attributes, :avatar)
  end
  
  def user_not_authorized
    flash[:alert] = $!
    redirect_to (request.referrer || root_path)
  end

end
