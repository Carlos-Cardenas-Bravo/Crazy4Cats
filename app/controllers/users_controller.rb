class UsersController < ApplicationController
  before_action :authenticate_user! # asegura que haya un usuario autenticado
  before_action :authorize_admin    # solo los administradores pueden cambiar roles

  def index
    @users = User.all
  end

  def edit_role
    @user = User.find(params[:id])
  end

  def update_role
    @user = User.find(params[:id])

    # Verifica si el usuario que está siendo actualizado es el mismo que está logueado
    if current_user == @user && role_params[:role] == "normal_user"
      flash[:alert] = "No puedes cambiarte a un rol de usuario normal tú mismo."
      redirect_to root_path and return
    end

    # Verifica si es el único administrador en el sistema
    if @user.admin? && User.where(role: :admin).count == 1 && role_params[:role] == "normal_user"
      flash[:alert] = "No puedes cambiar este rol a normal_user, ya que es el único administrador."
      redirect_to edit_role_user_path(@user) and return
    end

    if @user.update(role_params)
      flash[:notice] = "El rol del usuario se ha actualizado correctamente."

      # Si el administrador se cambia a normal_user, redirige al root
      if current_user == @user && role_params[:role] == "normal_user"
        redirect_to root_path and return
      else
        # Redirigir a la lista de usuarios después de actualizar cualquier otro usuario
        redirect_to users_path and return
      end
    else
      flash[:alert] = "Hubo un problema al actualizar el rol."
      render :edit_role
    end
  end

  private

  def role_params
    params.require(:user).permit(:role)
  end

  def authorize_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "No estás autorizado para realizar esta acción."
    end
  end
end
