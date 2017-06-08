class WhatAWorld::CLI
    def call
        puts "Welcome!"
        again = true
        while again
            countries = []
            letter = select_letter
            scraper = WhatAWorld::Scraper::ScraperCli.new(letter)
            countries = scraper.all #=> returns array of letter of country

            country_name = get_country(countries)

            country = WhatAWorld::Country.new(country_name)
            country.scrape  
            country.get_issues

            #print_results(country)
            again = again?
#binding.pry
        end


     end

    def select_letter
        
        letter = nil
        while !(/\A[A-Z]\z/.match(letter))
            puts "Select A-Z"
            print ":"
            letter = gets.strip.upcase 
        end 
        letter
    end

    def get_country(countries)
        index = 0
        number = 0
        countries.each{|country|
            index += 1
            puts "#{index}. #{country}"
        }
        while !number.between?(1, index)
            puts "Choose a country by number"
            number = gets.strip.to_i
        end
        countries[number - 1]    
    end

    def print_results(country)

    end

    def again?
        repeat = true
        while repeat
            puts "Would you like to look at more data?"
            puts "type 'yes' or 'no'"
            print ":"
            input = gets.strip.to_s.upcase #catch empty input
            if input != "YES" && input != "NO" && input != "Y" && input != "N"
                repeat = true
            else
                repeat = false
            end
    #binding.pry
        end
        input == "YES" || input == "Y" ? true : false
    end
end