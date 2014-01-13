# -*- encoding : utf-8 -*-
class ExercisesController < ApplicationController
  layout  "blank"
  # GET /exercises
  # GET /exercises.json
  def index
    if !params[:id].blank?
      @exercises = Exercise.find_all_by_book_id(params[:id])
      @book = Book.find(params[:id])
    elsif !params[:book_id].blank?
      @exercises = Exercise.find_all_by_book_id(params[:book_id])
      @book = Book.find(params[:book_id])
    elsif !params[:section_id].blank?
      @exercises = Exercise.find_all_by_section_id(params[:section_id])
      @section = Section.find(params[:section_id])
    else
      @exercises = Exercise.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @exercises }
    end
  end

  # GET /exercises/1
  # GET /exercises/1.json
  def show
    @exercise = Exercise.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @exercise }
    end
  end

  # GET /exercises/new
  # GET /exercises/new.json
  def new
    @exercise = Exercise.new
    @section = Section.find(params[:section_id])
    @upload_file = UploadFile.new
    @book = @section.book
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @exercise }
    end
  end

  # GET /exercises/1/edit
  def edit
    @exercise = Exercise.find(params[:id])
    @upload_file = UploadFile.new
  end

  # POST /exercises
  # POST /exercises.json
  def create
    @exercise = Exercise.new(params[:exercise])

    respond_to do |format|
      if @exercise.save
        format.html { redirect_to @exercise, notice: 'Exercise was successfully created.' }
        format.json { render json: @exercise, status: :created, location: @exercise }
      else
        format.html { render action: "new" }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /exercises/1
  # PUT /exercises/1.json
  def update
    @exercise = Exercise.find(params[:id])

    respond_to do |format|
      if @exercise.update_attributes(params[:exercise])
        format.html { redirect_to @exercise, notice: 'Exercise was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercises/1
  # DELETE /exercises/1.json
  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy

    respond_to do |format|
      format.html { redirect_to exercises_url }
      format.json { head :no_content }
    end
  end

  def update_text
    @exercise = Exercise.find(params[:exercise_id]) unless params[:exercise_id].blank?
    @exercise_text = ExerciseText.find(params[:exercise_text_id]) unless params[:exercise_text_id].blank?
    if !params[:section_id].blank?
      @section = Section.find(params[:section_id])
      @book = @section.book
    else
      @book = Book.find(params[:book_id])
    end
    @exercise_texts = ["", nil] + @book.exercise_texts.map{|t| [t.title.truncate(20), t.id]}
    @sections = @book.sections.map{|t| [t.num_name, t.id]}
    respond_to do |format|
      format.js
    end
  end

  def answer
    @exercise = Exercise.find(params[:id])

    respond_to do |format|
      format.html # answer.html.erb
      format.json { render json: @exercise }
    end
  end

  def save_canvas
    @exercise = Exercise.find(params[:id])
    # @exercise.save_png(JSON.parse(params[:data])["objects"][0]["src"].gsub('data:image/png;base64,',''))
    @exercise.extra = params[:data]
    @exercise.save
  end
  
  def load_canvas
    @exercise = Exercise.find(params[:id])
    render :text => @exercise.extra
  end
end
