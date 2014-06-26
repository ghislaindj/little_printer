ActiveSupport::Logger::SimpleFormatter.class_eval do
  SEVERITY_TO_TAG_MAP     = {'DEBUG'=>'[^_^]', 'INFO'=>'[-_-]', 'WARN'=>'[o_O]', 'ERROR'=>'[@_@]', 'FATAL'=>'[x_x]', 'UNKNOWN'=>'???'}
  USE_HUMOROUS_SEVERITIES = true
 
  def call(severity, time, progname, msg)
    if USE_HUMOROUS_SEVERITIES
      formatted_severity = sprintf("%-5s","#{SEVERITY_TO_TAG_MAP[severity]}")
    else
      formatted_severity = sprintf("%-5s","#{severity}")
    end
 

    # colorize methods thanks to "colored" gem
    case severity
      when 'INFO'
        result = "#{msg.strip } \n"
      when 'DEBUG'
        result = "#{formatted_severity.cyan if msg.present?} #{msg.strip.cyan} \n"
      when 'WARN'
        result = "#{formatted_severity.yellow} #{msg.strip.yellow} \n"
      when 'ERROR'
        result = "#{formatted_severity.red} #{msg.strip.red} \n"
      when 'FATAL'
        result = "#{formatted_severity.red} #{msg.strip.underline.red} \n"
      when 'UNKNOWN'
        result = "#{formatted_severity} #{msg.strip.underline.cyan_on_yellow} \n"
    end
    result
  end
end