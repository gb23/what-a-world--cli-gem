class WhatAWorld::CLI
    def call
        welcome
        again = true
        while again
            letter = select_letter
            if letter != "X"
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
            else
                puts "No locations start with 'X'!"
            end
            again = again?
        end
        goodbye
     end

    def welcome 
        puts "Welcome!"
        sleep(1.0)
        puts "Explore transnational issues on a country-by-country basis."
        sleep (1.0)
        puts "Information provided by the C.I.A."
    end

    def goodbye
        puts "Goodbye and peace to the world!"
    end
    def select_letter
        letter = nil
        puts ""
        while !(/\A[A-Z]\z/.match(letter))
            sleep(0.5)
            puts "Select a country by typing its first letter, A-Z"
            print ":"
            letter = gets.strip.upcase 
        end 
        puts ""
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
            puts ""
            puts "Choose a country by number"
            print ":"
            number = gets.strip.to_i
        end
        puts ""
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

         puts "##################################".colorize(:blue)
         puts "#{name.upcase}".colorize(:light_blue)
         puts "Region: #{region}".colorize(:light_blue)
         puts "##################################".colorize(:blue)
         puts "#{last_updated}"
         if !trafficking.empty?
            puts "__________________________________"
            puts "#{trafficking_label}".colorize(:green)
            puts trafficking
         end
         if !drugs.empty?
            puts "__________________________________"
            puts "#{drugs_label}".colorize(:green)
            puts drugs
         end
         if !refugees.empty?
            puts "__________________________________"
            puts "#{refugees_label}".colorize(:green)
            puts refugees
         end
         if !disputes.empty?
            puts "__________________________________"
            puts "#{disputes_label}".colorize(:green)
            puts disputes
         end
         if disputes.empty? && refugees.empty? && drugs.empty? && trafficking.empty?
            puts "__________________________________"
            puts "Sorry, unable to locate information.".colorize(:red)
            puts "Please try a different country."
         end
            puts "__________________________________"
    end

    def again?
        repeat = true
            puts ""
        while repeat
            puts "Would you like to search for other data?"
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