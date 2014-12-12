class PdfReport < Prawn::Document

  # Often-Used Constants
  TABLE_ROW_COLORS = ["FFFFFF","DDDDDD"]
  TABLE_FONT_SIZE = 9
  TABLE_BORDER_STYLE = :grid

  def initialize(default_prawn_options={})
    super(default_prawn_options)
    font_size 10
  end

  def header(title=nil)
    #image "#{Rails.root}/public/logo.png", height: 30
    text "POLO UAB DARCI RIBEIRO", size: 18, style: :bold, align: :center
    if title
      text title, size: 14, style: :bold_italic, align: :center
    end
  end

  def footer
    # ...
  end

  # ... More helpers
end