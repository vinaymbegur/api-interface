class ApisController < ApplicationController

	include API

	# Root action and renders a index page which contains a form
	# to take usernames of twitter, github or rubygems
	#
	def index

	end

	# Usernames will get submitted here as POST
	# Hits api's of twitter, github and rubygems
	# If any erros between api interactions, corresponding
	# variables will be assigned with empty in rescue block
	# Renders results page and displays the data collected 
	# from apis with download option
	#
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
