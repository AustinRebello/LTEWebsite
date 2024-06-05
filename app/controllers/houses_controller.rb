class HousesController < ApplicationController
  before_action :set_house, only: %i[ show edit update destroy ]
  before_action :admin?, only: [:new, :create, :edit, :update, :destroy]

  # GET /houses or /houses.json
  def index
    @houses = House.all
    @presidents = President.all
    @list = generate_nested_lists()
  end

  # GET /houses/1 or /houses/1.json
  def show

    @url = "https://api.ltelections.com/races/house%20" + @house.state + "-" + @house.seat

  end

  # GET /houses/new
  def new
    @house = House.new
  end

  # GET /houses/1/edit
  def edit
  end

  def state_races
    @list = generate_nested_lists()
    @state_number = params[:state_number].to_i
    puts(@list[0][@state_number])
    @houses = House.where(state: @list[0][@state_number])
  end

  # POST /houses or /houses.json
  def create
    @house = House.new(house_params)

    @newHouse = House.where(date: @house.date, state: @house.state, seat: @house.seat).exists?
    puts @newHouse

    if House.where(date: @house.date, state: @house.state, seat: @house.seat).exists?
      respond_to do |format|
        @house.errors.add(:date, 'This race already exists!')
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        if @house.save
          format.html { redirect_to house_url(@house), notice: "House was successfully created." }
          format.json { render :show, status: :created, location: @house }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @house.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /houses/1 or /houses/1.json
  def update
    respond_to do |format|
      if @house.update(house_params)
        format.html { redirect_to house_url(@house), notice: "House was successfully updated." }
        format.json { render :show, status: :ok, location: @house }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /houses/1 or /houses/1.json
  def destroy
    @house.destroy!

    respond_to do |format|
      format.html { redirect_to houses_url, notice: "House was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_all_races
    year = params[:house][:date]
    delete_all_races(params[:house][:date])

    races = return_house_seats()

    for state in races do
      for district in 1..state[1] do
        @house = House.new(date: year, state: state[0], seat: district)
        if @house.save
          #Yay, do nothing
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @house.errors, status: :unprocessable_entity }
        end
      end
    end
    redirect_to action: "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house
      @house = House.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def house_params
      params.require(:house).permit(:date, :state, :seat)
    end

    def delete_all_races(year)
      House.where(date: year).destroy_all
    end

    def house_race_exists(date, state, seat)
      
    end
end
