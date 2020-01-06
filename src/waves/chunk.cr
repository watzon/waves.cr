module Waves
  abstract class Chunk
    # @buffer : Bytes

    getter chunk_id : String

    getter chunk_size : Int32

    def initialize(buffer)
      @chunk_id = String.new(buffer[0, 4])
      @chunk_size = IO::ByteFormat::LittleEndian.decode(Int32, buffer[4, 4])
    end
  end
end

require "./chunks/*"
