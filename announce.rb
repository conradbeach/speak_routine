module Announce
  ESTIMATED_CHARACTER_SAY_DURATION = 0.08827821676187081
  COUNTDOWN_SECONDS = 3

  def self.announce(say_message, text_message = nil)
    puts text_message || say_message
    say(say_message)
  end

  # Identical to `announce` except that it renders the text_message with blank
  # lines around it in the console.
  def self.padded_announce(say_message, text_message = nil)
    padded_text_message = "\n#{text_message || say_message}\n\n"

    announce(say_message, padded_text_message)
  end

  def self.say_duration(message)
    message.size * ESTIMATED_CHARACTER_SAY_DURATION
  end

  def self.announce_routine_duration(routine_duration)
    minutes = (routine_duration / 60).floor
    seconds = (routine_duration % 60).round
    spoken_duration = "This routine will take about #{minutes} minutes and #{seconds} seconds"

    padded_announce(spoken_duration)
  end

  def self.ending_countdown
    COUNTDOWN_SECONDS.times do
      puts "."
      bell
      sleep(1)
    end
  end

  def self.announce_completion
   announce("Routine Complete", "----------Routine Complete----------")
  end

  private_class_method def self.say(message)
    system("say -v Samantha \"#{message}\"")
  end

  private_class_method def self.bell
    puts 7.chr
  end
end
