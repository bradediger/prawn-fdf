module Prawn
  class FDF

    class ObjectStore < Prawn::ObjectStore
      def initialize(catalog_data)
        @objects = {}
        @identifiers = []
 
        @catalog = ref(catalog_data).identifier
        @root = ref(:Version => :"1.2", :FDF => catalog).identifier
      end

      def catalog
        @objects[@catalog]
      end
    end

  end
end
