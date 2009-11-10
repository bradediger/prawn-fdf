require 'prawn/document/internals'
require 'prawn/fdf/object_store'

module Prawn
  class FDF
    
    include Prawn::Document::Internals

    def initialize(options={})
      # add_fields stuffs refs into the Fields dict
      catalog = {:Fields => []}

      if pdf = options[:referenced_pdf]
        catalog[:F] = Prawn::LiteralString.new(pdf)
      end

      @store = Prawn::FDF::ObjectStore.new(catalog)
    end

    def add_field(name, value)
      @store.catalog.data[:Fields] << ref!(:T => name, :V => value)
    end

    # Write out the FDF Header, as per spec 8.6.6
    #
    def render_header(output)
      output << "%FDF-1.2\n"
    end

    # Write out the FDF Trailer, as per spec 8.6.6
    #
    def render_trailer(output)
      trailer_hash = {:Root => @store.root}

      output << "trailer\n"
      output << Prawn::PdfObject(trailer_hash) << "\n"
      output << "%%EOF" << "\n"
    end
    

    def render
      output = StringIO.new

      render_header(output)
      render_body(output)
      render_trailer(output)
      str = output.string
      str.force_encoding("ASCII-8BIT") if str.respond_to?(:force_encoding)
      str
    end

    def render_file(filename)
      Kernel.const_defined?("Encoding") ? mode = "wb:ASCII-8BIT" : mode = "wb"
      File.open(filename,mode) { |f| f << render }
    end
    
  end
end
