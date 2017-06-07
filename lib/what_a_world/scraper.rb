class WhatAWorld::Scraper
    class ScraperCli
        attr_accessor :letter :all
        def initialize(letter)
            @letter = letter
            @all = []
        end

        def all
            @all
        end
    end

    class ScraperCountry
    end

    class ScraperIssues
    end
end
