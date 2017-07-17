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
=begin
    @u = User.all
    @ar = Array.new
    @arn = Array.new
    @u.each do |us|
      @ar.push(us.id)
      @arn.push(us.name)
    end
=end
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
      @leave.duration = (@leave.to_date - @leave.from_date).to_i
      @leave.fin_year = financial_year(@leave)
      if @leave.save
        LeaveMailer.welcome_email(@leave).deliver_later
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

  def approve_leave
    @leave = Leave.find(params[:id])
    @leave.approval = true
    @u = User.find(@leave.user_id)
        @ul = UserLeave.where(:user_id => @u.id, :leave_type => @leave.ltype, :fin_year => @leave.fin_year)
        @ul1 = @ul[0]
        @ul1.leave_taken = @ul1.leave_taken + @leave.duration
        @ul1.leave_left = @ul1.leave_left - @leave.duration
        @ul1.save
    @leave.save
    LeaveMailer.approve_leave_mail(@leave).deliver_later
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
      params.require(:leave).permit(:ltype, :duration, :user_id, :from_date, :to_date)
    end

    def verify_is_admin
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
    end
    def financial_year(leave)
    d = leave.to_date
    m = d.month
    if m > 3
      y = d.year
      ypo = y + 1
      y = y.to_s
      ypo = ypo.to_s
      a = y + "-" + ypo.byteslice(2,4)
      return a
    else
      y = d.year - 1 
      ypo = y + 1
      y = y.to_s
      ypo = ypo.to_s
      a = y + "-" + ypo.byteslice(2,4)
      return a
    end
  end
end
