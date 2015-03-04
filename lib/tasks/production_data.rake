namespace :production_data do

  desc "Adds real data in production"
  task add_data: :environment do
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
                  sport: "College Baseball"
                  )

    Team.create!( name: "LSU",
                  headline: "Geaux Tigers",
                  background_image: "http://www.wbrz.com/images/news/sports/lsubaseball/katzhomer123.JPG",
                  color: "#4E2482",
                  sport: "College Baseball"
                  )

    Team.create!( name: "Arizone Cardinals",
                  headline: "",
                  background_image: "",
                  color: "",
                  sport: "NFL"
                  )
  end

end
