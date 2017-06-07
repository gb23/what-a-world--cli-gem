class WhatAWorld::CLI
    def call
        letter = welcome
        scraper = WhatAWorld::Scraper::ScraperCli.new(letter)
        #scraper.all => returns array of letter of country
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

end