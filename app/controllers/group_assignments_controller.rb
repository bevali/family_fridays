class GroupAssignmentsController < ApplicationController
  before_action :set_group_assignment, only: [:show, :edit, :update, :destroy]

  def generate_groups
    GroupAssignment.delete_all
    num_of_users = User.where(active:true).count
    if num_of_users >= 3
      num_of_groups = num_of_users / 3
      num_of_extras = num_of_users % 3
      groups = []
      (1..num_of_groups).each do |group|
        groups = groups + ([group] * 3)
        if num_of_extras > 0
          groups.push(group)
          num_of_extras -= 1
        end
        if group == num_of_groups
          until num_of_extras <= 0 do
            groups.push(group)
            num_of_extras -= 1
          end
        end
      end
      puts groups
      groups = groups.shuffle
      puts groups
      User.where(:active => true).entries.each do |user|
        group = groups.pop
        @group_assignment = GroupAssignment.new(user: user, group: group)
        if @group_assignment.save
          flash[:notice] = "Group successfully generated."
        else
          flash[:error] = "Sorry, a group could not be saved."
        end
      end
    else
      flash[:error] = "Sorry, there are not enough users to create groups"
    end
    redirect_to action: "index"
  end

  # GET /group_assignments
  # GET /group_assignments.json
  def index
    @group_assignments = GroupAssignment.all.joins(:user)
      .order('group_assignments.group ASC, users.last_name ASC')
  end

  # GET /group_assignments/1
  # GET /group_assignments/1.json
  def show
  end

  # GET /group_assignments/new
  def new
    @group_assignment = GroupAssignment.new
  end

  # GET /group_assignments/1/edit
  def edit
  end

  # POST /group_assignments
  # POST /group_assignments.json
  def create
    @group_assignment = GroupAssignment.new(group_assignment_params)

    respond_to do |format|
      if @group_assignment.save
        format.html { redirect_to @group_assignment, notice: 'Group assignment was successfully created.' }
        format.json { render :show, status: :created, location: @group_assignment }
      else
        format.html { render :new }
        format.json { render json: @group_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_assignments/1
  # PATCH/PUT /group_assignments/1.json
  def update
    respond_to do |format|
      if @group_assignment.update(group_assignment_params)
        format.html { redirect_to @group_assignment, notice: 'Group assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_assignment }
      else
        format.html { render :edit }
        format.json { render json: @group_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_assignments/1
  # DELETE /group_assignments/1.json
  def destroy
    
    respond_to do |format|
      format.html { redirect_to group_assignments_url, notice: 'Group assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_assignment
      @group_assignment = GroupAssignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_assignment_params
      params.require(:group_assignment).permit(:user, :group)
    end
end
