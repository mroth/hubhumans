require "hubhumans/version"
require "octokit"

module Hubhumans
  
  def Hubhumans.humanify(org_name)
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

end
