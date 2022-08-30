class Measurement
  attr_accessor :value, :unit

  MULTIPLIERS = {
    "kg" => { "g" => 1000r },
    "g" => { "kg" => 1/1000r },
    "c" => { "tsp" => 48r },
    "tsp" => { "c" => 1/48r }
  }.freeze

  def initialize(value, unit)
    @value = value
    @unit = unit
  end

  def convert_to(new_unit)
    return self if unit == new_unit
    return false if MULTIPLIERS.dig(unit, new_unit).nil?

    new_value = value * MULTIPLIERS[unit][new_unit]
    Measurement.new(new_value, new_unit)
  end
end
