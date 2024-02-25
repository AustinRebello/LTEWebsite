class MiscsController < ApplicationController
  before_action :set_misc, only: %i[ show edit update destroy ]

  # GET /miscs or /miscs.json
  def index
    @miscs = Misc.all
  end

  # GET /miscs/1 or /miscs/1.json
  def show
  end

  # GET /miscs/new
  def new
    @misc = Misc.new
  end

  # GET /miscs/1/edit
  def edit
  end

  # POST /miscs or /miscs.json
  def create
    @misc = Misc.new(misc_params)

    respond_to do |format|
      if @misc.save
        format.html { redirect_to misc_url(@misc), notice: "Misc was successfully created." }
        format.json { render :show, status: :created, location: @misc }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @misc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /miscs/1 or /miscs/1.json
  def update
    respond_to do |format|
      if @misc.update(misc_params)
        format.html { redirect_to misc_url(@misc), notice: "Misc was successfully updated." }
        format.json { render :show, status: :ok, location: @misc }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @misc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /miscs/1 or /miscs/1.json
  def destroy
    @misc.destroy!

    respond_to do |format|
      format.html { redirect_to miscs_url, notice: "Misc was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_misc
      @misc = Misc.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def misc_params
      params.require(:misc).permit(:date, :state, :seat, :race_type)
    end
end
