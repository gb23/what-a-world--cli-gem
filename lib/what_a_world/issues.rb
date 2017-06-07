class WhatAWorld::Issues
    attr_accessor :trafficking, :drugs, :refugees, :disputes
    def scrape
        scraper = WhatAWorld::Scraper::ScraperIssues.new
        #...
        self.trafficking = "multiple people"
        self.drugs = "cocaine"
        self.refugees = "tons, unfortunately"
        self.disputes = "arguments with everyone"
    end
end


# Trafficking in persons:
# Illicit drugs:
# Refugees and internally displaced persons:
# Disputes - international: