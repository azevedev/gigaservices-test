class RandomDbSeeder
    require 'net/http'
    require 'uri'
    require 'open-uri'
    require 'json'
    def initialize(limit =' 30', seed = 'giga', responseFormat = 'json', inc = 'gender,dob,phone,name,email,Picture', nat = 'br')
        @responseFormat = responseFormat
        @limit = limit
        @inc = inc
        @nat = nat
        @seed = seed
    end

    def seed_users
        uri = URI("https://randomuser.me/api/?format="+@responseFormat+"&results="+@limit+"&inc="+@inc+"&nat="+@nat+"&seed="+@seed)
        res = Net::HTTP.get_response(uri)
        body = JSON.parse(res.body) 

        users = body["results"]

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
        return users
    end
end