require_relative './stretch'
require_relative './announce'

# Expected file format:
# [stretch name]
# [stretch name]; [duration]
#
# Example:
# Some Stretch
# Another, Kind of Stretch; 15
#
# (If no duration is given, the default duration will be used.)
STRETCHES = File.readlines('./stretches.txt').map do |line|
  line_parts = line.chomp.split(";").map(&:strip)

  { name: line_parts[0], duration: line_parts[1]&.to_i }
end.map do |stretch_data|
  Stretch.new(stretch_data)
end

def announce_routine_duration(selected_stretches)
  routine_duration = selected_stretches.sum(&:duration_with_say)

  minutes = (routine_duration / 60).floor
  seconds = (routine_duration % 60).round

  spoken_duration = "This routine will take about #{minutes} minutes and #{seconds} seconds"

  Announce.padded_announce(spoken_duration)
end

def starting_stretch_index
  STRETCHES.each.with_index do |stretch, index|
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
  selected_stretches = STRETCHES[starting_stretch_index..-1]

  announce_routine_duration(selected_stretches)

  selected_stretches.each { |stretch| run_stretch(stretch) }

  Announce.announce("Routine Complete", "----------Routine Complete----------")
end

run_routine
