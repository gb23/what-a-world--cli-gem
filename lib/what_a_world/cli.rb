class WhatAWorld::CLI
    def call
        countries = []
        letter = welcome
        scraper = WhatAWorld::Scraper::ScraperCli.new(letter)
        countries = scraper.all #=> returns array of letter of country

        country_name = get_country(countries)
        country = WhatAWorld::Country.new(country_name)
        country.scrape  
        #country obj now has name, lastupdated, region.
        country.get_issues




     end

    def welcome
        puts "Welcome!"
        letter = nil
        while !(/\A[A-Z]\z/.match(letter))
            puts "Select A-Z"
            print ":"
            letter = gets.strip.upcase 
        end 
        letter
    end

    def get_country(countries)
        #enumerate a list
        #get country from number
        #return country
    end

end