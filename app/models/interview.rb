class Interview < ActiveRecord::Base
	:resume
	:sign
	has_many :questions
	belongs_to :case
end
