class ListOfPresenceReport < Prawn::Document

  LINE_HEIGHT = 18

  def initialize(course_class)
    super()

    @course_class = course_class

    font = "Courrier"

    font_size 10

    header 

    disciplina

    professor

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
    
    text Time.now.strftime("%d/%m/%Y %H:%M"), size: 10, align: :center

    image "#{Rails.root}/public/assets/images/logo_uab.jpeg", :at => [15, 730], height: 70 

    bounding_box([0,740], :width => 550, :height => 90) do
      stroke_color '000000'
      stroke_bounds
    end

  end

  def disciplina

    @v_position = 636

    draw_text "Disciplina(s):", :at => [16, @v_position]
    
    @v_position += 14

    bounding_box([0,@v_position], :width => 550, :height => LINE_HEIGHT) do
      stroke_color '000000'
      stroke_bounds
    end

    bounding_box([0,@v_position], :width => 90, :height => LINE_HEIGHT) do
      stroke_color '000000'
      stroke_bounds
    end

  end

  def professor

    @v_position = 618

    draw_text "Professor(es):", :at => [10, @v_position]
    
    @v_position += 14

    bounding_box([0,@v_position], :width => 550, :height => LINE_HEIGHT) do
      stroke_color '000000'
      stroke_bounds
    end

    bounding_box([0,@v_position], :width => 90, :height => LINE_HEIGHT) do
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
        draw_text name[0].titleize, :at => [100, @v_position]
        
        @v_position += 14

        bounding_box([90,@v_position], :width => 230, :height => LINE_HEIGHT) do
          stroke_color '000000'
          stroke_bounds
        end

        bounding_box([320,@v_position], :width => 230, :height => LINE_HEIGHT) do
          stroke_color '000000'
          stroke_bounds
        end
        
        @v_position -= 32
      
      end

      @v_position += 9

      draw_text "Tutor(es):", :at => [30, @v_position + lines * LINE_HEIGHT / 2]

      @v_position += 23 if lines == 1
      @v_position += 5 + LINE_HEIGHT * lines if lines > 1
      #@v_position += 95 if lines == 3

      bounding_box([0,@v_position], :width => 90, :height => lines * LINE_HEIGHT) do
        stroke_color '000000'
        stroke_bounds
      end

      @v_position -= (30 + LINE_HEIGHT * lines)

    else
      draw_text "Tutor(es):", :at => [35, @v_position]
      
      @v_position += 14

      bounding_box([0,@v_position], :width => 550, :height => LINE_HEIGHT) do
        stroke_color '000000'
        stroke_bounds
      end

      bounding_box([0,@v_position], :width => 90, :height => LINE_HEIGHT) do
        stroke_color '000000'
        stroke_bounds
      end      

      @v_position -= 50

    end

  end

  def table_header

    @v_position += 25
    move_cursor_to @v_position

    @v_position -= 15

    text "Alunos", size: 16, :align => :center

    @v_position -= 15

    draw_text "N.", :at => [10, @v_position]
    draw_text "Nome", :at => [150, @v_position]
    draw_text "Assinatura", :at => [410, @v_position]

    @v_position += 15

    bounding_box([0,@v_position], :width => 30, :height => LINE_HEIGHT) do
      stroke_color '000000'
      stroke_bounds
    end

    bounding_box([30,@v_position], :width => 290, :height => LINE_HEIGHT) do
      stroke_color '000000'
      stroke_bounds
    end

    bounding_box([320,@v_position], :width => 230, :height => LINE_HEIGHT) do
      stroke_color '000000'
      stroke_bounds
    end

  end

  def table_data

    @v_position -= 31

    if students.nil? || students.size <= 0
      move_cursor_to @v_position
      text "Nenhum estudante encontrado", :align => :center 
    end

    index = 1

    students.each do |name|

      draw_text index, :at => [10, @v_position]
      draw_text name[0].titleize,  :at => [40, @v_position]

      @v_position += 13

      bounding_box([0,@v_position], :width => 30, :height => LINE_HEIGHT) do
        stroke_color '000000'
        stroke_bounds
      end

      bounding_box([30,@v_position], :width => 290, :height => LINE_HEIGHT) do
        stroke_color '000000'
        stroke_bounds
      end

      bounding_box([320,@v_position], :width => 230, :height => LINE_HEIGHT) do
        stroke_color '000000'
        stroke_bounds
      end  

      @v_position -= 31
      index += 1

    end

  end

  def row(col1, col2, col3)
    draw_text col1, :at => [10, 550]
    draw_text col2, :at => [80, 550]
    draw_text col3, :at => [350, 550]

    bounding_box([0,570], :width => 50, :height => LINE_HEIGHT) do
      stroke_color '000000'
      stroke_bounds
    end

    bounding_box([50,570], :width => 270, :height => LINE_HEIGHT) do
      stroke_color '000000'
      stroke_bounds
    end

    bounding_box([320,570], :width => 230, :height => LINE_HEIGHT) do
      stroke_color '000000'
      stroke_bounds
    end
  end

  def sub_header
    
    move_cursor_to 645

    #text 'Professor(es)'
    #table([['']], :cell_style=>{:height=>LINE_HEIGHT, :width=>550})    
    
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