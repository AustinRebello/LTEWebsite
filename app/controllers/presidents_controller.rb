class PresidentsController < ApplicationController
  before_action :set_president, only: %i[ show edit update destroy ]
  before_action :admin?, only: [:new, :create, :edit, :update, :destroy]

  # GET /presidents or /presidents.json
  def index
    @presidents = President.all
    @list = generate_nested_lists()
  end

  # GET /presidents/1 or /presidents/1.json
  def show
  end

  # GET /presidents/new
  def new
    @president = President.new
  end

  # GET /presidents/1/edit
  def edit
  end

  # POST /presidents or /presidents.json
  def create
    @president = President.new(president_params)

    respond_to do |format|
      if @president.save
        format.html { redirect_to president_url(@president), notice: "President was successfully created." }
        format.json { render :show, status: :created, location: @president }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @president.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /presidents/1 or /presidents/1.json
  def update
    respond_to do |format|
      if @president.update(president_params)
        format.html { redirect_to president_url(@president), notice: "President was successfully updated." }
        format.json { render :show, status: :ok, location: @president }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @president.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /presidents/1 or /presidents/1.json
  def destroy
    @president.destroy!

    respond_to do |format|
      format.html { redirect_to presidents_url, notice: "President was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_all_races
    year = params[:president][:date]
    delete_all_races(params[:president][:date])

    races = return_states()

    for state in races do
      @president = President.new(date: year, state: state)
      if @president.save
        #Yay, do nothing
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @president.errors, status: :unprocessable_entity }
      end
    end
    redirect_to action: "index"
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_president
      @president = President.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def president_params
      params.require(:president).permit(:date, :state)
    end

    

    def delete_all_races(year)
      President.where(date: year).destroy_all
    end

    

end
