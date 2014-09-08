class Question < ActiveRecord::Base
	:text
	:answer
	belongs_to :interview
end
