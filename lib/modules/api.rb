module API

  # Twitter module
  #
  module Twitter

    # Calls twitters tweets api and gets the data
    #
    def self.tweets username
      $client.search("from:#{username}", result_type: "recent").take(10)
    end

  end

  #Github module
  #
  module GitHub

    # Gets github user information direct from REST api of github
    #
    def self.user username
      response = Typhoeus.get("https://api.github.com/users/#{username}")
      JSON.parse(response.body)
    end

   # Fetches all repositories of the user and passes back only
   # repo names to calling method
   #
    def self.repos username
      github = Github.new :oauth_token => GITHUB_TOKEN
      github.repos.list(user: username).map(&:full_name)
    end

  end

  # RubyGems module
  #
  module RubyGems

    # Reads all published gems of a user
    #
    def self.published username
      Gems.gems(username).map{|g| g["name"]}
    end

  end

end