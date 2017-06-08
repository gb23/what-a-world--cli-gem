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
            #{:the_one_name => the_one_extension}
    binding.pry
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

    #change.  this should return single country, url from countries, urls of a single letter type
    def get_country(all_countries, all_url_extensions)
        country_hash = {}
        index = 0
        number = 0
        all_countries.each{|country|
            index += 1
            puts "#{index}. #{country}"
        }
        while !number.between?(1, index)
            puts "Choose a country by number"
            number = gets.strip.to_i
        end
       country_hash[all_countries[number - 1]] = all_url_extensions[number - 1]    
    end

    def print_results(country)
         name = country.name
         last_updated = country.last_updated
         region = country.region 
         trafficking = country.issues.trafficking
         drugs = country.issues.drugs
         refugees = country.issues.refugees
         disputes = country.issues.disputes

         puts "##################################"
         puts "#{name}"
         puts "#{region}"
         puts "##################################"
         puts "updated: #{last_updated}"
         puts "----------------------------------"
         if !trafficking.nil?
            puts "Trafficking in persons::"
            puts "----------------------------------"
            puts "#{trafficking}"
         end
         if !drugs.nil?
            puts "Illicit drugs::"
            puts "----------------------------------"
            puts "#{drugs}"
         end
         if !refugees.nil?
            puts "Refugees and internally displaced persons::"
            puts "----------------------------------"
            puts "#{refugees}"
         end
         if !disputes.nil?
            puts "Disputes - international::"
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