class WhatAWorld::Scraper
    class ScraperCli
        @@url = "https://www.cia.gov/library/publications/the-world-factbook/"
        attr_accessor :letter, :countries, :url_extensions
        def initialize(letter)
            @letter = letter
            @countries = []
            @url_extensions = []
            self.find_countries_by_letter
        end

        def find_countries_by_letter
            #use @letter to scrape
            html = open(@@url)
            countries_page = Nokogiri::HTML(html)
            #convert to array
            country_names = ""
            country_url_extensions = []
            country_names = countries_page.css(".selecter_links option[value^='geos']").text  #"-World--Euro-"]
            self.countries = country_names.split(" ")
            country_url_extensions = countries_page.css(".selecter_links option").collect{ |link|
                link.attr('value')
           }
           #country_url_extensions[0] == ""
binding.pry
   
           
        end
    end

    class ScraperCountry
        attr_accessor :last_updated, :region
    end

    class ScraperIssues
    end
end
