class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  #before_action :configure_permitted_parameters, only: [:create, :edit, :update]
  before_action :resource_params, if: :devise_controller?
  before_action :authenticate_user! #, except [:destroy, :create]
  helper_method :sort_column, :sort_direction

  # GET /users
  # GET /users.json
  def index
    @users = User.all.paginate(:page => params[:page]).order([sort_column, sort_direction].join(" "))
  end

  def search
    if current_user.group == "admin"
      @users=User.where("first_name like ? or last_name like ?","%#{params[:search]}%","%#{params[:search]}%").paginate(:page => params[:page]).order([sort_column, sort_direction].join(" "))
    else
      @users=User.where("first_name like ? or last_name like ? and country_id like ?","%#{params[:search]}%","%#{params[:search]}%",current_user.country_id).paginate(:page => params[:page]).order([sort_column, sort_direction].join(" "))
    end
    render 'index'
  end

  # GET /users/new
  def new
    @user = User.new
    @groups = ['admin','user','revisor','operator']
  end

  def create
    respond_to do |format|
      @user = User.new(user_params)
      if @user.save
        format.html { redirect_to users_path, notice: 'Nuovo account creato.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :new, alert: 'Problemi con la creazione di un nuovo account' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/1/edit
  def edit
    @groups = ['admin','doctor','recruiter','reception']
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        #Rails.logger.debug("123: " + user_params)
        format.html { redirect_to users_path, notice: 'Account aggiornato.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "last_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :user_name, :first_name, :middle_name, :last_name, :group, :password, :password_confirmation)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
    u.permit(:profile_image_cache_id, :profile_image, :first_name, :middle_name, :last_name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:profile_image_cache_id, :profile_image, :first_name, :middle_name, :last_name, :email, :password, :password_confirmation)
    end
  end
  def resource_params
    devise_parameter_sanitizer.for(:sign_up) {|user| user.permit(:profile_image_cache_id, :profile_image, :first_name, :middle_name, :last_name, :email, :password, :password_confirmation)}
  end

end
