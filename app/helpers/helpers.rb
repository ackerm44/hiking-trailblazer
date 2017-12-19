class Helpers
  
  def self.current_user(session)
    @hiker = Hiker.find_by_id(session[:user_id])
  end
  
  def self.logged_in?(session)
    !!session[:id]
  end

end
