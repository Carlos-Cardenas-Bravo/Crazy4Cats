class CommentsController < ApplicationController
  before_action :set_post, only: [:new, :create]
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = @post.comments.new
  end

  # POST /comments or /comments.json
  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user if user_signed_in? # se asigna el usuario si está autenticado, o se deja en nil si es visita

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: "El comentario fue creado exitosamente." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.post, notice: "El comentario fue actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to @comment.post, status: :see_other, notice: "El comentario fue eliminado exitosamente." }
      format.json { head :no_content }
    end
  end

  private
    # encuentro el post relacionado al comentario
    def set_post
      @post = Post.find(params[:post_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # user_id y el post_id pasan automaticamente en el controlador no como parametros
    def comment_params
      params.require(:comment).permit(:content)
    end
end

