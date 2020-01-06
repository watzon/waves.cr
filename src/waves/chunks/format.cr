module Waves::Chunks
  class Format < Chunk
    getter format_tag : Wave::Format

    getter channels : Int16

    getter sample_rate : Int32

    getter bytes_per_second : Int32

    getter block_size : Int16

    getter bits_per_sample : Int16

    getter cb_size : Int16? = nil

    getter valid_bits_per_sample : Int16? = nil

    getter channel_mask : Int32? = nil

    getter guid : String? = nil

    def initialize(buffer : Bytes)
      super(buffer)

      if @chunk_id != "fmt "
        raise "Invalid format chunk"
      end

      @format_tag = Wave::Format.from_value(IO::ByteFormat::LittleEndian.decode(Int16, buffer[8, 2]))
      @channels = IO::ByteFormat::LittleEndian.decode(Int16, buffer[10, 2])
      @sample_rate = IO::ByteFormat::LittleEndian.decode(Int32, buffer[12, 4])
      @bytes_per_second = IO::ByteFormat::LittleEndian.decode(Int32, buffer[16, 4])
      @block_size = IO::ByteFormat::LittleEndian.decode(Int16, buffer[20, 2])
      @bits_per_sample = IO::ByteFormat::LittleEndian.decode(Int16, buffer[22, 2])

      if @chunk_size > 16
        @cb_size = IO::ByteFormat::LittleEndian.decode(Int16, buffer[24, 2])

        if @chunk_size > 18
          @valid_bits_per_sample = IO::ByteFormat::LittleEndian.decode(Int16, buffer[26, 2])
          @channel_mask = IO::ByteFormat::LittleEndian.decode(Int32, buffer[28, 4])
          @guid = String.new(buffer[32, 16])
        end
      end
    end
  end
end
