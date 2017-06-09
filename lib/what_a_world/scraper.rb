class WhatAWorld::Scraper
    URL = "https://www.cia.gov/library/publications/the-world-factbook/"
    class ScraperCli
        attr_accessor :letter, :all_countries, :all_url_extensions, :letter_countries, :letter_url_extensions
        def initialize(letter)
            @letter = letter
            @all_countries = []
            @all_url_extensions = []
            @letter_countries = []
            @letter_url_extensions = []
        end

        def find_all_countries
            html = open(URL)
            all_countries_page = Nokogiri::HTML(html)
            country_names = ""
            country_names = all_countries_page.css(".selecter_links option[value^='geos']").text
            self.all_countries = country_names.split("  ")
            self.all_url_extensions = all_countries_page.css(".selecter_links option").collect{ |link|
                link.attr('value') unless link.attr('value') === ""
            }
            self.all_url_extensions.reject!{|url| url.nil?}
        end

        def find_countries_by_letter
            indices = []
            self.all_countries.each.with_index{ |country, index|
                if country[0] == self.letter && country.gsub(" ", "") != "EuropeanUnion"
                    indices << index
                    self.letter_countries << country
                end
            }
            iterator = indices.first
            while iterator <= indices.last
                self.letter_url_extensions << self.all_url_extensions[iterator]
                iterator += 1
            end
        end
    end

    class ScraperCountry
        attr_accessor :last_updated, :region, :country_page
        def initialize(url_extension)
            country_url = URL + url_extension
            html = open(country_url)
            @country_page = Nokogiri::HTML(html)
        end

        def find_date
            @country_page.css("div.lastMod").text
        end
        def find_region
            str = @country_page.css("div.region1.geos_title").text
            region = str.split("  ")[0]
        end
    end

    class ScraperIssues
        @@disputes = "Disputes - international:"
        @@refugees = "Refugees and internally displaced persons:"
        @@trafficking = "Trafficking in persons:"
        @@drugs = "Illicit drugs:"
        attr_accessor :country_page, :trafficking_hash, :disputes_hash, :drugs_hash, :refugees_hash, :disputes_content, :refugees_content, :trafficking_content, :drugs_content
        def initialize(url_extension)
            @disputes_content = []
            @refugees_content = []
            @trafficking_content = []
            @drugs_content = []
            @trafficking_hash = {}
            @disputes_hash = {}
            @drugs_hash = {}
            @refugees_hash = {}
            country_url = URL + modify_extension(url_extension)
            html = open(country_url)
            @country_page = Nokogiri::HTML(html)
        end

        def modify_extension(url_extension)
            mod_extension = url_extension.split("/")
            mod_extension = mod_extension.insert(1, "/")
            mod_extension = mod_extension.insert(2, "print_")
            mod_extension = mod_extension.join
        end

        def create_string(iterator)
            "//ul[last()]/li[last()]/div[" + iterator.to_s + "]"
        end

        def scraped_string(iterator)
            @country_page.xpath(create_string(iterator)).text
        end
        
        def scrape_issues
            iterator = 1
            scraped_string(iterator)

            unfamiliar_setup = false
            while scraped_string(iterator) != "" && !unfamiliar_setup
                if  @@disputes == scraped_string(iterator)
                    iterator = get_content(iterator, self.disputes_content)
                    # iterator +=1

                    # scraped = scraped_string(iterator)

                    # while scraped != @@disputes && scraped != @@refugees && scraped != @@trafficking && scraped != @@drugs && scraped != ""

                    #     self.disputes_content << scraped
                    #     iterator +=1
                    #     scraped = scraped_string(iterator)
                    # end

                elsif @@refugees == scraped_string(iterator)
                    iterator = get_content(iterator, self.refugees_content)
                    # iterator +=1
                    # scraped = scraped_string(iterator)
                    # while scraped != @@disputes && scraped != @@refugees && scraped != @@trafficking && scraped != @@drugs && scraped != ""
                    #     self.refugees_content << scraped
                    #     iterator +=1
                    #     scraped = scraped_string(iterator)
                    # end

                elsif @@trafficking == scraped_string(iterator)
                    iterator = get_content(iterator, self.trafficking_content)
                    # iterator +=1
                    # scraped = scraped_string(iterator)
                    # while scraped != @@disputes && scraped != @@refugees && scraped != @@trafficking && scraped != @@drugs && scraped != ""
                    #     self.trafficking_content << scraped
                    #     iterator +=1
                    #     scraped = scraped_string(iterator)
                    # end
                elsif @@drugs == scraped_string(iterator)
                    iterator = get_content(iterator, self.drugs_content)
                    # iterator +=1
                    # scraped = scraped_string(iterator)
                    # while scraped != @@disputes && scraped != @@refugees && scraped != @@trafficking && scraped != @@drugs && scraped != ""
                    #     self.drugs_content << scraped
                    #     iterator +=1
                    #     scraped = scraped_string(iterator)
                    # end
                else
                    unfamiliar_setup = true
                end 
            end
        self.disputes_hash[@@disputes] = self.disputes_content
        self.refugees_hash[@@refugees] = self.refugees_content
        self.trafficking_hash[@@trafficking] = self.trafficking_content
        self.drugs_hash[@@drugs] = self.drugs_content
        end
    
        def add_content(iterator, content)
            iterator +=1
            scraped = scraped_string(iterator)
            while scraped != @@disputes && scraped != @@refugees && scraped != @@trafficking && scraped != @@drugs && scraped != ""
                content << scraped
                iterator +=1
                scraped = scraped_string(iterator)
            end
            iterator
        end
    end    
end    
