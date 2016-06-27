require 'thor'
require './model'
require './cli/domain'
require './cli/user'
require './cli/alias'

module MailmgrCLI
  # CLI for managing mail-database defined in model.rb
  class Mailmgr < Thor
    desc 'user SUBCOMMAND ...ARGS', 'Manage users'
    subcommand 'user', User

    desc 'domain SUBCOMMAND ...ARGS', 'Manage domains'
    subcommand 'domain', Domain

    desc 'alias SUBCOMMAND ...ARGS', 'Manage aliases'
    subcommand 'alias', Alias
  end
end

MailmgrCLI::Mailmgr.start ARGV
