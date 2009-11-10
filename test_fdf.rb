$LOAD_PATH << '../prawn/lib'
$LOAD_PATH << 'lib'

require 'prawn/core'
require 'prawn/fdf'

Prawn::FDF.generate("output.fdf", :referenced_pdf => "sample_form.pdf") do
  add_field "Text2", "J. Random Hacker"
end

