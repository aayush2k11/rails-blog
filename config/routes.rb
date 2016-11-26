Rails.application.routes.draw do
  post 'config_logger' => 'logs#config_logger'
  post 'log_message' => 'logs#log_message'
  post 'config_max_line_limit' => 'logs#config_max_line_limit'
end
