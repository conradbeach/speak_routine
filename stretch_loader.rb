require './stretch'

module StretchLoader
  def self.all_stretches
    @all_stretches ||= all_stretch_data.map do |stretch_data|
      Stretch.new(stretch_data)
    end
  end

  # Expected file format:
  # [stretch name]
  # [stretch name]; [duration]
  #
  # Example:
  # Some Stretch
  # Another, Kind of Stretch; 15
  #
  # (If no duration is given, the default duration will be used.)
  private_class_method def self.all_stretch_data
    File.readlines('./stretches.txt').map do |line|
      line_parts = line.chomp.split(";").map(&:strip)

      { name: line_parts[0], duration: line_parts[1]&.to_i }
    end
  end
end
