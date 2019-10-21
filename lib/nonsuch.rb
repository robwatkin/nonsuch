module Nonsuch

  def business_days_between(start_date:, end_date:)
    business_days = 0
    date = end_date
    while date > start_date
      business_days = business_days + 1 unless date.saturday? or date.sunday?
      date = date - 1.day
    end
    business_days
  end

  def emails(count:, domains: self.domains(count: 4), names: nil)
    raise ArgumentError, "names.length #{names.length} != count #{count}" if names && names.length != count
    arr = []
    count.times do |index|
      if names
        local_part = names[index].downcase.delete(" ")
      else
        local_part = "#{syllables(count: rand(3) + 1).join}"
      end
      email = "#{local_part}@#{domains.sample}"
      arr << email unless arr.include? email
    end
    arr
  end

  def domains(count:)
    top_level = syllables count: 4
    arr = []
    count.times do
      domain = "#{syllable}#{syllable}.#{top_level.sample}"
      arr << domain unless arr.include? domain
    end
    arr
  end

  def names(count:)
    arr = []
    count.times do
      arr << "#{self.word(syllables: 2).capitalize} #{self.word(syllables: 3).capitalize}"
    end
    arr
  end

  def sentence(words: 7)
    "#{phrase(words: words).capitalize}."
  end

  def phrase(words: 3)
    arr = []
    (rand(words) + 1).times { arr << word(syllables: 3)}
    arr.join ' '
  end

  def word(syllables: 1)
    self.syllables(count: rand(syllables) + 1).join
  end

  def syllables(count:)
    arr = []
    count.times do
      current = syllable
      arr << current unless arr.include? current
    end
    arr
  end

  def syllable
    @vowels ||= %w(a e i o u)
    @consonants ||= ("a".."z").to_a - @vowels
    "#{@consonants.sample}#{@vowels.sample}#{@consonants.sample}"
  end

  def time
    Time.now - rand(100000000) + 40000000
  end

end