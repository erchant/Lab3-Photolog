class UsersController < ApplicationController

	def index
    	@users = User.all
  end

  def show
   	 	@user = params[:user_id].blank? ? current_user : User.find(params[:user_id])
  end

  def update_attribute(attributes)
      self.attributes = attributes
      save
  end

  def reset

      @users = User.all
      @users.each do |user|
      user.update(:image_counter => 1)
      end
  end

  def actualize
    @users = User.all
        @users.each do |u|
          if u.daysGold > 0
            u.daysGold = [u.daysGold, -1].sum 
            u.save!
          else        
          end
          if u.role? and u.daysGold == 0 
            u.role = 0
            u.save!
          else
          end
          u.image_counter = 0
          u.save!
        end
    redirect_to payments_path
  end
    



end
