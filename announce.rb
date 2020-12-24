module Announce
  ESTIMATED_CHARACTER_SAY_DURATION = 0.08827821676187081
  COUNTDOWN_SECONDS = 3

  def self.announce(say_message, text_message = nil)
    puts text_message || say_message
    say(say_message)
  end

  def self.say(message)
    `say -v Samantha “#{message}”`
  end

  def self.say_duration(message)
    message.size * ESTIMATED_CHARACTER_SAY_DURATION
  end

  def self.ending_countdown
    COUNTDOWN_SECONDS.times do
      puts "."
      bell
      sleep(1)
    end
  end

  def self.bell
    puts 7.chr
  end
end
