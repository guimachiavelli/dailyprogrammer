#!/usr/bin/env ruby

ACRONYMS = {
    :lol    => "laugh out loud",
    :dw     => "don't worry",
    :hf     => "have fun",
    :gg     => "good game",
    :brb    => "be right back",
    :g2g    => "got to go",
    :wtf    => "what the fuck",
    :wp     => "well played",
    :gl     => "good luck",
    :imo    => "in my opinion",
    :idk    => "I do not know"
}

def replace_acronyms(text)
    text ||= 'something, something, imo, no way'

    ACRONYMS.each do |key, value|
        text = text.gsub(key.to_s, value)
    end

    puts text
end

replace_acronyms(ARGV.join(' '))
