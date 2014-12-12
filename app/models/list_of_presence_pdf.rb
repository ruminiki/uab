class ListOfPresencePDF

  PDF_OPTIONS = {
    :page_size   => "A5",
    :page_layout => :landscape,
    #:background  => "public/favicon.ico",
    :margin      => [40, 75]
  }

  def pdf
    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      pdf.fill_color "40464e"
      pdf.text "Ruby Metaprogramming", :size => 40, :style => :bold, :align => :center

      pdf.move_down 30
      pdf.text "Certificado", :size => 24, :align => :center, :style => :bold

      pdf.move_down 30
      pdf.text "Certificamos que <b>Nando Vieira</b> participou...", :inline_format => true

      pdf.move_down 15
      pdf.text "São Paulo, "

      pdf.move_down 30
      #pdf.font Rails.root.join("fonts/custom.ttf")
      pdf.text "howto", :size => 24

      pdf.move_up 5
      pdf.font "Helvetica"
      pdf.text "http://howtocode.com.br", :size => 10
    end
  end

  def save
    pdf.render_file('lista_de_presenca.pdf')
  end

end