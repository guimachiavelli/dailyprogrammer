#!/usr/bin/env ruby

def getData()
    File.read('./data/pg47498.txt')
end

def wordCount()
    book = getData
    words = {}
    ordered_words = []

    book.downcase.scan(/\w+/).each do |word|
        words[word] = 0 if words[word] == nil
        words[word] += 1
    end

    words.each do |word, count|
        ordered_words.push [word, count]
    end

    ordered_words.sort! do |a,b|
        b[1] <=> a[1]
    end

    10.times do |index|
        puts ordered_words[index][0] + ': ' + ordered_words[index][1].to_s
    end
end

wordCount
