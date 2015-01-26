# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# USER SEED ==============================
User.destroy_all
User.create (  :name => "Paul G.",
               :email => "pjg5005@gmail.com",
               :imgage => "https://media.licdn.com/mpr/mpr/shrink_200_200/p/8/005/0a3/13c/3af7967.jpg"
               )

# TAILGATE SEED ==========================

choice = [true, false]
images = [
          "http://news.tailgatingwars.com/wp-content/uploads/2013/01/TailgatingEssential-location-ncaa-bosie-state-1024x680.jpg",
          "https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xfa1/v/t1.0-9/10624635_1536542439943997_1456801741491328204_n.jpg?oh=c09529bbf61f7febe0061106a0e84a41&oe=5563F998&__gda__=1429189907_c62af91b5603b7bc384976ae12548352",
          "https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpa1/t31.0-8/10648279_1504897949775113_8883815475331419429_o.jpg",
          "https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xap1/t31.0-8/10547971_1504896163108625_8317675297807138613_o.jpg"
          ]

Tailgate.destroy_all
30.times{
  Tailgate.create(  name: "Tailgate of the Century. Don't want to miss",
                    description: "Our tailgates have been voted the best at Penn State. We always have regular tailgate food- burgers, hot dogs, etc. We also make salads and chili. We tend to get into some intense corn hole games, and we always keep the beers flowing.",
                    user_id: 1,
                    event_id: rand(2..10),
                    size: rand(1..100),
                    price: rand(1..100),
                    affiliation: "Neither",
                    grill: choice[rand(0..1)],
                    tent: choice[rand(0..1)],
                    table: choice[rand(0..1)],
                    chairs: choice[rand(0..1)],
                    reserved_parking: choice[rand(0..1)],
                    bevs_alcohol: choice[rand(0..1)],
                    bevs_non_alcohol: choice[rand(0..1)],
                    food: choice[rand(0..1)],
                    tailgate_start_time: "3 hours before kickoff",
                    tailgate_during_game: false,
                    image_1: images[rand(0..3)],
                    image_2: images[rand(0..3)],
                    image_3: images[rand(0..3)],
                    image_4: images[rand(0..3)]
                  )
}

Booking.destroy_all
