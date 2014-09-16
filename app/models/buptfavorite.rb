class Buptfavorite < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :buptfavo_id, :user_name, :course_id, :course_name, :favo_time
    
    #verify fav
    def Buptfavorite.verify(user_name, course_id, course_name)
      if fav = Buptfavorite.find_by_user_name_and_buptcourse_id_and_course_name(user_name, course_id, course_name)
        fav
      end
    end
    
    def Buptfavorite.pass(user_name, course_id)
      if favorite = Buptfavorite.find_by_user_name_and_buptcourse_id(user_name, course_id)
        favorite
      end
    end
end
