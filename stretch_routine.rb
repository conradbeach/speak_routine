require_relative './stretch_loader'
require_relative './announce'

def routine_duration
  StretchLoader.user_selected_stretches.sum(&:duration_with_say)
end

def run_stretch(stretch)
  Announce.announce(stretch.name)
  sleep(stretch.duration - Announce::COUNTDOWN_SECONDS)
  Announce.ending_countdown
end

def run_routine
  Announce.announce_routine_duration(routine_duration)

  StretchLoader.user_selected_stretches.each do |stretch|
    run_stretch(stretch)
  end

  Announce.announce_completion
end

run_routine
