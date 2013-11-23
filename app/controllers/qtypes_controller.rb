class QtypesController < ApplicationController
  # GET /qtypes
  # GET /qtypes.json
  def index
    @qtypes = Qtype.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @qtypes }
    end
  end

  # GET /qtypes/1
  # GET /qtypes/1.json
  def show
    @qtype = Qtype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @qtype }
    end
  end

  # GET /qtypes/new
  # GET /qtypes/new.json
  def new
    @qtype = Qtype.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @qtype }
    end
  end

  # GET /qtypes/1/edit
  def edit
    @qtype = Qtype.find(params[:id])
  end

  # POST /qtypes
  # POST /qtypes.json
  def create
    @qtype = Qtype.new(params[:qtype])

    respond_to do |format|
      if @qtype.save
        format.html { redirect_to @qtype, notice: 'Qtype was successfully created.' }
        format.json { render json: @qtype, status: :created, location: @qtype }
      else
        format.html { render action: "new" }
        format.json { render json: @qtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /qtypes/1
  # PUT /qtypes/1.json
  def update
    @qtype = Qtype.find(params[:id])

    respond_to do |format|
      if @qtype.update_attributes(params[:qtype])
        format.html { redirect_to @qtype, notice: 'Qtype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @qtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qtypes/1
  # DELETE /qtypes/1.json
  def destroy
    @qtype = Qtype.find(params[:id])
    @qtype.destroy

    respond_to do |format|
      format.html { redirect_to qtypes_url }
      format.json { head :no_content }
    end
  end
end
