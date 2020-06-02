class CasesController < ApplicationController
  before_action :set_case, only: [:show, :edit, :update, :destroy ]

  # GET /cases
  # GET /cases.json
  def index
    @cases = Case.all
  end

  # GET /cases/1
  # GET /cases/1.json
  def show
    @case= Case.find(params["id"])
  end

  def provide
    @case = Case.find(params["case_id"])
    @case.donors << current_donor
    # redirect_to request.referrer
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

    if current_charity 

        @case = @current_charity.cases.create(case_params)
        @case.charities_cases.first.update(state: "protected")
        respond_to do |format|
          if @case.save
            format.html { redirect_to @case, notice: 'Case was successfully created.' }
            format.json { render :show, status: :created, location: @case }
          else
            format.html { render :new }
            format.json { render json: @case.errors, status: :unprocessable_entity }
          end
        end

      else 

        @case = Case.new(case_params)

        respond_to do |format|
          if @case.save
            format.html { redirect_to @case, notice: 'Case was successfully created.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case
      @case = Case.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def case_params
      params.fetch(:case).permit(:name , :job , :priority , :national_id)
    end
end