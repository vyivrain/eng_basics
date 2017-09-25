class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :async_creating_flash

  protected

  def page
    "#{controller_path.camelcase.gsub('::', '')}#{action_name.camelcase}" if response.ok?
  end

  def async_creating_flash
    flash[:notice] = I18n.t('fibs.create.success') if params[:creating].present? && page == 'FibsIndex'
  end
end
