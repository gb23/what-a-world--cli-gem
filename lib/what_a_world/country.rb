class WhatAWorld::Country
    attr_accessor :name, :last_updated, :region
    def initialize(name)
        @name = name
    end

    def scrape
        self.last_updated = "Aug 13, 2013"
        self.region = "Middle East"
    end
end