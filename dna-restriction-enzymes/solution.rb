def load_enzymes
    enzymes = {}

    File.open('./enzymes.txt', 'r') do |file|
        file.each_line do |line|
            line = line.split ' '
            enzymes[line[0]] = {
                :type => line[1],
                :find => line[2].gsub('^', ''),
                :replace => '[' + line[2].gsub('^', ' ') + ']',
                :cut_position => line[2].index('^')
            }
        end
    end

    enzymes
end

def load_sequence
    sequence = File.read('./sequence.txt')
    sequence.gsub(/\d/, '').gsub(/\s/, '').upcase
end


def cut_sequence
    enzymes = load_enzymes
    sequence = load_sequence

    enzymes.each do |name, attrs|
        sequence = sequence.scan(attrs[:find]) do |match|
            index = Regexp.last_match.offset(0)[0]
            sample_cut = sequence.slice(index - 5, 5) + attrs[:replace]
            sample_cut += sequence.slice(index + attrs[:find].length, 5)
            puts [name, index + attrs[:cut_position], sample_cut].join ' '
        end
    end
end

cut_sequence
