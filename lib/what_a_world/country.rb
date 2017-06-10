class WhatAWorld::Country
    attr_accessor :last_updated, :region, :issues
    attr_reader :name, :url_extension
    def initialize(hash)
        @name = hash.keys.join
        @url_extension = hash.values.join
    end

    def scrape
        scraper = WhatAWorld::Scraper::ScraperCountry.new(self.url_extension)
        
        self.last_updated = scraper.find_date
        self.region = scraper.find_region

    end

    def get_issues
        self.issues = WhatAWorld::Issues.new(self.url_extension)
        self.issues.scrape
    end
end
