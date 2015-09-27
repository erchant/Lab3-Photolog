class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @payments = Payment.all
    respond_with(@payments)
    @user = User.all.where("payments.user_id = users.id");
   # paymentUser = Payment.all
    #@paymentcheck = User.all.where(:id => paymentUser.id);

    if current_user.admin?
        @payments.each do |i|
          if i.state == 'Pagado'
            i.state = 'Aceptado'
            user = User.find(i.user_id);
            user.daysGold = i.day
            user.save!
            i.save!
          else
          end
        end
        @users = User.all
        @users.each do |u|
          if u.role?
          else
            if u.daysGold > 0
              u.role = 1
              u.save!
            else
            end
          end
        end
    else
    end
  end

  def show
    respond_with(@payment)
  end

  def new
    @payment = Payment.new
    respond_with(@payment)
  end

  def edit
  end

  def create
    @payment = Payment.new(payment_params)
    user = User.find(current_user)
    @payment.save
    @payment.update(:user_id => user.id)
    respond_with(@payment)
  end

  def update
    @payment.update(payment_params)
    respond_with(@payment)
  end

  def destroy
    @payment.destroy
    respond_with(@payment)
  end

  private
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:comment, :day, :state, :user_id, :image)
    end




end
