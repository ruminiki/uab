class ListOfPresenceReport < Prawn::Document

  require "prawn"
  require "prawn/table"

  def initialize(course_class)
    super()

    @course_class = course_class

    header 

    disciplina

    tutor

    table_header

    table_data

    border
  end

  private

  def header(title=nil)
    move_cursor_to 710
    text "POLO DARCI RIBEIRO", size: 16, style: :bold, :align => :center
    move_cursor_to 690
    text 'LISTA DE PRESENÇA TURMA ' + @course_class.name, size: 14, style: :bold_italic, align: :center
    
    text Time.now.strftime("%d/%m/%Y %I:%M"), size: 10, align: :center

    image "#{Rails.root}/public/assets/images/logo_uab.jpeg", :at => [15, 730], height: 70 

    bounding_box([0,740], :width => 550, :height => 90) do
      stroke_color '000000'
      stroke_bounds
    end

  end

  def disciplina

    @v_position = 630

    draw_text "Disciplina(s):", :at => [10, @v_position]
    
    @v_position += 20

    bounding_box([0,@v_position], :width => 550, :height => 30) do
      stroke_color '000000'
      stroke_bounds
    end

    bounding_box([0,@v_position], :width => 90, :height => 30) do
      stroke_color '000000'
      stroke_bounds
    end

  end

  def tutor

    @v_position = 600

    lines = 0 if employees.nil?
    lines = employees.size if !employees.nil?

    if lines > 0
      
      employees.each do |name|
        draw_text name, :at => [100, @v_position]
        
        @v_position += 20

        bounding_box([90,@v_position], :width => 250, :height => 30) do
          stroke_color '000000'
          stroke_bounds
        end

        bounding_box([340,@v_position], :width => 210, :height => 30) do
          stroke_color '000000'
          stroke_bounds
        end
        
        @v_position -= 50
      
      end

      @v_position += 15 #if lines == 1
      #@v_position += 15 if lines == 2
      #@v_position += 15 if lines == 3

      draw_text "Tutor(es):", :at => [28, @v_position + lines * 30 / 2]

      @v_position += 35 if lines == 1
      @v_position += 5 + 30 * lines if lines > 1
      #@v_position += 95 if lines == 3

      bounding_box([0,@v_position], :width => 90, :height => lines * 30) do
        stroke_color '000000'
        stroke_bounds
      end

      @v_position -= (15 + 30 * lines)

    else
      draw_text "Tutor(es):", :at => [28, @v_position]
      
      @v_position += 20

      bounding_box([0,@v_position], :width => 550, :height => 30) do
        stroke_color '000000'
        stroke_bounds
      end

      bounding_box([0,@v_position], :width => 90, :height => 30) do
        stroke_color '000000'
        stroke_bounds
      end      

      @v_position -= 50

    end

  end

  def table_header

    @v_position += 10
    move_cursor_to @v_position

    @v_position -= 15

    text "Alunos", size: 16, :align => :center

    @v_position -= 20

    draw_text "N.", :at => [10, @v_position]
    draw_text "Nome", :at => [150, @v_position]
    draw_text "Assinatura", :at => [410, @v_position]

    @v_position += 20

    bounding_box([0,@v_position], :width => 50, :height => 30) do
      stroke_color '000000'
      stroke_bounds
    end

    bounding_box([50,@v_position], :width => 290, :height => 30) do
      stroke_color '000000'
      stroke_bounds
    end

    bounding_box([340,@v_position], :width => 210, :height => 30) do
      stroke_color '000000'
      stroke_bounds
    end

    @v_position -= 50

  end

  def table_data

    text "Nenhum estudante encontrado", :align => :center if students.nil?
    index = 1

    students.each do |name|

      draw_text index, :at => [10, @v_position]
      draw_text name, :at => [80, @v_position]

      @v_position += 20

      bounding_box([0,@v_position], :width => 50, :height => 30) do
        stroke_color '000000'
        stroke_bounds
      end

      bounding_box([50,@v_position], :width => 290, :height => 30) do
        stroke_color '000000'
        stroke_bounds
      end

      bounding_box([340,@v_position], :width => 210, :height => 30) do
        stroke_color '000000'
        stroke_bounds
      end  

      @v_position -= 50
      index += 1

    end

  end

  def row(col1, col2, col3)
    draw_text col1, :at => [10, 550]
    draw_text col2, :at => [80, 550]
    draw_text col3, :at => [350, 550]

    bounding_box([0,570], :width => 50, :height => 30) do
      stroke_color '000000'
      stroke_bounds
    end

    bounding_box([50,570], :width => 270, :height => 30) do
      stroke_color '000000'
      stroke_bounds
    end

    bounding_box([320,570], :width => 230, :height => 30) do
      stroke_color '000000'
      stroke_bounds
    end
  end

  def sub_header
    
    move_cursor_to 645

    #text 'Professor(es)'
    #table([['']], :cell_style=>{:height=>30, :width=>550})    
    
    move_cursor_to 595

    #text 'Tutor(es)'
    #table(employees,:column_widths=>[295,240]) if !employees.nil?
end

  def border
    bounding_box([0,740], :width => 550, :height => 750) do
      stroke_color '000000'
      stroke_bounds
      text_box ""
    end    
  end

  def display_course_class_table
    if table_data.nil? || table_data.empty?
      text "Nenhum aluno encontrado"
    else
      table(table_data,:column_widths=>[25,270,240])
    end
  end

  def employees
    @course_class.employees.map{ |e| [e.name, ""] } if !@course_class.nil? && !@course_class.employees.nil?
  end

  def students
    @course_class.registrations.map{ |r| [r.student.name] } if !@course_class.nil? && !@course_class.registrations.nil?
  end

end