class GovernorsController < ApplicationController
  before_action :set_governor, only: %i[ show edit update destroy ]
  before_action :admin?, only: [:new, :create, :edit, :update, :destroy]

  # GET /governors or /governors.json
  def index
    @governors = Governor.all
    @list = generate_nested_lists()
  end

  # GET /governors/1 or /governors/1.json
  def show
  end

  # GET /governors/new
  def new
    @governor = Governor.new

    @states = return_states()

  end

  # GET /governors/1/edit
  def edit
  end

  # POST /governors or /governors.json
  def create
    @governor = Governor.new(governor_params)

    if Governor.where(date: @governor.date, state: @governor.state).exists?
      respond_to do |format|
        @governor.errors.add(:date, 'This race already exists!')
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @governor.errors, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        if @governor.save
          format.html { redirect_to governor_url(@governor), notice: "Governor Race was successfully created." }
          format.json { render :show, status: :created, location: @governor }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @governor.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # PATCH/PUT /governors/1 or /governors/1.json
  def update
    respond_to do |format|
      if @governor.update(governor_params)
        format.html { redirect_to governor_url(@governor), notice: "Governor was successfully updated." }
        format.json { render :show, status: :ok, location: @governor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @governor.errors, status: :unprocessable_entity }
      end
    end
  end


  def add_bulk_races
    year = params[:governor][:date]
    delete_all_races(params[:governor][:date])

    races = params[:governor][:state]

    for state in races do
      @governor = Governor.new(date: year, state: state)
      if Governor.where(date: @governor.date, state: @governor.state).exists? or state=="type checkbox"
        # SKIP
      else

        if @governor.save
          #Yay, do nothing
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @governor.errors, status: :unprocessable_entity }
        end
      end
    end
    redirect_to action: "index"
  end

  # DELETE /governors/1 or /governors/1.json
  def destroy
    @governor.destroy!

    respond_to do |format|
      format.html { redirect_to governors_url, notice: "Governor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_governor
      @governor = Governor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def governor_params
      params.require(:governor).permit(:date, :state)
    end

    def delete_all_races(year)
      Governor.where(date: year).destroy_all
    end

end
