require_relative './stretch'

COUNTDOWN_SECONDS = 3
ESTIMATED_CHARACTER_SAY_DURATION = 0.08827821676187081

STRETCHES = [
  { name: "Calf Stretch Right" },
  { name: "Calf Stretch Left" },
  { name: "Quad Stretch Right" },
  { name: "Quad Stretch Left" },
  { name: "Sitting Butterfly" },
  { name: "Sitting Reach Toes Right" },
  { name: "Sitting Reach Toes Left" },
  { name: "Standing Reach Toes" },
  { name: "Cat’s Backs" },
  { name: "Lying Down, Pull Knee to Shoulder Right" },
  { name: "Lying Down, Pull Knee to Shoulder Left" },
  { name: "Upper Spinal Floor Twist Right", duration: 45 },
  { name: "Upper Spinal Floor Twist Left", duration: 45 },
  { name: "Dive Bombers" },
  { name: "Straddle", duration: 20 },
  { name: "Standing Stretch Side to Side" },
  { name: "Standing Lean Forward and Back" },
  { name: "Standing Torso Twist" },
  { name: "Tricep Stretch Right", duration: 15 },
  { name: "Tricep Stretch Left", duration: 15 },
  { name: "Shoulder Stretch Right", duration: 15 },
  { name: "Shoulder Stretch Left", duration: 15 },
  { name: "Turn Head to Left and Right", duration: 20 },
  { name: "Drop Chin, Lean Head Back", duration: 20 },
  { name: "Lift Hands Over Head, Look Up" },
].map { |stretch_data| Stretch.new(stretch_data) }

def say(message)
  `say -v Samantha “#{message}”`
end

def announce_stretch(name)
  puts name
  say(name)
end

def announce_routine_duration(selected_stretches)
  routine_duration = selected_stretches.sum(0) do |stretch|
    (stretch.name.size * ESTIMATED_CHARACTER_SAY_DURATION) + stretch.duration
  end

  minutes = (routine_duration / 60).floor
  seconds = (routine_duration % 60).round

  spoken_duration = "This routine will take about #{minutes} minutes and #{seconds} seconds"

  puts("#{spoken_duration}\n\n")
  say(spoken_duration)
end

def announce_completion
  puts "------------Routine Complete------------"
  say("Routine Complete")
end

def bell
  puts 7.chr
end

def ending_countdown
  COUNTDOWN_SECONDS.times do
    puts "."
    bell
    sleep(1)
  end
end

def starting_stretch_index
  STRETCHES.each.with_index do |stretch, index|
    return index if stretch.name.downcase == ARGV[0]&.downcase
  end

  return 0
end

def run_stretch(stretch)
  announce_stretch(stretch.name)
  sleep(stretch.duration - COUNTDOWN_SECONDS)
  ending_countdown
end

def run_routine
  selected_stretches = STRETCHES[starting_stretch_index..-1]

  announce_routine_duration(selected_stretches)

  selected_stretches.each { |stretch| run_stretch(stretch) }

  announce_completion
end

run_routine
