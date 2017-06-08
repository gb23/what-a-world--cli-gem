class WhatAWorld::Issues
    attr_accessor :trafficking, :drugs, :refugees, :disputes, :url_extension
    def initialize(url_extension)
        @url_extension = url_extension
    end
     
    def scrape
        scraper = WhatAWorld::Scraper::ScraperIssues.new(self.url_extension)
    
        self.trafficking = scraper.get_trafficking
        self.drugs = scraper.get_drugs
        self.refugees = scraper.get_refugees
        self.disputes = scraper.get_disputes
    end
end


