class WhatAWorld::CLI
    def call
        countries_by_letter = []
        letter = welcome
        scraper = WhatAWorld::Scraper::ScraperCli.new(letter)
        countries_by_letter = scraper.all #=> returns array of letter of country
puts countries_by_letter
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