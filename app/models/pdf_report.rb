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

    bounding_box([0,750], :width => 550, :height => 70) do
      stroke_color '000000'
      stroke_bounds
      image "#{Rails.root}/public/assets/images/logo_uab.jpeg", height: 50  
      draw_text "POLO DARCI RIBEIRO", size: 18, style: :bold, at: [200,740]
      #if title
      #  text title, size: 14, style: :bold_italic, align: :center
      #end
    end

  end

  def footer
    bounding_box([0,750], :width => 550, :height => 750) do
      stroke_color '000000'
      stroke_bounds
      text_box ""
    end    
  end

  # ... More helpers
end