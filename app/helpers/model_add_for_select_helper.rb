module ModelAddForSelectHelper

  #action invocada a partir de uma tela que tem associação com o respectivo modelo
  #após salvar, o sistema redireciona para window.close
  def add_for_select
    session[self.class.to_s.downcase  + "_is_adding_for_select"] = true
    redirect_to action: "new"
  end

  def close_window
    render 'window.close' if session[self.class.to_s.downcase  + "_is_adding_for_select"]
	session[self.class.to_s.downcase  + "_is_adding_for_select"] = false
  end

end
