require 'thor'
require './model'

module MailmgrCLI
  # Subclass Alias to manage virtual aliases
  class Alias < Thor
    desc 'add <source> <domain> <target>', 'Add a new alias'
    def add(source, domain, target)
      target = Vuser.first name: target
      domain = Vdomain.first name: domain
      a = Valias.new source: source, vuser_id: target.id, vdomain_id: domain.id
      a.raise_on_save_failure = true
      a.save
      puts "Successfully added alias '#{source.name}@#{domain.name}' =>"
      "'#{target.name}'"
    end

    desc 'remove <id>', 'Remove an alias by id'
    def remove(id)
      Valias.get!(id).destroy
    end

    desc 'list', 'List all aliases'
    def list
      Valias.all.each do |valias|
        domain = Vdomain.get(valias.vdomain_id)
        puts "#{valias.id} | #{valias.source}@#{domain.name} =>"
        " #{Vuser.get(valias.vuser_id).name}"
      end
    end
  end
end
