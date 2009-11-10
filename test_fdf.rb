$LOAD_PATH << '../prawn/lib'
$LOAD_PATH << 'lib'

require 'prawn/core'
require 'prawn/fdf'

fdf = Prawn::FDF.new(:referenced_pdf => "sample_form.pdf")

fdf.add_field "Text2", "J. Random Hacker"

fdf.render_file "output.fdf"
