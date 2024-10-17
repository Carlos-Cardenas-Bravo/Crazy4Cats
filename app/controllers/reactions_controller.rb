class ReactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create_or_update
    # evito multiples reacciones al mismo post por el mismo usuario
    @reaction = Reaction.find_or_initialize_by(user: current_user, post: @post)

    # Actualiza el tipo de reacción (like, dislike, etc.)
    if @reaction.update(reaction_params)
      flash[:notice] = "Tu reacción ha sido registrada"
    else
      flash[:alert] = "No se pudo registrar tu reacción"
    end

    redirect_to @post
  end

  private

  def set_post
    @post = Post.find(params[:post_id]) # se obtiene el post al cual se está reaccionando
  end

  def reaction_params
    params.require(:reaction).permit(:kind) # solo permite el campo kind
  end
end
