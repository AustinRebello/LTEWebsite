class SenatesController < ApplicationController
  before_action :set_senate, only: %i[ show edit update destroy ]

  # GET /senates or /senates.json
  def index
    @senates = Senate.all
  end

  # GET /senates/1 or /senates/1.json
  def show
  end

  # GET /senates/new
  def new
    @senate = Senate.new
  end

  # GET /senates/1/edit
  def edit
  end

  # POST /senates or /senates.json
  def create
    @senate = Senate.new(senate_params)

    respond_to do |format|
      if @senate.save
        format.html { redirect_to senate_url(@senate), notice: "Senate was successfully created." }
        format.json { render :show, status: :created, location: @senate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @senate.errors, status: :unprocessable_entity }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_senate
      @senate = Senate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def senate_params
      params.require(:senate).permit(:date, :state, :senate_class)
    end
end
