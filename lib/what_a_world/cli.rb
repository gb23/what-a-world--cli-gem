class WhatAWorld::CLI
    def call
        puts "Welcome!"
        again = true
        while again
            countries = []
            letter = select_letter
            scraper = WhatAWorld::Scraper::ScraperCli.new(letter)
            countries = scraper.countries

            country_name = get_country(countries)

            country = WhatAWorld::Country.new(country_name)
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