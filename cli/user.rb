require 'thor'
require './model'

module MailmgrCLI
  # Subclass User to manage virtual users
  class User < Thor
    desc 'add <name> <password> <domain>', 'Add a new user'
    def add(name, password, domain)
      raise 'Password too long!' if password.length > 120
      domain = Vdomain.first name: domain
      user = Vuser.new name: name, vdomain: domain, password: password
      user.raise_on_save_failure = true
      user.save
      puts "Successfully added user '#{user.name}'"
    end

    desc 'remove <name>', 'Remove a user'
    def remove(name)
      (Vuser.all name: name).destroy
      puts "Successfully removed user '#{name}'"
    end

    desc 'list', 'List all users'
    def list
      Vuser.all.each do |user|
        puts "#{user.id} | #{user.name}@#{user.vdomain.name}"
      end
    end
  end
end
