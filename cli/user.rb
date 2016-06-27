require 'thor'
require './model'
require './cli/user_domain'

module MailmgrCLI
  # Subclass User to manage virtual users
  class User < Thor
    # SUBDOMAINS
    desc 'domain SUBCOMMAND ...ARGS', 'Manage user-domain relations'
    subcommand 'domain', UserDomain

    desc 'add <name> <password>', 'Add a new user'
    def add(name, password)
      if password.length > 120
        raise 'Password too long!'
      end
      user = Vuser.new name: name, password: password
      user.raise_on_save_failure = true
      user.save
      puts "Successfully added user '#{user.name}'"
    end

    desc 'remove <name>', 'Remove a user'
    def remove(name)
      users = Vuser.all name: name
      users.each do |user|
        # remove domain-relations
        (VdomainVuser.all vuser: user).destroy
      end
      user.destroy
      puts "Successfully removed user '#{name}'"
    end

    desc 'list', 'List all users'
    def list
      Vuser.all.each do |user|
        puts "#{user.id} | #{user.name}"
      end
    end
  end
end
