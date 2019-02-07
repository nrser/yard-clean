# Requirements
# ============================================================================

require 'yard'
require_relative "../clean/version"


# Namespace
# ============================================================================

module YARD
module CLI

class Clean < YardoptsCommand
  
  # String to explain `yard clean` in `yard help` output. Also used in the 
  # command help messages for the command itself.
  # 
  # @return [String]
  # 
  def description
    'Remove the database files.'
  end
  
  
  # Runs the command, removing the DB directory (if it exists and *is* a 
  # directory).
  #
  # @param [Array<String>] args
  #   Shell-split arguments from the CLI.
  # 
  # @return [nil]
  # 
  # @note
  #   Exits the program on failure.
  # 
  def run *args_and_opts
    args = parse_arguments *args_and_opts
    
    unless args.empty?
      log.warn  "`yard clean` does not accept arguments (only options), " +
                "found #{ args.inspect }. See `yard clean --help` for usage."
    end
    
    # This gets set to the correct DB file location by {#optparse}, which is
    # run *first* for any yardopts file, then for any CLI options. If the DB
    # option is found in neither, it will remain at it's default `.yardoc`
    db = YARD::Registry.yardoc_file
    
    if File.exists? db
      if File.directory? db
        log.info "Found DB directory at #{ db.inspect }, removing..."
        FileUtils.rm_rf db
      
      else
        log.error "DB path #{ db.inspect } exists, but is NOT a directory!"
        log.error "Exiting..."
        exit false
      end
    else
      log.info "DB path #{ db.inspect } does no exist, nothing to do."
    end
    
    log.info "Done."
    
    nil
  end # #run
  
  
  # Parse argument strings. Called by {YARD::CLI::YardoptsCommand} for *both*
  # the yardopts file (if any) and the CLI arguments.
  # 
  # We kick this off with our call to
  # {YARD::CLI::YardoptsCommand#parse_arguments} up in {#run}.
  # 
  # @param [Array<String>] args
  #   Shell-split argument strings (including options/switches).
  # 
  # @return [Array<String>]
  #   The non-option arguments remaining after option parsing.
  # 
  def optparse *args
    opts = OptionParser.new
    opts.banner = "Usage: yard clean [options]"
    opts.separator "" 
    opts.separator description
    opts.separator ""
    opts.separator "Options:"
    
    opts.on('-b', '--db FILE', 'Use a specified .yardoc db to load from or save to',
                  '  (defaults to .yardoc)') do |yardoc_file|
      YARD::Registry.yardoc_file = yardoc_file
    end
    
    opts.on_tail('-q', '--quiet', 'Show no warnings.') {
      log.level = Logger::ERROR
    }
    
    opts.on_tail('--verbose', 'Show more information.') {
      log.level = Logger::INFO
    }
    
    opts.on_tail('--debug', 'Show debugging information.') {
      log.level = Logger::DEBUG
    }
    
    opts.on_tail('-v', '--version', 'Show version information.') {
      log.puts "yard clean #{YARD::Clean::VERSION}"
      exit
    }
    
    opts.on_tail('--bare-version', 'Show JUST version.') {
      log.print "#{YARD::Clean::VERSION}"
      exit
    }
    
    opts.on_tail('-h', '--help', 'Show this help.')  {
      log.puts opts
      exit
    }
    
    parse_options opts, args
    
    args
  end # #optparse
  
  
  # Callback when an unrecognized option is parsed. We ignore 'em... there are
  # *many* options that can be defined in the *yardopts* that we don't handle
  # and don't care about.
  #
  # @param [OptionParser::ParseError] err the exception raised by the
  #   option parser
  def unrecognized_option err
    # pass
  end
      
end # class Clean

# /Namespace
# ============================================================================

end # module CLI
end # module YARD
