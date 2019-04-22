require 'logger'

class Log

  @log                  = Logger.new(STDOUT)
  @log.level            = Logger::INFO
  @log.datetime_format  = '%d-%m-%Y (%H:%M:%S) - '

  @step_count   = 1
  @error_count  = 0

  # Logs a message with a step count
  # so it's easier to trace the test-case
  def self.step(message)
    self.info " \n ------------------ \n STEP #{@step_count} - #{message} \n ------------------"
    @step_count += 1
  end

  # Log a warn message
  def self.warning(message)
    @log.warn message
  end

  # Log an error message
  def self.error(message)
    @log.error message
    @error_count += 1
  end

  # Log info messages
  def self.info(message)
    @log.info message
  end

end
