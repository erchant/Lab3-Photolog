class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json

  #DEF CREADO!
  def create

    #Forma burda, primero lo creo solo con ambas ID, luego le agrego el comentario.


    if user_signed_in?

    @image = Image.find(params[:image_id])
    @user = params[:user_id].blank? ? current_user : User.find(params[:user_id])
   @comment = @user.comments.create(:image => @image)
    @comment.update(comment_params)
    
  else


     @image = Image.find(params[:image_id])
    
   @comment = @image.comments.create(comment_params)
   
end
    #Forma burda, primero lo creo solo creoon ambas ID, luego le agrego el comentario.

    #@comment.user_id = @user.comments.update(comment_params)
    #@comment.user_id = current_user.id
    

   

    redirect_to image_path(@image)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    #MODIFIQUE PARA QUE SOLO PIDA PARAMETRO YA QUE LO OTRO LO LLENA AUTOMATICO.
    def comment_params
      params.require(:comment).permit(:commenter)
    end

    def update_attribute(name, value)
      name = name.to_s
      verify_readonly_attribute(name)
      send("#{name}=", value)
      save(validate: false)
    end

    #PROBANDO METODO PARA CREAR


 

end
