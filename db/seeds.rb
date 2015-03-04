require 'json'
require 'open-uri'
require 'time'

# USER SEED ==============================
User.destroy_all

User.create!( :name => "Paul Gonzalez",
              :email => "paul@crowdgate.us",
              :image => "https://media.licdn.com/mpr/mpr/shrinknp_200_200/p/8/005/0a3/13c/3af7967.jpg",
              :password => "12345678",
              :password_confirmation => "12345678",
              :admin => true,
              :host_status => true
            )


50.times do |n|
  User.create!( :name => Faker::Name.name,
                :email => Faker::Internet.safe_email,
                :image => Faker::Avatar.image,
                :password => "12345678",
                :description => "I have been tailgating at Penn State games for the past 10 years. My wife and I have never missed a home game, and the parking lot at Beaver Stadium is one of our favorite places in the world. It is always our goal to make our guests' experiences as great as possible. If you have any questions, do not hesitate to contact me in advance."
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
  new_event.date = DateTime.parse(event["start_time"])
  new_event.time = DateTime.parse(event["start_time"])
  new_event.save
end

events = Event.all

puts "#{events.count} events have been created"

# TAILGATE SEED ==========================

images = [
 "http://a.espncdn.com/photo/2013/0815/ncf_tailgate_07.jpg",
 "https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xfa1/v/t1.0-9/10624635_1536542439943997_1456801741491328204_n.jpg?oh=c09529bbf61f7febe0061106a0e84a41&oe=5563F998&__gda__=1429189907_c62af91b5603b7bc384976ae12548352",
 "https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpa1/t31.0-8/10648279_1504897949775113_8883815475331419429_o.jpg",
 "https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xap1/t31.0-8/10547971_1504896163108625_8317675297807138613_o.jpg"
]

tailgate_names = [  "Tailgate of the Century. Don't want to miss",
                    "Cornhole, food and more. Great people!",
                    "We keep the food warm and the beer cold!",
                    "Tailgating the right way. Food, beer and more." ]

sample_numbers = [20, 25, 40, 50, 15]

Tailgate.destroy_all

10.times do
PaidTailgate.create!( name: tailgate_names.sample,
                      description: "Our tailgates have been voted the best at Penn State. We always have regular tailgate food- burgers, hot dogs, etc. We also make salads and chili. We tend to get into some intense corn hole games, and we always keep the beers flowing.",
                      host_id: users.pluck(:id).sample,
                      event_id: events.pluck(:id).sample,
                      original_size: sample_numbers.sample,
                      current_size: sample_numbers.sample,
                      price: sample_numbers.sample,
                      affiliation: "Neither",
                      grill: rand(2),
                      tent: rand(2),
                      table: rand(2),
                      chairs: rand(2),
                      reserved_parking: rand(2),
                      bevs_alcohol: rand(2),
                      bevs_non_alcohol: rand(2),
                      food: rand(2),
                      tailgate_start_time: "3 hours before kickoff",
                      tailgate_during_game: false,
                      image_1: images.sample,
                      image_2: images.sample,
                      image_3: images.sample,
                      image_4: images.sample
                    )
end


FreeTailgate.create!( name: tailgate_names.sample,
                      description: "Our tailgates have been voted the best at Penn State. We always have regular tailgate food- burgers, hot dogs, etc. We also make salads and chili. We tend to get into some intense corn hole games, and we always keep the beers flowing.",
                      host_id: users.pluck(:id).sample,
                      event_id: events.pluck(:id).sample,
                      original_size: sample_numbers.sample,
                      current_size: sample_numbers.sample,
                      affiliation: "Neither",
                      grill: rand(2),
                      tent: rand(2),
                      table: rand(2),
                      chairs: rand(2),
                      reserved_parking: rand(2),
                      bevs_alcohol: rand(2),
                      bevs_non_alcohol: rand(2),
                      food: rand(2),
                      tailgate_start_time: "3 hours before kickoff",
                      tailgate_during_game: false,
                      image_1: images.sample,
                      image_2: images.sample,
                      image_3: images.sample,
                      image_4: images.sample
                    )

PackagedTailgate.create!( name: tailgate_names.sample,
                          description: "Our tailgates have been voted the best at Penn State. We always have regular tailgate food- burgers, hot dogs, etc. We also make salads and chili. We tend to get into some intense corn hole games, and we always keep the beers flowing.",
                          host_id: users.pluck(:id).sample,
                          event_id: events.pluck(:id).sample,
                          price: 500,
                          affiliation: "Neither",
                          grill: rand(2),
                          tent: rand(2),
                          table: rand(2),
                          chairs: rand(2),
                          reserved_parking: rand(2),
                          bevs_alcohol: rand(2),
                          bevs_non_alcohol: rand(2),
                          food: rand(2),
                          tailgate_start_time: "3 hours before kickoff",
                          tailgate_during_game: false,
                          image_1: images.sample,
                          image_2: images.sample,
                          image_3: images.sample,
                          image_4: images.sample
                        )

tailgates = Tailgate.all

puts "#{tailgates.count} tailgates have been created"

# REVIEWS SEED ==========================
Review.destroy_all
50.times{
 Review.create!(  user_id: users.pluck(:id).sample,
                  tailgate_id: tailgates.pluck(:id).sample,
                  rating: rand(3..5),
                  review: "This host was phenomenal. They did a great job of being communicative before the event, and actually handle our special requests. On gameday, they were a lot of fun and went out of their way to make sure we were having a great time. All around a great experience, would definitely use this host again."
                )
}

puts "#{Review.all.count} reviews have been created"

# TEAMS SEED

Team.destroy_all
Team.create!( name: "Penn State",
              headline: "We are...",
              background_image: "https://pennstatermag.files.wordpress.com/2011/09/med-beaver-stadium-panorama.jpg",
              color: "#152852",
              sport: "College Football"
            )

Team.create!( name: "Texas A&M",
              headline: "Gig 'Em",
              background_image: "http://www.glenvigus.com/wordpress/wp-content/uploads/2009/09/Kyle_UAB_Panorama.jpg",
              color: "#63000D",
              sport: "College Football"
            )

Team.create!( name: "South Carolina",
              headline: "GoooOOO Cocks!",
              background_image: "http://media.gogamecocks.com/static/images/wallpaper/usccitadel2011/usccitadel1.jpg",
              color: "#750004",
              sport: "College Football"
            )

puts "#{Team.all.count} teams have been created"

