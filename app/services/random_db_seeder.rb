class RandomDbSeeder
    require 'net/http'
    require 'uri'
    require 'open-uri'
    require 'json'

    $URL = "https://randomuser.me/api/"
    
    
    def initialize(limit = 30, seed = 'giga', responseFormat = 'json', inc = 'gender,dob,phone,name,email,Picture', nat = 'br')
        @responseFormat = responseFormat
        @limit = limit
        @inc = inc
        @nat = nat
        @seed = seed
    end

    # Seeds the database with data from randomuser.me
    def seed_users
        # Creates a url with the parameters specified in the constructor
        uri = URI($URL + 
                 "?format="+@responseFormat+
                 "&results="+@limit.to_s+
                 "&inc="+@inc+
                 "&nat="+@nat+
                 "&seed="+@seed)
        
        # Makes a request to the url
        res = Net::HTTP.get_response(uri)
        body = JSON.parse(res.body) 

        # Gets the results from the response
        users = body["results"]

        # Creates a new user for each result
        users.each do |user|
            u = User.new
            u.name = user["name"]["first"] + " " + user["name"]["last"]
            u.title = user["name"]["title"]
            u.gender = user["gender"]
            u.age = user["dob"]["age"]
            u.email = user["email"]
            u.phone = user["phone"]

            url = URI.parse(user["picture"]["large"].to_s)
            filename = File.basename(url.path)
            file = URI.open(url)
            
            u.avatar.attach(io: file, filename: filename)
           
            u.save!
        end
        # Returns the list of users created
        return users
    end
end