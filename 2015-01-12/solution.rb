#!/usr/bin/env ruby

class ISBN

    def initialize(number = nil)
        @number = number == nil ? generate : format_input(number)
        validate(@number) unless number == nil
    end

    def format_input(number)
        number.dup.gsub(/[^\d|X]*/, '')
    end

    def generate
        numbers = []
        value = 0

        (2..10).each do |count|
            number = rand(0..9)
            value += count * number
            numbers.insert(0, number)
        end

        last_value = value % 11
        last_value = 11 - last_value if last_value != 0
        last_value = 'X' if last_value == 10
        numbers.push(last_value)

        puts 'Generated new ISBN: ' + to_s(numbers.join)

        numbers.join
    end

    def validate(number)
        if number.length != 10
            raise 'Invalid number length'
        end
        value = 0

        number.reverse.each_char.with_index do |digit, index|
            digit = 10 if digit == 'X'
            value += digit.to_i * (index + 1)
        end

        if is_valid?(value)
            puts 'Valid ISBN number: ' + to_s
        else
            puts 'Invalid ISBN number: ' + to_s
        end
    end

    def is_valid?(value)
        value % 11 == 0
    end

    def to_s(number = @number)
        number.dup.insert(5, '-').insert(1,'-').insert(-2, '-')
    end

end

test = ISBN.new(ARGV[0])
