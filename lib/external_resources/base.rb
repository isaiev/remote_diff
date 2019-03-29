module ExternalResources
  class Base

    class << self
      def url
        raise NotImplementedError
      end

      def representer
        raise NotImplementedError
      end

      def parse_response(data)
        JSON.parse(data).with_indifferent_access
      end
    end

  end
end
