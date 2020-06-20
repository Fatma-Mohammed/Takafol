class CasesController < ApplicationController
  before_action :set_case, only: [:show, :edit, :update, :destroy  ]
  # skip_before_action :verify_authenticity_token

  before_action :check_if_charity_is_verified, only: [:freeindex, :updatestate, :freeprotect]

  # GET /cases
  # GET /cases.json
  def index
    @cases = Case.where("amount_needed > #{:amount_obtained}" ).verified.page params[:page]
    @governorates = Governorate.all
    @cities = City.all
    # @cases =Case.all.page params[:page]
  end

  #Free Cases Index
  def freeindex
    @charities_cases_set = CharitiesCase.all.map{|c| c.case_id}
    @cases = Case.where.not(id: @charities_cases_set).order(priority: :desc).page params[:page]
    # @cases = Case.all.order(priority: :desc).page params[:page]
  end

  #Profile
  def profile
    @cases = Case.all.page params[:page]
    render 'profile'
  end

  # GET /cases/1
  # GET /cases/1.json
  def show
    c = Case.find(params["id"])
    if c.charities_cases.count > 0 || charity_signed_in?
      @case = c
    else
      redirect_to cases_path, notice: 'Case not found. or you may not have access to it'
    end
  end

  # Add Case to Donor
  def protect
    @case = Case.find(params["id"])
    if @case.donors_cases.where('state in (?)' , ["pending","cancelled","rejected"]).count < 1
      @case.donors << current_donor
    end
    @case.donors_cases.update(state: "pending" )
    redirect_to case_path(@case)
  end

  #Remove Donor's Protection
  def remove
    if current_donor
    id = current_donor.id
    @case = Case.find(params["id"])
    @case.donors_cases.where(donor_id = "#{id}").first.update(state: "cancelled")
    if @case.donors_cases.where(donor_id = "#{id}").first.state == "cancelled"
       @case.charities_cases.last.update(state: "protected")
    end
    end
    redirect_to cases_path

  end



  #Charity's Approval to Donor's Request
  def updatestate
    @id = params["id"].to_i
    @case =Case.find(@id)
    @case.donors_cases.last.update(state: params["case"]["donors_cases"]["state"])
    if @case.donors_cases.last.state =="approved"
      logger.info 'yessssssss i entered the if block'

      @case.charities_cases.last.update(state: "released")
    end
    redirect_to cases_path
    # redirect_to hi
    # render plain("hiiii")

  end

  #Charity protects the case
  def freeprotect
    @case = Case.find(params["id"])
    @case.charities << current_charity
    @case.charities_cases.update(state: "protected" )
    redirect_to :free_cases
  end






  # GET /cases/new
  def new
    @case = Case.new
  end

  # GET /cases/1/edit
  def edit
  end

  # POST /cases
  # POST /cases.json
  def create

    #If a Charity is signed in the case will be assigned to it automatically
    if current_charity
      @case = @current_charity.cases.create(case_params_charity)
      @case.perform_image_validation = false
      respond_to do |format|
        if @case.save
          format.html { redirect_to @case, notice: 'Case was successfully created.' }
          format.json { render :show, status: :created, location: @case }
          @case.charities_cases.first.update(state: "protected")
        else
          format.html { render :new }
          format.json { render json: @case.errors, status: :unprocessable_entity }
        end
      end

    else

      @case = Case.new(case_params)
      @case.perform_image_validation = true

      respond_to do |format|
        if @case.save
          flash[:city_id] = @case.city_id
          format.html { redirect_to new_case_path, notice: 'Your data was received and we will get back to you soon.' }
          format.json { render :show, status: :created, location: @case }
        else
          format.html { render :new }
          format.json { render json: @case.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # PATCH/PUT /cases/1
  # PATCH/PUT /cases/1.json
  def update
    respond_to do |format|
      if @case.update(case_params)
        format.html { redirect_to @case, notice: 'Case was successfully updated.' }
        format.json { render :show, status: :ok, location: @case }
      else
        format.html { render :edit }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cases/1
  # DELETE /cases/1.json
  def destroy
    @case.destroy
    respond_to do |format|
      format.html { redirect_to cases_url, notice: 'Case was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def loggedCharity_cases
    if current_charity
    id = current_charity.id
    current_charity_set = Charity.find(id).charities_cases.where(state: "protected").map{|i| i.case_id}
    @cases =Case.where(id: current_charity_set).page params[:page]
    end
  end

  def logged_charity_pending_cases
    if current_charity
    id = current_charity.id
    @cases = Case.joins(:donors_cases).joins(:donors).where("donors_cases.state = 'pending'").joins(:charities_cases).joins(:charities).where("charities.id = #{id}").page params[:page]
    end

  end

  def logged_donor_cases
    if current_donor
    id = current_donor.id
    # TODO: fixme: error in selecting, wrong results
    # @cases = Case.all.where(id:(Case.all.where(donor_id:"#{id}", state:"approved")))
    # @cases =Case.all.where() Donor.find(id).donors_cases.where(state: "approved")
    current_donor_set = Donor.find(id).donors_cases.where(state: "approved").map{|i| i.case_id}

    @cases =Case.where(id: current_donor_set).page params[:page]
    end
  end

  def logged_donor_pending_cases
    if donor_signed_in?
      @cases = Case.joins(:donors_cases).joins(:donors)
            .where("donors_cases.state = ? and donors_cases.donor_id = ?", 'pending', current_donor.id).page params[:page]    else
      redirect_to root_path
    end
  end
  #Search Button
  def search
    search = params[:search].present? ? params[:search] : nil
    @governorates = Governorate.all
    @cities = City.all
    @cases =
    if search
      Case.where(job: search).page params[:page]
      end

  end


  #Filter by address
  def filter
    city = params[:city_id].present? ? params[:city_id] : nil

    if city
      @cases = Case.where(city_id: city).page params[:page]
        else
    @cases
    @cases.page params[:page]
    end

  end



  private
  # Use callbacks to share common setup or constraints between actions.
  def set_case
    @case = Case.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def case_params
    params.fetch(:case).permit(:name , :job ,:email , :national_id , :phone , :children_num ,:marital_status , :NID_img, :description, :city_id, :address)
  end

  #Charity's Special Params to add Case
  def case_params_charity
    params.fetch(:case).permit(:name , :email , :job , :national_id , :phone ,:children_num, :marital_status, :description, :priority ,:amount_needed, :city_id, :address)
  end

  def check_if_charity_is_verified
    if charity_signed_in?
      if !current_charity.verified?
        redirect_to root_path, error: 'You are not allowed to access this part of the site'
      end
    end
  end

end
