class WhatAWorld::Issues
    attr_accessor :trafficking, :drugs, :refugees, :disputes, :url_extension
    def initialize(url_extension)
        @url_extension = url_extension
    end
     
    def scrape
        scraper = WhatAWorld::Scraper::ScraperIssues.new(self.url_extension)
        scraper.scrape_issues
        self.trafficking = scraper.trafficking
        self.drugs = scraper.drugs
        self.refugees = scraper.refugees
        self.disputes = scraper.disputes
    end
end


