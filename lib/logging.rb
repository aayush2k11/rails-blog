require 'socket'
class Logging
  @@log = {console_all: false, severity: "DEBUG"}

  def self.log
    @@log
  end

  def initialize
  end

  def set_console(allow_console)
    self.class.log[:console_all] = allow_console == "false" ? false : true
  end

  def set_serverity(level)
    self.class.log[:severity] = level
  end

  def set_maximum_line(mx_line_limit)
    self.class.log[:max_line_limit] = mx_line_limit
  end

  def log_message(message, severity_level)
    severity = self.class.log[:severity]
    console_allowed = self.class.log[:console_all]
    is_allowed = false
    if severity == "TRACE"
      is_allowed = true
    elsif severity == "DEBUG"
      is_allowed = severity_level == "DEBUG" || severity_level == "SEVERE"
    elsif severity == "SEVERE"
      is_allowed = severity_level == "SEVERE"
    end
    file_name = "/Users/aayushgyupta/myProjects/railBlog/application_log.txt"
    line_count = `wc -l "#{file_name}"`.strip.split(' ')[0].to_i
    if self.class.log[:max_line_limit].present? && self.class.log[:max_line_limit] <= line_count
      is_allowed = false
    end
    if is_allowed
      logged_mesage = "#{DateTime.now} " + Socket.gethostname + " " + message
      if console_allowed
        Rails.logger.info(logged_mesage)
      end
      File.open(file_name, "a") do |f|
        f.puts(logged_mesage)
      end
    end
  end
end