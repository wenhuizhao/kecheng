class ExerciseTextsController < ApplicationController
  # GET /exercise_texts
  # GET /exercise_texts.json
  def index
    @exercise_texts = ExerciseText.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @exercise_texts }
    end
  end

  # GET /exercise_texts/1
  # GET /exercise_texts/1.json
  def show
    @exercise_text = ExerciseText.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @exercise_text }
    end
  end

  # GET /exercise_texts/new
  # GET /exercise_texts/new.json
  def new
    @exercise_text = ExerciseText.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @exercise_text }
    end
  end

  # GET /exercise_texts/1/edit
  def edit
    @exercise_text = ExerciseText.find(params[:id])
  end

  # POST /exercise_texts
  # POST /exercise_texts.json
  def create
    @exercise_text = ExerciseText.new(params[:exercise_text])

    respond_to do |format|
      if @exercise_text.save
        format.html { redirect_to @exercise_text, notice: 'Exercise text was successfully created.' }
        format.json { render json: @exercise_text, status: :created, location: @exercise_text }
      else
        format.html { render action: "new" }
        format.json { render json: @exercise_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /exercise_texts/1
  # PUT /exercise_texts/1.json
  def update
    @exercise_text = ExerciseText.find(params[:id])

    respond_to do |format|
      if @exercise_text.update_attributes(params[:exercise_text])
        format.html { redirect_to @exercise_text, notice: 'Exercise text was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @exercise_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercise_texts/1
  # DELETE /exercise_texts/1.json
  def destroy
    @exercise_text = ExerciseText.find(params[:id])
    @exercise_text.destroy

    respond_to do |format|
      format.html { redirect_to exercise_texts_url }
      format.json { head :no_content }
    end
  end
end
