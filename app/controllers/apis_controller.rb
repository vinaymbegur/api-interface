class ApisController < ApplicationController

	include API

	def index

	end

	def result
		username = params[:username]

	  begin
	  	@twitter = API::Twitter.tweets username
	  rescue Exception => e
	  	@twitter = []
	  end

	  begin
	  	@github_user = API::GitHub.user username
	  	@github_repos = API::GitHub.repos username
	  rescue Exception => e
	  	@github_user = ""
		  @github_repos = []
	  end

	  begin
	  	@gems = API::RubyGems.published username
	  rescue Exception => e
	  	@gems = []
	  end

	  render "result"
	end

end
