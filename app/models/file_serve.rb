class FileServe < ActiveRecord::Base
	attr_accessible :course_id, :title, :file_name, :file_url
end