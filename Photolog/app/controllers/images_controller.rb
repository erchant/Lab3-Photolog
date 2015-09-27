
class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
    
    #Selecciono id imagen abierta
      @image = Image.find(params[:id]);
    #Selecciono id imagen abierta (((Como Constante para trabajarla en los controladores)))
      image = Image.find(params[:id]);
    #Selecciono id del usuario creador de la imagen
      userimagen = User.find(image.user_id);
    #Selecciono las imagenes del usuario
      @ImagesUser = Image.all.where(:user_id => image.user_id);
    #Selecciono las imagenes de los amigos
      @ImagesFriend = Image.joins('INNER JOIN friendships ON images.user_id = friendships.friend_id').where("friendships.user_id" => userimagen);
    #Selecciono los comentarios de la imagen

      @comments = Comment.joins('LEFT JOIN users ON comments.user_id = users.id').where(:image_id => params[:id]);
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  
  #DEF CREADO!
  def create


      ##AHORA SI FUNCIONA ERA DOBLE == AHREHAR OR USER:GOLD? Y CAMBIAR Y PROBAR.

    
    @user = params[:user_id].blank? ? current_user : User.find(params[:user_id])
    
    @users = User.all


    if @user.image_counter == 0 or @user.role?

      @image = @user.images.create(image_params)
      @user.update(:image_counter => 1)
      #redirect_to reset_user_path and return
     redirect_to image_path(@image)

    else

      redirect_to images_path

    end

  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:title, :descrption, :user_id, :image)
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


  end

   



