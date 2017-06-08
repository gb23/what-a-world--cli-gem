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
        attr_accessor :country_url, :html, :country_page, :trafficking_hash, :disputes_hash, :drugs_hash, :refugees_hash
        def initialize(url_extension)
            trafficking_hash = {}
            disputes_hash = {}
            drugs_hash = {}
            refugees_hash = {}
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

        def scrape_issues
            disputes = "Disputes -- international:"
            refugees = "Refugees and internally displaced persons:"
            trafficking = "Trafficking in persons:"
            drugs = "Illicit drugs:"

            iterator = 1
            while @country_page.xpath('//ul[last()]/li[last()]/div[iterator]').text != ""
                case @country_page.xpath('//ul[last()]/li[last()]/div[iterator]').text
                when disputes
                    
                    
                when refugees
                when trafficking
                when drugs
                #else
                end 
            end
        end

#         #############################
#         [
#         n=0 #needs to start at 0
#         @country_page.xpath('//ul[last()]/li[last()]/div[@id="field"]/a[1]')[n].text #while this is not equal to nil.
#         => "Disputes -- international:" 
        



#         n++
#         ]
#         ####this array only gets main text from disputes and drugs...
#         @country_page.xpath('//ul[last()]/li[last()]/div[@class="category_data"]')[0].text
# => "Namibia has supported, and in 2004 Zimbabwe dropped objections to, plans between Botswana and Zambia to build a bridge over the Zambezi River, thereby
# de facto recognizing a short, but not clearly delimited, Botswana-Zambia boundary in the river; South Africa has placed military units to assist police ope
# rations along the border of Lesotho, Zimbabwe, and Mozambique to control smuggling, poaching, and illegal migration"

#         @country_page.xpath('//ul[last()]/li[last()]/div[@id="field"]/a[1]')[1].text 
#         => "Refugees and internally displaced persons:"

#         @country_page.xpath('//ul[last()]/li[last()]/div[@id="field"]/a[1]')[2].text
#         => "Trafficking in persons:"

#         @country_page.xpath('//ul[last()]/li[last()]/div[@id="field"]/a[1]')[3].text
#         => "Illicit drugs:"

#         @country_page.xpath('//ul[last()]/li[last()]/div[@id="field"]/a[1]')[4].text == nil

