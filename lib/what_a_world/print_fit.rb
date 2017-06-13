class String

    def print_fit
        dimensions = IO.console.winsize
        window_length = dimensions[1]
        word_array = self.split(" ")
        word_index = 0

        remaining_room = window_length
        while remaining_room >= 0 && word_index < word_array.size
            remaining_room -= word_array[word_index].size
            if remaining_room >=0
                print word_array[word_index]
                if remaining_room > 0
                    print " "
                    remaining_room -= 1
                end
            else
                puts ""
                print word_array[word_index] + " "
                remaining_room = window_length - word_array[word_index].size - 1
            end
            word_index += 1
        end
        puts ""
    end
end