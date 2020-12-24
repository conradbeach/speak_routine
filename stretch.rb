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
end
