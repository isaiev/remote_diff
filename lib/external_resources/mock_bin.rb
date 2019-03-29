module ExternalResources
  class MockBin < Base

    class << self
      def url
        'https://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df'
      end

      def representer
        MockBinRepresenter
      end

      def parse_response(data)
        super[:ads]
      end
    end

  end
end
