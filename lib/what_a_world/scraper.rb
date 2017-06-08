class WhatAWorld::Scraper
    class ScraperCli
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
            @all << "Afghanistan"
            @all << "Argentina"
            @all << "Australia"
            @all << "Austria"
        end
    end

    class ScraperCountry
    end

    class ScraperIssues
    end
end
