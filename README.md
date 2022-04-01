# README

A simple application that get random data from [https://randomuser.me/](https://randomuser.me/) and store it in a database.

For the purpose of this project, I decided to use [Ruby on Rails](https://rubyonrails.org/) as the web framework, and [PostgreSQL](https://www.postgresql.org/) as the database. Also, Bootstrap is used for the frontend.

* Ruby version
    3.0.2

* System dependencies
    - gem 'aws-sdk-s3' (for S3 storage)
    - gem 'kaminari'   (for pagination)
    - gem 'bootstrap'  (for styling)

    
* Database creation
    - `bundle exec rake db:create`
    - `bundle exec rake db:migrate`

* Database initialization
    - `bundle exec rake db:seed`


* How to run the test suite 
    Just run `rails test`

* Deployment
    - I've deployed the application on Heroku, you can view it [here](https://gigaservices.herokuapp.com/)



About this project
==================
It's been a while since I've worked on a project using Ruby, so some of the code is a bit messy. I've tried to make it as simple as possible, but I've also tried to keep it as clean as possible. I've also tried to keep it as readable as possible, with some comments.

I tried to use the CarrierWave gem for uploading images, but I couldn't get it to work. So I used the AWS S3 gem instead because I'm more familiar with it.

Another gem that I haven't used in a while is Bootstrap. I've used it for styling the application, but I haven't used it for anything else. Honestly, Bootstrap is really neat, and is really easy to forget about how simple it is to use it. Definitely worth coming back to it.

One big problem with this project is that it's not very scalable. I've tried to keep the number of users in the database to a minimum, and I've also tried to keep the number of images in the database to a minimum. Even though both Heroku and AWS S3 have a free tier, it's still not ideal.

Since there's no authentication, is really easy to a user to upload a lot of images and essentially break the application.

Another problem is a classic: monolithism. Everything is one big application. In hindsight, I should've used a microservice architecture or at least make two diferents repositories, but I didn't have time to do that.

I gave myself 5 hours to complete this project, and I'm pretty satisfied with the result. I'm sure that's missing something, but I'm happy with the result overall.

Possible improvements would be:
    - Add authentication
    - Better styling
    - Wrap the logic of the application in a service class/microservice
    - Limit the number of images in the database per user
    - Some performance improvements with refactoring
    - Add way more tests
    - Maybe create a PWA for the application, Vue.js would be a good choice


Thanks! :)