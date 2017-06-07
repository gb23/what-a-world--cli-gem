*CLI
    -ScraperCLI
    -*Country
           -ScraperCountry
           - *TransnationIssues
                           -ScraperTI


class CLIScraper
    get_countries_by_letter
    => countries_by_letter []

    create_country_by_number
    => countryObj

class Country
    def intialize
        instantiate ScraperCountry
        instantiate TransnationalIssues
    attr name, last updated, region


class TransnationalIssues
    attr :regugee :drug :etc
    def initialize
        instantiate ScraperTrIssues






CLI CLASS
    welcomes user
    [
    Asks user to select country by choosing a letter
    *instantiate SCRAPERCLI obj to get countries of that letter
    Lists countries found array from letter, enumerated
    Asks user to select corresponding number
    *instantiates country obj with name from number
        COUNTRY CLASS
        set name attr
        instantiate SCRAPERCOUNTRY to get lastupdated, region
        set lastupdated, region
        *instantiate TransnationalIssues
            TRANSNATIONAL ISSUES
            instantiate SCRAPERTI to get :refugee, :crime etc
            set refugee, crime, etc
            return transnational issues obj
        add transnationalissues obj to country object
        return country obj
    Display country and issues from data in country obj
    Ask to continue or exit
    ]
    Goodbye!



    












