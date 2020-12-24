class Stretch
  DEFAULT_DURATION = 30
  ESTIMATED_CHARACTER_SAY_DURATION = 0.08827821676187081

  attr_reader :name

  def initialize(name:, duration: nil)
    @name = name
    @duration = duration
  end

  def duration
    @duration || DEFAULT_DURATION
  end

  def duration_with_say
    duration + (name.size * ESTIMATED_CHARACTER_SAY_DURATION)
  end
end
