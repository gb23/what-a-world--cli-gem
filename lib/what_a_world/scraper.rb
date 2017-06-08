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
            html = open(@country_url)
            @country_page = Nokogiri::HTML(html)
        end
        def create_string(iterator)
            "//ul[last()]/li[last()]/div[" + iterator.to_s + "]"
        end
        def scraped_string(iterator)
            @country_page.xpath(create_string(iterator)).text
        end

        def scrape_issues
            disputes = "Disputes - international:"
            disputes_content = []
            refugees = "Refugees and internally displaced persons:"
            refugees_content = []
            trafficking = "Trafficking in persons:"
            trafficking_content = []
            drugs = "Illicit drugs:"
            drugs_content = []
            iterator = 1
            scraped_string(iterator)
           # scraped_string = @country_page.xpath('//ul[last()]/li[last()]/div[iterator]').text

            while scraped_string(iterator) != ""

                if  disputes == scraped_string(iterator)
                    iterator +=1

                    scraped = scraped_string(iterator)

                    while scraped != disputes && scraped != refugees && scraped != trafficking && scraped != drugs && scraped != ""

                        disputes_content << scraped
                        iterator +=1
                        scraped = scraped_string(iterator)
                    end

                elsif refugees == scraped_string(iterator)
                    iterator +=1
                    scraped = scraped_string(iterator)
                    while scraped != disputes && scraped != refugees && scraped != trafficking && scraped != drugs && scraped != ""
                        refugees_content << scraped
                        iterator +=1
                        scraped = scraped_string(iterator)
                    end

                elsif trafficking == scraped_string(iterator)
                    iterator +=1
                    scraped = scraped_string(iterator)
                    while scraped != disputes && scraped != refugees && scraped != trafficking && scraped != drugs && scraped != ""
                        trafficking_content << scraped
                        iterator +=1
                        scraped = scraped_string(iterator)
                    end
                elsif drugs == scraped_string(iterator)
                    iterator +=1
                    scraped = scraped_string(iterator)
                    while (scraped != disputes && scraped != refugees && scraped != trafficking && scraped != drugs && scraped != ""
                        drugs_content << scraped
                        iterator +=1
                        scraped = scraped_string(iterator)
                    end
                #else
                end 
            end

            disputes_hash[disputes] = disputes_content
            refugees_hash[refugees] = refugees_content
            trafficking_hash[refugees] = trafficking_content
            drugs_hash[drugs] = drugs_content
binding.pry
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

