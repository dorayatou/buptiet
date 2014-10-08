Buptiet::Application.routes.draw do
  get 'add_student_to_list/:problem_id' => 'answer_student_lists#add_student_to_list', as: 'add_student_to_list'
  
 	# 开放信息路由文件
  # get 'buptiet/open_example' => 'open_infos#open_example'
  get 'buptiet/open_students_info' => 'open_infos#open_students_info'
  get 'buptiet/open_student_select_course_info' => 'open_infos#open_student_select_course_info'
  get 'buptiet/open_votes_info' => 'open_infos#open_votes'
  get 'buptiet/open_exercises_info' => 'open_infos#open_exercises'

  # 精细辨认路由文件
  # 登陆
  get 'buptiet/identifier=:identifier/password=:password' => 'user_sessions#login_a'
  # 请求用户信息
  get 'buptiet/students/get_student_info' => 'students#get_student_info'
  # 查询精细辨认课程的测试信息
  # get 'buptiet/students/name=:name/practice_tone_scores' => 'practice_tone_scores#index'
  # get 'buptiet/students/name=:name/finding_tone_scores' => 'finding_tone_scores#index'
  # get 'buptiet/students/name=:name/playing_tone_scores' => 'playing_tone_scores#index'
  get '/current_courses/:course_id/current_quiz/:quiz_id/practice_tone_scores' => 'practice_tone_scores#index', :as => 'practice_tone_scores'
  get '/current_courses/:course_id/current_quiz/:quiz_id/finding_tone_scores' => 'finding_tone_scores#index', :as => 'finding_tone_scores'
  get '/current_courses/:course_id/current_quiz/:quiz_id/playing_tone_scores' => 'playing_tone_scores#index', :as => 'playing_tone_scores'
  # 像数据库中添加数据
  post 'buptiet/students/name=:name/finding_tone_scores' => 'finding_tone_scores#create'
  post 'buptiet/students/name=:name/practice_tone_scores' => 'practice_tone_scores#create'
  post 'buptiet/students/name=:name/playing_tone_scores' => 'playing_tone_scores#create'

  # 学生入学智力水平测试路由文件
  post 'iq_tests' => 'iq_tests#create'
  get 'iq_tests/identifier=:identifier/password=:password' => 'user_sessions#login_c'
  # get 'iq_tests/students/get_student_info' => 'students#get_student_info'

  # 图形操作课程路由文件
  get 'image_courses/identifier=:identifier/password=:password' => 'user_sessions#login_c'
  post 'image_courses' => 'image_courses#create'
  # get 'image_courses/students/get_student_info' => 'students#get_student_info'


  # 视频公开课路由文件
  # 添加数据到数据库接口路由（不属于系统开发）
  get 'buptcourses/course_infos/new' => 'buptcourses#new', :as => 'newcourse_info'
  post 'buptcourses/course_infos' => 'buptcourses#create'
  get 'buptcourses/lesson_infos/new' => 'buptlessons#new', :as => 'newlesson_info'
  post 'buptcourses/lesson_infos'
  get 'buptcourses/exercise_infos/new' => 'buptexercises#new', :as => 'newexercise_info'
  post 'buptcourses/exercise_infos'
  # get 'buptcourses/buptcourse_id=:buptcourse_id/lesson_infos/new' => 'buptlessons#new', :as => 'newlesson_info'
  # post 'buptcourses/buptcourse_id=:buptcourse_id/lesson_infos' => 'buptlessons#create'
  # get 'buptcourses/buptcourse_id=:buptcourse_id/buptlesson_id=:buptlesson_id/exercise_infos/new' => 'buptexercises#new', :as => 'newexercise_info'
  # post 'buptcourses/buptcourse_id=:buptcourse_id/buptlesson_id=:buptlesson_id/exercise_infos' => 'buptexercises#create'

  # 登陆
  get 'buptcourse/identifier=:identifier/password=:password' => 'user_sessions#login_b'
  # 请求课程信息
  get 'buptcourses' => 'buptcourses#index'
  get 'buptcourses/courseid=:id' => 'buptcourses#show'
  # 请求lesson信息
  get 'buptcourses/lessons/lessonid=:id' => 'buptcourses#show_lesson'
  get 'buptcourses/buptlessons/lessonid=:id' => 'buptcourses#show_lesson'
  # 请求练习信息
  get 'buptexercise/courseid=:id' => 'buptcourses#show_course_exercise'
  get 'buptexercise/lessonid=:id' => 'buptcourses#show_lesson_exercise'
  # 请求评论信息
  get 'buptcomment/courseid=:id' => 'buptcourses#show_course_comment'
  get 'buptcomment/lessonid=:id' => 'buptcourses#show_lesson_comment'
  # 插入评论信息
  match 'buptcomment/insertcomment/courseid=:course_id/lessonid=0/username=:user_name/commentcontent=:comment_content/commenttime=:comment_time' => 'buptcourses#insert_course_comment'
  match 'buptcomment/insertcomment/courseid=0/lessonid=:lesson_id/username=:user_name/commentcontent=:comment_content/commenttime=:comment_time' => 'buptcourses#insert_lesson_comment'
  #插入收藏
  match 'buptfavourite/insertfavourite/username=:user_name/courseid=:course_id/course_name=:course_name/favo_time=:favo_time' => 'buptfavorites#insert_favorite'
  #请求收藏信息
  get 'buptfavourite/username=:user_name' => 'buptfavorites#show_user_fav', :as => :show_user_fav
  #删除收藏信息
  match 'buptfavourite/deletefavourite/username=:user_name/courseid=:course_id' => 'buptfavorites#destory'
  #搜索信息
  # get 'search/searchcontent=:name' => 'courses#search'
  get 'search/searchcontent=:content' => 'buptcourses#search'
  #请求练习
  get 'buptplayingexercise/lessonid=:lesson_id' => 'buptplaying_exercises#show'
  # 上传学习记录
  
  post 'buptcourses/reports' => 'reports#create'


  # 泛在教育平台中应用的路由文件
  get '/courses/:course_id/exercises' => 'exercises#student_other_course_quiz', :as => "student_other_course_quiz"
  get 'courses/:course_id/exercises/:quiz_id/analyses' => 'analyses#other_quiz_analyse', :as => "other_quiz_analyse"


  # 课堂交互工具路由文件
  resources :file_serves
  # 更多消息
  get '/messages/:id/show_message' => 'messages#show_message', :as => "show_message"
  get '/messages/:id/show_message_comments' => 'messages#show_message_comments', :as => "show_message_comments"
  get '/messages/:id/show_student_comments/new' => 'comments#new_message_comment', :as => "new_message_comment"
  post '/messages/:id/show_student_comments' => 'comments#create_message_comment'
  delete 'messages/:post_id/show_student_comments/:id' => 'comments#destroy_message_comment', :as => "destroy_message_comment"
  get '/messages/student_all_post_messages'
  get '/messages/teacher_all_post_messages'
  
  # 学生模块的群组，群组消息与评论
  # 关于学生群组，包括群组索引（学生没有权限创建、编辑、更新群组）
  get 'room/groups' => 'groups#student_groups', :as => "student_groups"
  # 关于学生群组消息，包括消息索引、创建新消息、编辑更新消息，删除、展示某个消息等七个动作
  get 'room/groups/:group_id/posts' => 'posts#student_posts', :as => "student_posts"
  post 'room/groups/:group_id/posts' => 'posts#create'
  get 'room/groups/:group_id/posts/new' => 'posts#new', :as => "new_student_post"
  get 'room/groups/:group_id/posts/:id/edit' => 'posts#edit', :as => "edit_student_post"
  get 'room/groups/:group_id/posts/:id' => 'posts#student_show_post', :as => "student_show_post"
  put 'room/groups/:group_id/posts/:id' => 'post#update'
  delete 'room/groups/:group_id/posts/:id' => 'posts#destroy', :as => 'destroy_student_post'
  # 关于学生群组消息的评论，包括评论索引、创建新评论、编辑更新评论，删除、展示某个评论等七个动作
  get 'room/groups/:group_id/posts/:post_id/comments' => 'comments#student_comments', :as => "student_comments"
  post 'room/groups/:group_id/posts/:post_id/comments' => 'comments#create'
  get 'room/groups/:group_id/posts/:post_id/comments/new' => 'comments#new', :as => "new_student_comment"
  get 'room/groups/:group_id/posts/:post_id/comments/:id/edit' => 'comments#edit', :as => "edit_student_comment"
  get 'room/groups/:group_id/posts/:post_id/comments/:id' => 'comments#show_student_comment', :as => "show_student_comment"
  put 'room/groups/:group_id/posts/:post_id/comments/:id' => 'comments#update'
  delete 'room/groups/:group_id/posts/:post_id/comments/:id' => 'comments#destroy', :as => "destroy_comment"

  # 教师模块的群组，群组消息以及消息评论
  resources :groups do
    resources :posts do
      resources :comments do 
      end
    end
  end  

  # 问题墙
	get 'problems_wall' => 'problems#problems_wall', as: 'problems_wall'
  resources :problems do
    collection do
      get 'room/index_teacher' => 'problems#index_teacher', :as => "index_teacher"
      get 'room/index_student' => 'problems#index_student', :as => "index_student"
      get 'room/problem_zan/:problem_id' => 'problems#problem_zan', as: 'problem_zan'
			get 'room/problems/:problem_id' => 'problems#destroy', as: 'delete_problem'
	 	end
  end
  
  #users sessions
  controller :user_sessions do
    get '' => :new, as: 'login'
    post '' => :login
    get 'logout' => 'user_sessions#logout'
    delete 'logout' => :logout
  end
 
  resources :admins do
    collection do
      get :show_all_admins
      get :show_all_users
      get :show_all_courses
      get :show_all_quizzes
      get :show_course_times
			get :show_previews
    end
  end

  resources :academies

  resources :offers

  # resources :selects do 
  #   collection do
  #     get :student_add
  #     post :student_add
  #   end
  # end
get '/selects' => 'selects#index', :as => "selects"
get '/selects/:course_id' => 'selects#show', :as => "select"
post '/selects/:course_id' => 'selects#student_add'
get '/selects/:course_id/student_list' => 'selects#student_list', :as => "student_list"
  

  resources :teachers do 
    collection do
      get 'student_add/student' => 'teachers#students'
      post 'student_add/student' => 'teachers#student_add'
    end
  end
  resources :teacher_infos
  
  resources :students do
    collection do
      get 'course_add/courses' => 'students#courses'
      post 'course_add/courses' => 'students#course_add'
      get 'group_add/group' => 'students#groups'
      post 'group_add/group' => 'students#group_add'
    end
  end

  resources :student_infos
  
  resources :courses
 

# 学生的quiz模块,quizzes与exercises是同一个模型两个不同的名字
  get '/exercises' => 'exercises#index', :as => 'exercises'
  get '/exercises/:exercise_id' => 'exercises#show', :as => 'exercise'
  get '/exercises/:exercise_id/questions/:question_id' => 'questions#student_show_question', :as => 'student_show_question'

  

  # get '/exercises/:exercise_id/questions/:question_id/answers/new' => 'answers#new', :as => 'new_answer'
  # post '/exercises/:exercise_id/questions/:question_id/answers/' => 'answers#create'
  # get '/exercises/:exercise_id/questions/:question_id/answers/:answer_id' => 'answers#show', :as => 'show_answer'
  get 'exercises/:exercise_id/answers' => 'answers#index', :as => 'answers'
  get 'exercises/:exercise_id/answer_results' => 'answers#answer_results', :as => 'answer_results'
  
  # 开始答题
  get '/exercises/:exercise_id/questions/:question_id/answers/show_answer' => 'answers#show_answer', :as => 'show_question_answer'
  post '/exercises/:exercise_id/questions/:question_id/answers/answer_question' => 'answers#answer_question'
  
  get '/exercises/:exercise_id/questions/:question_id/analyses/show_analyse' => 'analyses#show_analyse', :as => 'show_analyse'
  get '/exercises/:exercise_id/questions/:question_id/analyses/show_wrong_question_analyse' => 'analyses#show_wrong_question_analyse', :as => 'show_wrong_question_analyse'
  

  post '/exercises/:exercise_id/questions/:question_id/analyses/show_analyse' => 'favourites#fav_question'
  delete '/exercises/:exercise_id/questions/:question_id/analyses/show_analyse' => 'favourites#destroy_fav_question', :as => 'destroy_fav_question'

  post '/exercises/:exercise_id/questions/:question_id/analyses/show_wrong_question_analyse' => 'favourites#fav_wrong_question'
  delete '/exercises/:exercise_id/questions/:question_id/analyses/show_wrong_question_analyse' => 'favourites#destroy_fav_wrong_question', :as => 'destroy_fav_wrong_question'

  # 收藏题库
  get '/favourites' => 'favourites#index', :as => 'favourites'

  get '/favourites/questions/:question_id' => 'favourites#show_fav', :as => 'show_fav'
  post '/favourites/questions/:question_id' => 'favourites#show_fav'
  
  get '/favourites/questions/:question_id/show_fav_answer/:option_id' => 'favourites#show_fav_answer', :as => 'show_fav_answer'
  
  # 错题库
  get 'error_banks' => 'error_banks#index', :as => 'error_banks'
  get 'error_banks/questions/:question_id' => 'error_banks#show', :as => 'show_error'
  # post 'error_banks/questions/:question_id' => 'error_banks#error_answer'
  post 'error_banks/questions/:question_id' => 'error_banks#show'

  get 'error_banks/questions/:question_id/show_error_answer/:option_id' => 'error_banks#show_error_answer', :as => 'show_error_answer'
  # 管理员的quiz模块,包括新建测试、新建试题和选项等。统计信息？
  
  resources :courses do
    resources :quizzes do
      resources :questions do
        resources :options do
        end
        resources :analyses do
        end
      end
      resources :analyses do
      end
    end
  end

  # 教师登陆quiz模块
  get '/current_courses/:course_id/quizzes' => 'quizzes#teacher_quiz', :as => 'teacher_quiz'
  get '/current_courses/:course_id/current_quiz/:quiz_id' => 'quizzes#teacher_show_quiz', :as => 'teacher_show_quiz'
  
  
  # 投票模块
  # 投票主体与观点
  resources :topics do
    collection do
      get "/show_all_topics" => 'topics#show_all_topics', :as => "show_all_topics"
      get "/show_my_topics" => 'topics#show_my_topics', :as => "show_my_topics"
      get "/show_hot_topics" => 'topics#show_hot_topics', :as => "show_hot_topics"
      get "/show_latest_topics" => 'topics#show_latest_topics', :as => "show_latest_topics"
      get '/show_all_hot' => 'topics#show_all_hot'
      get '/show_all_lastest' => 'topics#show_all_lastest'
    end
    resources :opinions do
    end
  end

 
  controller :votes do
    get 'votes/index' => 'votes#index', :as => "votes"
    get 'votes/show_all_votes' => 'votes#show_all_votes', :as => "show_all_votes"
    get 'votes/show_all_mine_refered' => 'votes#show_all_mine_refered', :as => "show_all_mine_refered"
    get 'votes/show_latest_votes' => 'votes#show_latest_votes', :as => "show_latest_votes"
    get 'votes/show_hot_votes' => 'votes#show_hot_votes', :as => "show_hot_votes"
    get 'votes/show_all_mine_refered', :as => 'votes#show_all_mine_refered', :as => 'show_all_mine_refered'
    get 'votes/show_vote/:topic_id' => 'votes#show_vote', :as => "show_vote"
    get 'votes/show_my_refered_vote/:topic_id' => 'votes#show_my_refered_vote', :as => 'show_my_refered_vote'
    post 'cast_vote'
    get 'votes/show_vote_result/:topic_id' => 'votes#show_vote_result', :as => 'show_vote_result'
    get 'votes/show_all_lastest'
    get 'votes/show_all_hot'
  end



 # 课表管理（管理员权限）
	get 'courses/:course_id/student_previews' => 'previews#student_previews', :as => 'student_previews'
	get 'courses/:course_id/teacher_previews' => 'previews#teacher_previews', :as => 'teacher_previews'
#	put 'courses/:course_id/previews' => 'previews#index'
  resources :courses do
		
    resources :course_times do
    end
		resources :previews do
		end

  end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'user_sessions#new'


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
