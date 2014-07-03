module Sass::Script::Functions
  def random(max = Sass::Script::Number.new(100))
    Sass::Script::Number.new(rand(max.value), max.numerator_units, max.denominator_units)
  end
end