require 'logger'

class Log

  @log                  = Logger.new(STDOUT)
  @log.level            = Logger::INFO
  @log.datetime_format  = '%d-%m-%Y (%H:%M:%S) - '

  @step_count = 1

  # used for logging the test-case step
  def self.step(message)
    self.info "STEP #{@step_count} - #{message}"
    @step_count += @step_count
  end

  # log warn message
  def self.warning(message)
    @log.warn message
  end

  # log an error message
  def self.error(message)
    @log.error message
  end

  # log info messages
  def self.info(message)
    @log.info message
  end

end
