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
            country_names = all_countries_page.css(".selecter_links option[value^='geos']").text  #"-World--Euro-"]
            self.all_countries = country_names.split("  ")
            self.all_url_extensions = all_countries_page.css(".selecter_links option").collect{ |link|
                link.attr('value') unless link.attr('value') === ""
            }
            self.all_url_extensions.reject!{|url| url.nil?}
        end

        def find_countries_by_letter
            indices = []
            self.all_countries.each.with_index{ |country, index|
                if country[0] == self.letter
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
        attr_accessor :last_updated, :region, :country_url, :html, :country_page
        def initialize(url_extension)
            @country_url = URL + url_extension
            @html = open(@country_url)
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
        attr_accessor :country_url, :html, :country_page
        def initialize(url_extension)
            mod_extension = url_extension.split("/")
            mod_extension = mod_extension.insert(1, "/")
            mod_extension = mod_extension.insert(2, "print_")
            mod_extension = mod_extension.join
            #geos/zi.html
            #geos/print_zi.html
           # "https://www.cia.gov/library/publications/the-world-factbook/geos/zi.html"
            # https://www.cia.gov/library/publications/the-world-factbook/geos/print_zi.html
            @country_url = URL + mod_extension
            @html = open(@country_url)
            @country_page = Nokogiri::HTML(html)
        end

        def get_trafficking
            #all text: @country_page.xpath('//ul[last()]/li[last()]').text
            #issue titles    @country_page.xpath('//ul[last()]/li[last()]/div[@id="field"]/a').text
            # => "Disputes - international:Refugees and internally displaced persons:Trafficking in persons:Illicit drugs:"
binding.pry
        end

        #############################
        [
        @country_page.xpath('//ul[last()]/li[last()]/div[@id="field"]/a[1]')[0].text #while this is not equal to nil.
        => "Disputes -- international:"



        ]
    


        @country_page.xpath('//ul[last()]/li[last()]/div[@id="field"]/a[1]')[1].text 
        => "Refugees and internally displaced persons:"

        @country_page.xpath('//ul[last()]/li[last()]/div[@id="field"]/a[1]')[2].text
        => "Trafficking in persons:"

        @country_page.xpath('//ul[last()]/li[last()]/div[@id="field"]/a[1]')[3].text
        => "Illicit drugs:"

        @country_page.xpath('//ul[last()]/li[last()]/div[@id="field"]/a[1]')[4].text == nil