require_relative './stretch_loader'
require_relative './announce'

def announce_routine_duration(selected_stretches)
  routine_duration = selected_stretches.sum(&:duration_with_say)

  minutes = (routine_duration / 60).floor
  seconds = (routine_duration % 60).round

  spoken_duration = "This routine will take about #{minutes} minutes and #{seconds} seconds"

  Announce.padded_announce(spoken_duration)
end

def run_stretch(stretch)
  Announce.announce(stretch.name)
  sleep(stretch.duration - Announce::COUNTDOWN_SECONDS)
  Announce.ending_countdown
end

def run_routine
  announce_routine_duration(StretchLoader.user_selected_stretches)

  StretchLoader.user_selected_stretches.each do |stretch|
    run_stretch(stretch)
  end

  Announce.announce_completion
end

run_routine
