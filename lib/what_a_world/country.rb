class WhatAWorld::Country
    attr_accessor :name :last_updated, :region
    def initialize(name)
        @name = name
        scrape
    end

    def scrape
        
    end
end