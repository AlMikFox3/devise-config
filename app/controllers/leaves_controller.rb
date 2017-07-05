class LeavesController < ApplicationController
  before_action :set_leave, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :verify_is_admin, :only => [:apply_index]

  # GET /leaves
  # GET /leaves.json
  def index
    @leaves = current_user.leaves
  end

  # GET /leaves/1
  # GET /leaves/1.json
  def show

  end

  # GET /leaves/new
  def new
    @leave = Leave.new
  end

  # GET /leaves/1/edit
  def edit
  end

  # POST /leaves
  # POST /leaves.json
  def create
    #@leave = Leave.new(leave_params)
    @leave = current_user.leaves.create(leave_params)
    respond_to do |format|
      if @leave.save
        format.html { redirect_to @leave, notice: 'Leave was successfully created.' }
        format.json { render :show, status: :created, location: @leave }
      else
        format.html { render :new }
        format.json { render json: @leave.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leaves/1
  # PATCH/PUT /leaves/1.json
  def update
    respond_to do |format|
      if @leave.update(leave_params)
        format.html { redirect_to @leave, notice: 'Leave was successfully updated.' }
        format.json { render :show, status: :ok, location: @leave }
      else
        format.html { render :edit }
        format.json { render json: @leave.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leaves/1
  # DELETE /leaves/1.json
  def destroy
    @leave.destroy
    respond_to do |format|
      format.html { redirect_to leaves_url, notice: 'Leave was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def apply_index
    @leaves = Leave.where(:approval => false)

    #puts (@u.id)
    #@u.banned = true
    #@u.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leave
      @leave = Leave.find(params[:id])
      @u = User.find(current_user.id)
      if @leave.user_id != current_user.id && @u.admin == false
        redirect_to leaves_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leave_params
      params.require(:leave).permit(:ltype, :duration, :user_id)
    end

    def verify_is_admin
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
    end
end