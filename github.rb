require 'octokit'

Octokit.auto_paginate = true

client = Octokit::Client.new(:access_token => "personal_access_token_here")

user = client.user
user.login

puts "Started up and authenticated with access token"

orgs = client.org_teams('org_name_here')

puts "Retrieved teams"

members = client.org_members("org_name_here")

puts "Retrieved users"

orgs.each do |org|
  puts "Listing teams: \n #{org.name} id: #{org.id}"
  if org.name == "global-read"
    @global_read_team = org.id
  end
end

members.each do |mem|
  puts "adding #{mem.login} to the global-read team in Github"
  client.add_team_member(@global_read_team, "#{mem.login}")
end
