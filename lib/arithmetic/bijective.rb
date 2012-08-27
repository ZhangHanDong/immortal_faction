# Base62 decode for ALPHABET array.
# Bijective.bijective_encode 1121 => "5f" 


class Bijective

  ALPHABET = "abcdefghijklmnopqrstuvwxyz".split(//)

  class << self
    def bijective_encode(i)
      return ALPHABET[0] if i == 0
      s = ''
      base = ALPHABET.length
      while i > 0
        s << ALPHABET[i.modulo(base)]
        i /= base
      end
      s.reverse
    end

    def bijective_decode(s)
      i = 0
      base = ALPHABET.length
      s.each_char { |c| i = i * base + ALPHABET.index(c) }
      i
    end
  end

end