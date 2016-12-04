class LogsController < ApplicationController
  def config_logger
    @logger.set_console(params[:allow_console])
    @logger.set_serverity(params[:severity_level])
    render json: {status: "ok"}
  end

  def log_message
    @logger.log_message(params[:message], params[:severity_level])
    render json: {status: "ok"}
  end

  def config_max_line_limit
    limit = check_if_number(params[:max_line_limit])
    if limit.present?
      @logger.set_maximum_line(limit)
      render json: {status: "ok"}
    else
      render json: {status: "invalid line limit"}
    end
  end

  private
  def check_if_number(s)
    number = s.to_i
    number = nil if number.to_s != s
    number
  end
end