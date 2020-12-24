require_relative './stretch_loader'
require_relative './announce'

module Routine
  def self.run
    Announce.announce_routine_duration(routine_duration)

    run_stretches

    Announce.announce_completion
  end

  private_class_method def self.routine_duration
    StretchLoader.user_selected_stretches.sum(&:duration_with_say)
  end

  private_class_method def self.run_stretches
    StretchLoader.user_selected_stretches.each do |stretch|
      run_stretch(stretch)
    end
  end

  private_class_method def self.run_stretch(stretch)
    Announce.announce(stretch.name)
    sleep(stretch.duration - Announce::COUNTDOWN_SECONDS)
    Announce.ending_countdown
  end
end
