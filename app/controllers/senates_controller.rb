class SenatesController < ApplicationController
  before_action :set_senate, only: %i[ show edit update destroy ]
  before_action :admin?, only: [:new, :create, :edit, :update, :destroy]

  # GET /senates or /senates.json
  def index
    @senates = Senate.all
    @list = generate_nested_lists()
  end

  # GET /senates/1 or /senates/1.json
  def show
  end

  # GET /senates/new
  def new
    @senate = Senate.new

    @states = return_states()
  end

  # GET /senates/1/edit
  def edit
  end

  # POST /senates or /senates.json
  def create
    @senate = Senate.new(senate_params)

    if Senate.where(date: @senate.date, state: @senate.state).exists?
      respond_to do |format|
        @senate.errors.add(:date, 'This race already exists!')
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @senate.errors, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        if @senate.save
          format.html { redirect_to senate_url(@senate), notice: "Senatorial Race was successfully created." }
          format.json { render :show, status: :created, location: @senate }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @senate.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /senates/1 or /senates/1.json
  def update
    respond_to do |format|
      if @senate.update(senate_params)
        format.html { redirect_to senate_url(@senate), notice: "Senate was successfully updated." }
        format.json { render :show, status: :ok, location: @senate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @senate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /senates/1 or /senates/1.json
  def destroy
    @senate.destroy!

    respond_to do |format|
      format.html { redirect_to senates_url, notice: "Senate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_bulk_races
    year = params[:senate][:date]
    delete_all_races(params[:senate][:date])

    races = params[:senate][:state]

    for state in races do
      @senate = Senate.new(date: year, state: state)
      if Senate.where(date: @senate.date, state: @senate.state).exists? or state=="type checkbox"
        # SKIP
      else

        if @senate.save
          #Yay, do nothing
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @senate.errors, status: :unprocessable_entity }
        end
      end
    end
    redirect_to action: "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_senate
      @senate = Senate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def senate_params
      params.require(:senate).permit(:date, :state, :senate_class)
    end

    def delete_all_races(year)
      Senate.where(date: year).destroy_all
    end

end
