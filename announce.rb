module Announce
  ESTIMATED_CHARACTER_SAY_DURATION = 0.08827821676187081

  def self.say(message)
    `say -v Samantha “#{message}”`
  end

  def self.say_duration(message)
    message.size * ESTIMATED_CHARACTER_SAY_DURATION
  end
end
