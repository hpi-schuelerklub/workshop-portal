class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :store_current_location, :unless => :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      puts "oh gott"
      format.html { redirect_to main_app.root_url, :alert => exception.message }
    end
  end

  def index
    # FIXME application-side filtering isn't all that great, but
    #       unless we want to write custom SQL joins (which
    #       we should if this becomes a perf problem), there is no
    #       other solution
    @events = Event.sorted_by_start_date(true)
      .select { |a| a.start_date > Time.now }
      .first(3)
    render 'index', locals: { full_width: true }
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :name, :password, :password_confirmation, :role)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:email, :name, :password, :password_confirmation, :role, :current_password)
    end
  end

  private
  # override the devise helper to store the current location so we can
  # redirect to it after logging in or out. This override makes signing in
  # and signing up work automatically.
  def store_current_location
    store_location_for(:user, request.url)
  end
end
