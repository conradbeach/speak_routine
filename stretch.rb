require_relative './announce'

class Stretch
  DEFAULT_DURATION = 30

  attr_reader :name

  def initialize(name:, duration: nil)
    @name = name
    @duration = duration
  end

  def duration
    @duration || DEFAULT_DURATION
  end

  def duration_with_say
    duration + Announce.say_duration(name)
  end
end
