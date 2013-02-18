require "hubhumans/version"
require "octokit"

module Hubhumans
  
  class Humanifier
    attr_reader :client

    def initialize
      @client = Octokit::Client.new(:auto_traversal => true)
    end

    def render_for_org(org_name)
      gh_org = @client.organization_members(org_name)
      output = "/* TEAM */\n"
      gh_org.each do |member|
        output << self.render_user(member.login)
      end
      output
    end

    def render_user(login)
      user = @client.user(login)
      output = ""
      output << "  #{format_name(user.name,user.login)}\n"
      output << "  Site: #{user.blog}\n" unless user.blog.nil?
      output << "  Location: #{user.location}\n" unless user.location.nil?
      output + "\n"
    end

    protected
    def format_name(user_name, user_login)
      return user_login if user_name.nil?
      "#{user_name} (#{user_login})"
    end

  end

end
