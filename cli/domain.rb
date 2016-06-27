require 'thor'
require './model'

module MailmgrCLI
  # Subclass Domain to manage virtual domains
  class Domain < Thor
    desc 'add <name>', 'Add a new domain'
    def add(name)
      domain = Vdomain.new name: name
      domain.raise_on_save_failure = true
      domain.save
      puts "Successfully added domain '#{domain.name}'"
    end

    desc 'remove <name>', 'Remove a domain'
    def remove(name)
      domain = Vdomain.all name: name
      domain.destroy
      puts "Successfully removed domain '#{name}'"
    end

    desc 'list', 'List all domains'
    def list
      Vdomain.all.each do |domain|
        puts "#{domain.id} | #{domain.name}"
      end
    end
  end
end
