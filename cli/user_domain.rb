require 'thor'
require './model'

# Subclass UserDomain to manage connections between users and domains
class UserDomain < Thor
  desc 'add <user> <domain>', 'Add a domain to a user'
  def add(user, domain)
    user = Vuser.first name: user
    domain = Vdomain.first name: domain
    user.vdomains << domain
    user.raise_on_save_failure = true
    user.save
    puts "Successfully added domain '#{domain.name}' to user '#{user.name}'"
  end

  desc 'remove <user> <domain>', 'Remove a domain from a user'
  def remove(user, domain)
    user = Vuser.first name: user
    domain = Vdomain.first name: domain
    user.vdomains.remove domain
    user.raise_on_save_failure = true
    user.save
    puts "Successfully removed domain '#{domain.name}' from user '#{user.name}'"
  end

  desc 'list <user>', 'List domains of a user'
  def list(user)
    user = Vuser.first name: user
    puts "Domains of user '#{user.name}'"
    user.vdomains.each do |vdomain|
      puts "#{vdomain.id} | #{vdomain.name}"
    end
  end
end
