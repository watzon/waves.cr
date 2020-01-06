module Waves::Chunks
  class Data < Chunk
    getter data : Bytes

    def initialize(buffer : Bytes)
      super(buffer)

      if @chunk_id != "data"
        raise "No data chunk id found"
      end

      data_size = chunk_size - 8
      data_size = data_size.odd? ? data_size - 1 : data_size

      @data = buffer[8, data_size - 8]
    end
  end
end
