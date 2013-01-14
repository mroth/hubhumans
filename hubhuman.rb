#!/usr/bin/env ruby
require 'octokit'

def bail
  abort "usage: #{File.basename(__FILE__)} [organization_name]"
end

def humanify(org_name)
  client = Octokit::Client.new(:auto_traversal => true)
  gh_org = client.organization_members(org_name)
  puts "/* TEAM */"
  puts
  gh_org.each do |member|
    user = client.user member.login
    puts "  #{user.name} (#{user.login})"
    puts "  Site: #{user.blog}" unless user.blog.nil?
    puts "  Location: #{user.location}" unless user.location.nil?
    puts
  end
end

bail if ARGV[0].nil?
humanify(ARGV[0])
