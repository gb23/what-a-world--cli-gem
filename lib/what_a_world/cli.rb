class WhatAWorld::CLI
    def call
        letter = welcome
    end

    def welcome
        puts "Welcome!"
        letter = nil
        while !(/[A-Z]/.match(letter))
            puts "Select A-Z"
            print ":"
            letter = gets.strip.upcase
            letter
        end
    end

end