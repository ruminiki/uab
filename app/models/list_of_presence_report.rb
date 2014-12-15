class ListOfPresenceReport < PdfReport

  require "prawn"
  require "prawn/table"

  TABLE_WIDTHS = [20, 100, 30, 60]
  TABLE_HEADERS = ["ID", "Name", "Date", "User"]

  def initialize(course_class=[])
    super()
    @course_class = course_class

    header 'LISTA DE PRESENÇA TURMA ' + course_class.name 

    text 'Disciplina'
    table([['']], :cell_style=>{:height=>18, :width=>535})

    move_cursor_to 645

    text 'Professor(es)'
    table([['']], :cell_style=>{:height=>30, :width=>535})    
    
    move_cursor_to 595

    text 'Tutor(es)'
    table(employees,:column_widths=>[295,240])

    table([["N.", "Nome", "Assinatura"]],:column_widths=>[25,270,240])
   
    display_course_class_table

    footer
  end

  private

  def display_course_class_table
    if table_data.empty?
      text "Nenhum aluno encontrado"
    else
      table(table_data,:column_widths=>[25,270,240])
    end
  end

  def employees
    @employees = @course_class.employees.map{ |e| [e.name, ""] }
  end

  def table_data
    @table_data ||= @course_class.registrations.map{ |r| [r.id, r.student.name, ""] }
  end

end