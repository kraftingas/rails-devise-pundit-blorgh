# config/initializers/pundit.rb
# Extends the ApplicationController to add Pundit for authorization.
# Modify this file to change the behavior of a 'not authorized' error.
# Be sure to restart your server when you modify this file.
module PunditHelper
  extend ActiveSupport::Concern

  included do
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s
    flash[:alert] = "Access denied by #{policy_name} for #{exception.record} #{exception.query.chop}"
    redirect_to (request.referrer || root_path)
  end

end

ApplicationController.send :include, PunditHelper
