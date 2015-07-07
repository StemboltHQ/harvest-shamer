class Log
  @file = 'log.txt'
  @verbose = false

  class << self
    attr_accessor :file, :verbose
  end

  def self.print_date
    message = "=====#{Time.now.utc}====="
    write message
  end

  def self.new_section
    write "\n\n" if any_entries?
  end

  def self.print(message)
    puts message if verbose
    write message
  end

  private

  def self.any_entries?
    open(file, 'a')
    !open(file).readlines.empty?
  end

  def self.write(message)
    open(file, 'a') do |file|
      file.puts message
    end
  end
end
