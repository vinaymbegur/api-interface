module API

  module Twitter

    def self.tweets username
      $client.search("from:#{username}", result_type: "recent").take(10)
    end

  end

  module GitHub

    def self.user username
      response = Typhoeus.get("https://api.github.com/users/#{username}")
      JSON.parse(response.body)
    end

    def self.repos username
      github = Github.new :oauth_token => GITHUB_TOKEN
      github.repos.list(user: username).map(&:full_name)
    end

  end

  module RubyGems

    def self.published username
      Gems.gems(username).map{|g| g["name"]}
    end

  end

end