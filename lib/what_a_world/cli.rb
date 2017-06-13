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
                puts "No locations start with 'X'!".colorize(:red)
            end
            again = again?
        end
        goodbye
     end

    def welcome 
        "What A World!".print_fit
        sleep(1.0)
        "Explore transnational issues on a location-by-location basis.".print_fit
        sleep(1.0)
        "Information provided by the C.I.A.".print_fit
    end

    def goodbye
        puts ""
        "Goodbye, and peace to the world!".print_fit
        puts ""
    end

    def select_letter
        letter = nil
        puts ""
        while !(/\A[A-Z]\z/.match(letter))
            sleep(0.5)
            puts "Select a location by typing its first letter, A to Z".colorize(:red)
            print ":"
            letter = gets.strip.upcase 
        end 
        puts ""
        letter
    end
 
    def whole?(number)
        regex = /\A[1-9][0-9]*\z/ 
        regex.match(number)
    end

    def get_country(letter_countries, letter_url_extensions)
        country_hash = {}
        index = 0
        letter_countries.each{|country|
            index += 1
            puts "#{index}. #{country}"
        }

        number = ""
        puts ""
        loop do
            puts "Choose a country by number".colorize(:red)
            print ":"
            number = gets.strip
            break if (number.to_i.between?(1, index) && whole?(number))
        end 

        puts ""
       country_hash[letter_countries[number.to_i - 1]] = letter_url_extensions[number.to_i - 1]  
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
            puts "#{trafficking_label}".colorize(:red)
            trafficking.print_fit
         end
         if !drugs.empty?
            puts "__________________________________"
            puts "#{drugs_label}".colorize(:red)
            drugs.print_fit
         end
         if !refugees.empty?
            puts "__________________________________"
            puts "#{refugees_label}".colorize(:red)
            refugees.print_fit
         end
         if !disputes.empty?
            puts "__________________________________"
            puts "#{disputes_label}".colorize(:red)
            disputes.print_fit
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
            puts "Would you like to search for other data?".colorize(:red)
            puts "Type 'yes' or 'no'"
            print ":"
            input = gets.strip.to_s.upcase 
            if input != "YES" && input != "NO" && input != "Y" && input != "N"
                repeat = true
            else
                repeat = false
            end
        end
        input == "YES" || input == "Y" ? true : false
    end
end