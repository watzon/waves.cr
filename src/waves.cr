require "./waves/**"

# TODO: Write documentation for `Waves`
module Waves
  VERSION = "0.1.0"

  # TODO: Put your code here
end

file = File.open("bubbles.wav")
pp Waves::Chunks::Header.new(file.gets_to_end.to_slice)
