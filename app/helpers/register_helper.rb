module RegisterHelper
  def start_wizrd
    cookies[:register_wizard] = 1
  end

  def in_wizard
    cookies[:register_wizard]=='1'
  end

  def end_wizrd
    cookies.delete :register_wizard
  end
end
