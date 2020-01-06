module Waves::Chunks
  class Header < Chunk
    getter wave_id : String

    getter fmt : Format

    # getter fact : Fact? = nil

    getter data : Data

    def initialize(buffer : Bytes)
      super(buffer)

      if @chunk_id != "RIFF"
        raise "This is not a valid WAV file. No RIFF chunk id."
      end

      @wave_id = String.new(buffer[8, 4])
      @fmt = Format.new(buffer[12, 48])
      @data = Data.new(buffer[50, chunk_size - 60])
    end
  end
end
