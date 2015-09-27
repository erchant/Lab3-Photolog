class Image < ActiveRecord::Base
	
	has_attached_file :image, styles: { medium: '200x200>', thumb: '48x48>' }
	has_many :comments
	belongs_to :user

	validates :title,		:presence => true,
  							:length => {maximum: 50}
  	# validates :description,	:length => {maximum: 2000}

end

