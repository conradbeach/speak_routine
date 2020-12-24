require_relative './stretch_loader'
require_relative './announce'

def announce_routine_duration(selected_stretches)
  routine_duration = selected_stretches.sum(&:duration_with_say)

  minutes = (routine_duration / 60).floor
  seconds = (routine_duration % 60).round

  spoken_duration = "This routine will take about #{minutes} minutes and #{seconds} seconds"

  Announce.padded_announce(spoken_duration)
end

def starting_stretch_index
  StretchLoader.all_stretches.each.with_index do |stretch, index|
    return index if stretch.name.downcase == ARGV[0]&.downcase
  end

  return 0
end

def run_stretch(stretch)
  Announce.announce(stretch.name)
  sleep(stretch.duration - Announce::COUNTDOWN_SECONDS)
  Announce.ending_countdown
end

def run_routine
  selected_stretches = StretchLoader.all_stretches[starting_stretch_index..-1]

  announce_routine_duration(selected_stretches)

  selected_stretches.each { |stretch| run_stretch(stretch) }

  Announce.announce_completion
end

run_routine
