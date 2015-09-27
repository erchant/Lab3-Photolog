class Payment < ActiveRecord::Base
  belongs_to :user
  	has_attached_file :image, styles: { medium: '400x400>', thumb: '480x480>' }

end
