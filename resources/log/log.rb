require 'logger'

##
# Class that contains the Log methods/interactions
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

  # Prints the final counts
  def self.print_counts
    info 'Final Log Counts'
    info "Steps #{get_steps_count}"
    info "Errors #{get_errors_count}"
  end



  private

  # Decreases one from the count
  # since the last interaction will add +1 to the count
  # and it doesn't decreases if the count hasn't started yet
  def self.get_steps_count
    if @step_count == 0
      return @step_count
    end
    @step_count-1
  end

  # Decreases one from the count
  # since the last interaction will add +1 to the count
  # and it doesn't decreases if the count hasn't started yet
  def self.get_errors_count
    if @error_count == 0
      return @error_count
    end
    @error_count-1
  end

end
