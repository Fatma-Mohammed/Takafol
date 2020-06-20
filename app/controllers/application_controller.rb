class ApplicationController < ActionController::Base
  # include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

    # def render_cases
    #   @cases =Case.all
    # end
    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:national_id,:name ,:phone_number , :description, :phone, :city_id, :address ])
    end

  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
  end
end
