require 'yard'
require_relative "./yard/clean/version"
require_relative "./yard/cli/clean"

YARD::CLI::CommandParser.commands[:clean] = YARD::CLI::Clean