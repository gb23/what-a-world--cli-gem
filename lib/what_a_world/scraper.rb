class WhatAWorld::Scraper
    class ScraperCli
        @@url = "https://www.cia.gov/library/publications/the-world-factbook/"
        
        attr_accessor :letter, :all_countries, :url_extensions, :countries
        def initialize(letter)
            @letter = letter
            @all_countries = []
            @url_extensions = []
            self.find_all_countries
            self.find_countries_by_letter
        end

        def find_all_countries
            html = open(@@url)
            all_countries_page = Nokogiri::HTML(html)
            country_names = ""
            country_url_extensions = []
            country_names = all_countries_page.css(".selecter_links option[value^='geos']").text  #"-World--Euro-"]
            self.all_countries = country_names.split("  ")
            self.url_extensions = all_countries_page.css(".selecter_links option").collect{ |link|
                link.attr('value') unless link.attr('value') === ""
            }
            self.url_extensions.reject!{|url| url.nil?}

        end

        def find_countries_by_letter



        end
    end

    class ScraperCountry
        attr_accessor :last_updated, :region
    end

    class ScraperIssues
    end
end
