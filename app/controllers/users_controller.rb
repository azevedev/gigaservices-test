class UsersController < ApplicationController
  before_action :get_user, only: %i[ show edit update destroy ]

  $MAX_USERS_PER_SEED = 30
  $DEFAULT_SEED = 'giga'
  # GET /users
  def index
    # If the search query is passed as a parameter, use it
    # In both cases, paginate the results
    if(params[:search].present?) 
      @users = User.search(params[:search]).paginate(params[:page])
    else
      @users = User.paginate(params[:page])
    end
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed" }
      format.json { head :no_content }
    end
  end

  # POST /users/add_random_users
  def add_random_users
    # Default values for the number of users to be added and the seed
    num = 1
    seed = $DEFAULT_SEED  
    
    # If the number of users is passed as a parameter, use it
    if(params[:number_of_users].present?) 
      num = params[:number_of_users] 
    end
    # If the number of users is greater than the maximum allowed, use the maximum allowed
    if(num.to_i > $MAX_USERS_PER_SEED) 
      num = $MAX_USERS_PER_SEED 
    end
    # If the number of users is less than 1, use 1
    if(num.to_i < 1) 
      num = 1 
    end
    # If the seed is passed as a parameter, use it
    if(params[:seed].present?) 
      seed = params[:seed]
    end
    
    # Create a new instance of the RandomDbSeeder class
    rs = RandomDbSeeder.new(num.to_i, seed)
    # Seed the database with the number of users specified and the seed specified
    users = rs.seed_users

    # Returns a json object with the count of users added
    render json: users
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:title, :name, :age, :gender, :phone, :email, :avatar)
    end
end
