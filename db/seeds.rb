# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
require 'json'
require 'open-uri'
require 'time'

ActiveRecord::Base.transaction do
# USER SEED ==============================
  User.destroy_all

  user_names =  [ "Paul Gonzalez", "Bryan Stanton", "Kevin Biggs", "Dale Madan",
                  "David Hucke", "Steve Magnani", "John Petruso", "Luke Mueller",
                  "Nick Hauser", "Joe Cullen"
                ]

  user_emails = [ "pjg5005@gmail.com", "kevinbiggs17@gmail.com", "bryanstanton24@gmail.com",
                  "dhucke@gmail.com", "lmueller@gmail.com", "paul@crowdgate.us",
                  "jcoin11@gmail.com", "testingemail@gmail.com"
                ]

  user_images = [ "https://scontent-a-ord.xx.fbcdn.net/hphotos-xfa1/v/t1.0-9/1743531_10106178258118094_600695877_n.jpg?oh=a7f0e529c18d0f6f43f43fca18f17132&oe=555CE821",
                  "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xaf1/v/t1.0-1/c31.31.383.383/s320x320/402172_10103290516939564_754937053_n.jpg?oh=4003f2e62832b4b56e765907e0d42dbd&oe=55540F52&__gda__=1431826417_839f632e11a9f8ea9ddb65ce24d25369",
                  "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash2/v/t1.0-1/c15.10.131.131/61242_10100467179984454_4859973_n.jpg?oh=b2d8ffa57d087134be9daf54be6dd039&oe=555A53FB&__gda__=1433229676_cc16e9e17f47e8257c7003fa7f3176d9",
                  "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xfp1/v/t1.0-1/c21.47.257.257/970513_611914577711_1328640039_n.jpg?oh=37babb93bf4fc2bf159a0273ef9ee497&oe=55688638&__gda__=1432774080_aed31866ad5271521007424dcbbaff1a",
                  "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xap1/v/t1.0-1/p320x320/1531787_781788567752_925362562_n.jpg?oh=e0dda7de4965c4776b6f2a42cbc2250c&oe=556695A0&__gda__=1431764372_bf629fe94ecdc82c4dcf8078e5533ebb",
                  "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xap1/v/t1.0-1/p320x320/10898075_10101671910714745_5517691784609229455_n.jpg?oh=2261cca9ac55bc63d8831aba32d16044&oe=55210B22&__gda__=1432818935_5471c4e3b9c22779f03b6a880f45392c",
                  "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xpf1/v/t1.0-1/10407584_10205817415584434_2049047287814936602_n.jpg?oh=8174b0b2832e8ac0b0238d955745edd0&oe=5557757F&__gda__=1433064551_b145e142db2f5850b37b494f626e94c2",
                  "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xpf1/v/t1.0-1/c12.16.156.156/293236_10100783830579119_209233_n.jpg?oh=5ea848b1fd49d2c568a588029d97b438&oe=556E1553&__gda__=1432496203_102f9aafa053442d7683895188c02134"
                ]

  50.times do |n|
    User.create!( :name => user_names.sample,
                  :email => "#{n+1}#{user_emails.sample}",
                  :image => user_images.sample,
                  :password => "12345678"
                  )

  end

  users = User.all

  puts "#{users.count} users have been created"

# EVENT SEED ====================================================
  Event.destroy_all
    search = "Penn State Football"
    safe_search = URI.encode(search)
    url = "http://api.eventful.com/json/events/search?app_key=mW23BC9SZCPfrVgP&keywords=#{safe_search}&date=Future"

    parsed_data = JSON.parse(open(url).read)
    @events = parsed_data["events"]["event"]

    @events.each do |event|
      new_event = Event.new
      new_event.name = event["title"]
      new_event.venue = event["venue_name"]
      new_event.city = event["city_name"]
      new_event.state = event["region_abbr"]
      new_event.ap_id = event["id"]
      new_event.api_modified = event["modified"]

      time = Time.parse(event["start_time"])
      date = Time.parse(event["start_time"])

      new_event.time = time.strftime("%I:%M%p, %Z")
      new_event.date = date.strftime("%A, %B %d, %Y")
      new_event.save
    end

  events = Event.all

  puts "#{events.count} events have been created"

# TAILGATE SEED ==========================
  choice = [true, false]
  images = [
           "http://news.tailgatingwars.com/wp-content/uploads/2013/01/TailgatingEssential-location-ncaa-bosie-state-1024x680.jpg",
           "https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xfa1/v/t1.0-9/10624635_1536542439943997_1456801741491328204_n.jpg?oh=c09529bbf61f7febe0061106a0e84a41&oe=5563F998&__gda__=1429189907_c62af91b5603b7bc384976ae12548352",
           "https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpa1/t31.0-8/10648279_1504897949775113_8883815475331419429_o.jpg",
           "https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xap1/t31.0-8/10547971_1504896163108625_8317675297807138613_o.jpg"
           ]



  Tailgate.destroy_all
  20.times{
   Tailgate.create!( name: "Tailgate of the Century. Don't want to miss",
                     description: "Our tailgates have been voted the best at Penn State. We always have regular tailgate food- burgers, hot dogs, etc. We also make salads and chili. We tend to get into some intense corn hole games, and we always keep the beers flowing.",
                     user_id: users.pluck(:id).sample,
                     event_id: events.pluck(:id).sample,
                     size: rand(1..100),
                     price: rand(1..100),
                     affiliation: "Neither",
                     grill: choice.sample,
                     tent: choice.sample,
                     table: choice.sample,
                     chairs: choice.sample,
                     reserved_parking: choice.sample,
                     bevs_alcohol: choice.sample,
                     bevs_non_alcohol: choice.sample,
                     food: choice.sample,
                     tailgate_start_time: "3 hours before kickoff",
                     tailgate_during_game: false,
                     image_1: images.sample,
                     image_2: images.sample,
                     image_3: images.sample,
                     image_4: images.sample
                   )
  }

  tailgates = Tailgate.all

  puts "#{tailgates.count} tailgates have been created"

# REVIEWS SEED ==========================
  Review.destroy_all
  250.times{
   Review.create!(  user_id: users.pluck(:id).sample,
                    tailgate_id: tailgates.pluck(:id).sample,
                    rating: rand(0..5),
                    review: "This host was phenomenal. They did a great job of being communicative before the event, and actually handle our special requests. On gameday, they were a lot of fun and went out of their way to make sure we were having a great time. All around a great experience, would definitely use this host again."
                  )
 }

end

  puts "#{Review.all.count} reviews have been created"

# TEAMS SEED

  Team.destroy_all

  Team.create!( name: "Penn State",
                headline: "We are...",
                background_image: "https://pennstatermag.files.wordpress.com/2011/09/med-beaver-stadium-panorama.jpg",
                color: "#152852"
              )

  Team.create!( name: "Texas A&M",
                headline: "Gig 'Em",
                background_image: "http://www.glenvigus.com/wordpress/wp-content/uploads/2009/09/Kyle_UAB_Panorama.jpg",
                color: "#63000D"
              )

  Team.create!( name: "South Carolina",
                headline: "GoooOOO Cocks!",
                background_image: "http://media.gogamecocks.com/static/images/wallpaper/usccitadel2011/usccitadel1.jpg",
                color: "#750004"
              )


  puts "#{Team.all.count} teams have been created"

