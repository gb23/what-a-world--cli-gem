class WhatAWorld::Country
    attr_accessor :name, :last_updated, :region, :issues#:trafficking, :drugs, :refugees, :disputes
    def initialize(name)
        @name = name
    end

    def scrape
        scraper = WhatAWorld::Scraper::ScraperCountry.new
        
        # self.last_updated = "Aug 13, 2013"
        # self.region = "Middle East"
    end

    def get_issues
        self.issues = WhatAWorld::Issues.new
        self.issues.scrape
        self.issues
        #tap 
    end
end

# Trafficking in persons:   @trafficking = country.issues.trafficking
# Illicit drugs:
# Refugees and internally displaced persons:
# Disputes - international: