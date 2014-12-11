module ModelSearchHelper

	def search(params, model)

		params.each do |key,value|
	      if key.start_with?( 'search_')
			session[key] = value
	      end	
	    end

		model.search(session).page(params[:page]).per(10)
	   
	end

end
