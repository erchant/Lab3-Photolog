class Comment < ActiveRecord::Base
  belongs_to :image
  belongs_to :user

  validates :commenter,	:presence => true,
  						:length => {maximum: 1000}



end
