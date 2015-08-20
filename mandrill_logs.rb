# This is called from the mandrill.yml Ansible playbook.
# Mandrill API docs: https://mandrillapp.com/api/docs/
require 'mandrill'

begin 
  mandrill = Mandrill::API.new 'API_KEY'
  result = mandrill.messages.search
  rejects = result.select{|msg| msg.has_value?('rejected')}
  puts rejects
rescue Mandrill::Error => e
  # Mandrill errors are thrown as exceptions
  puts "A mandrill error occurred: #{e.class} - #{e.message}"
  # Ai mandrill error occurred: Mandrill::ServiceUnavailableError - Service Temporarily Unavailable    
  raise
end
