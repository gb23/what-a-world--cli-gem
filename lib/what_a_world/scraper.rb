class WhatAWorld::Scraper
    class ScraperCli
        url = "https://www.cia.gov/library/publications/the-world-factbook/"
        attr_accessor :letter, :all
        def initialize(letter)
            @letter = letter
            @all = []
            self.find_countries_by_letter
        end

        def all
            @all
        end

        def find_countries_by_letter
            #use @letter to scrape
            html = open(url)
            countries_page = Nokogiri::HTML(html)
            # @all << "Afghanistan"
            # @all << "Argentina"
            # @all << "Australia"
            # @all << "Austria"
        end
    end

    class ScraperCountry
        attr_accessor :last_updated, :region
    end

    class ScraperIssues
    end
end
