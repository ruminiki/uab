module ListOfPresencePdfHelper

  def generate_list_of_presence

	course_class = CourseClass.find(params[:id])
	pdf = ListOfPresenceReport.new(course_class)
	send_data pdf.render, filename: 'summary_report.pdf', type: 'application/pdf'
	  
  end


end
