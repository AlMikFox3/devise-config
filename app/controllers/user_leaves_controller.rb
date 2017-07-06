class UserLeavesController < ApplicationController
  before_action :set_user_leave, only: [:show, :edit, :update, :destroy]
  before_filter :verify_is_admin

  # GET /user_leaves
  # GET /user_leaves.json
  def index
    @user_leaves = UserLeave.all
  end

  # GET /user_leaves/1
  # GET /user_leaves/1.json
  def show
  end

  # GET /user_leaves/new
  def new
    @user_leave = UserLeave.new
  end

  # GET /user_leaves/1/edit
  def edit
  end

  # POST /user_leaves
  # POST /user_leaves.json
  def create
    @user_leave = UserLeave.new(user_leave_params)

    respond_to do |format|
      if @user_leave.save
        format.html { redirect_to @user_leave, notice: 'User leave was successfully created.' }
        format.json { render :show, status: :created, location: @user_leave }
      else
        format.html { render :new }
        format.json { render json: @user_leave.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_leaves/1
  # PATCH/PUT /user_leaves/1.json
  def update
    respond_to do |format|
      if @user_leave.update(user_leave_params)
        format.html { redirect_to @user_leave, notice: 'User leave was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_leave }
      else
        format.html { render :edit }
        format.json { render json: @user_leave.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_leaves/1
  # DELETE /user_leaves/1.json
  def destroy
    @user_leave.destroy
    respond_to do |format|
      format.html { redirect_to user_leaves_url, notice: 'User leave was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_leave
      @user_leave = UserLeave.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_leave_params
      params.require(:user_leave).permit(:user_id, :leave_type, :leave_left, :leave_taken)
    end

    def verify_is_admin
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
    end
end
