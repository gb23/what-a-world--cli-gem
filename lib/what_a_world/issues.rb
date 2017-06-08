class WhatAWorld::Issues
    attr_accessor :trafficking_hash, :drugs_hash, :refugees_hash, :disputes_hash, :url_extension
    def initialize(url_extension)
        @url_extension = url_extension
        trafficking_hash = {}
        drugs_hash = {}
        refugees_hash = {}
        disputes_hash = {}
    end
     
    def scrape
        scraper = WhatAWorld::Scraper::ScraperIssues.new(self.url_extension)
        scraper.scrape_issues
        self.trafficking_hash = scraper.trafficking_hash
        self.drugs_hash = scraper.drugs_hash
        self.refugees_hash = scraper.refugees_hash
        self.disputes_hash = scraper.disputes_hash

    end
end


