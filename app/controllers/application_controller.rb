require 'logging'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.sunn
  before_action :configure_logger

  protected

  def configure_logger
    @logger = Logging.new
  end
end
