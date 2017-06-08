class WhatAWorld::Scraper
    URL = "https://www.cia.gov/library/publications/the-world-factbook/"
    class ScraperCli
        attr_accessor :letter, :all_countries, :all_url_extensions, :letter_countries, :letter_url_extensions
        def initialize(letter)
            @letter = letter
            @all_countries = []
            @all_url_extensions = []
            @letter_countries = []
            @letter_url_extensions = []
        end

        def find_all_countries
            html = open(URL)
            all_countries_page = Nokogiri::HTML(html)
            country_names = ""
            country_names = all_countries_page.css(".selecter_links option[value^='geos']").text  #"-World--Euro-"]
            self.all_countries = country_names.split("  ")
            self.all_url_extensions = all_countries_page.css(".selecter_links option").collect{ |link|
                link.attr('value') unless link.attr('value') === ""
            }
            self.all_url_extensions.reject!{|url| url.nil?}
        end

        def find_countries_by_letter
            indices = []
            self.all_countries.each.with_index{ |country, index|
                if country[0] == self.letter
                    indices << index
                    self.letter_countries << country
                end
            }
            iterator = indices.first
            while iterator <= indices.last
                self.letter_url_extensions << self.all_url_extensions[iterator]
                iterator += 1
            end
        end
    end

    class ScraperCountry
        attr_accessor :last_updated, :region
         html = open(URL)
         country_page = Nokogiri::HTML(html)

        def find_date
        end

        def find_region
        end
    end

    class ScraperIssues
    end
end
