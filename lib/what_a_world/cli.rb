class WhatAWorld::CLI
    def call
        puts "Welcome!"
        again = true
        while again
            countries = []
            letter = select_letter
            scraper = WhatAWorld::Scraper::ScraperCli.new(letter)
            scraper.find_all_countries
            scraper.find_countries_by_letter
            letter_countries = scraper.letter_countries
            letter_url_extensions = scraper.letter_url_extensions

            country_hash = get_country(letter_countries, letter_url_extensions)
            country = WhatAWorld::Country.new(country_hash)
            country.scrape 
    
            country.get_issues
            

            print_results(country)
            again = again?
        end
        puts "Goodbye!"
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

    
    def get_country(letter_countries, letter_url_extensions)
        country_hash = {}
        index = 0
        number = 0
        letter_countries.each{|country|
            index += 1
            puts "#{index}. #{country}"
        }
        while !number.between?(1, index)
            puts "Choose a country by number"
            number = gets.strip.to_i
        end
       country_hash[letter_countries[number - 1]] = letter_url_extensions[number - 1]  
       country_hash  
    end

    def print_results(country)
         name = country.name
         last_updated = country.last_updated
         region = country.region 
         trafficking_label =  country.issues.trafficking_hash.keys.join
         trafficking = country.issues.trafficking_hash.values.join
         drugs_label =  country.issues.drugs_hash.keys.join
         drugs = country.issues.drugs_hash.values.join
         refugees_label =  country.issues.refugees_hash.keys.join
         refugees = country.issues.refugees_hash.values.join
         disputes_label =  country.issues.disputes_hash.keys.join
         disputes = country.issues.disputes_hash.values.join

         puts "##################################"
         puts "``````````````````````````````````"
         puts "#{name}"
         puts "``````````````````````````````````"
         puts "Location: #{region}"
         puts "##################################"
         puts "n#{last_updated}"
         puts "----------------------------------"
         if !trafficking.nil?
            puts "#{trafficking_label}"
            puts "----------------------------------"
            puts "#{trafficking}"
         end
         if !drugs.nil?
            puts "#{drugs_label}"
            puts "----------------------------------"
            puts "#{drugs}"
         end
         if !refugees.nil?
            puts "#{refugees_label}"
            puts "----------------------------------"
            puts "#{refugees}"
         end
         if !disputes.nil?
            puts "#{disputes_label}"
            puts "----------------------------------"
            puts "#{disputes}"
         end
    end

    def again?
        repeat = true
        while repeat
            puts "Would you like to look at more data?"
            puts "Type 'yes' or 'no'"
            print ":"
            input = gets.strip.to_s.upcase #catch empty input
            if input != "YES" && input != "NO" && input != "Y" && input != "N"
                repeat = true
            else
                repeat = false
            end
        end
        input == "YES" || input == "Y" ? true : false
    end
end