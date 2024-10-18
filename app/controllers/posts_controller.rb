# rubocop:disable Layout/SpaceInsideArrayLiteralBrackets
class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]  # Permite ver posts sin autenticación
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # GET /posts or /posts.json
  def index
#    @pagy, @posts = pagy(Post.order(created_at: :desc), items: Pagy::DEFAULT[:items])
    @pagy, @posts = pagy(Post.all)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.includes(:comments, :reactions).find(params[:id])
    @comment = @post.comments.new  # se agrega @comment para el formulario de nuevo comentario
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user if user_signed_in? # asigno al usuario autenticado, si existe

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post creado exitosamente." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post actualizado." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if current_user == @post.user || current_user.admin?
      @post.destroy!
      respond_to do |format|
        format.html { redirect_to posts_path, status: :see_other, notice: "Post eliminado." }
        format.json { head :no_content }
      end
    else
      redirect_to posts_path, alert: "No estás autorizado para eliminar este post."
    end
  end

  private
    def authorize_user!
      unless current_user == @post.user || current_user.admin?
        redirect_to posts_path, alert: "No estás autorizado para realizar esta acción."
      end
    end

    # Use callbacks to share common setup or constraints between actions.s
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :image)
    end
end

# rubocop:enable Layout/SpaceInsideArrayLiteralBrackets
