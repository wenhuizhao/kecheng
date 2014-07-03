class SectionsController < ApplicationController
  layout  "blank"
  # GET /sections
  # GET /sections.json
  def index
    if params[:book_id].blank?  && params[:id].blank?
      @sections = Section.all
    else
      book_id = params[:id] ? params[:id] : params[:book_id]
      @sections = Section.find_all_by_book_id(book_id)
      @book = Book.find(book_id)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sections }
    end
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
    @section = Section.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @section }
    end
  end

  # GET /sections/new
  # GET /sections/new.json
  def new
    @section = Section.new
    @book = Book.find(params[:book_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @section }
    end
  end

  # GET /sections/1/edit
  def edit
    @section = Section.find(params[:id])
  end

  # POST /sections
  # POST /sections.json
  def create
    @section = Section.new(params[:section])
    @section.book_id = params[:book_id]
    respond_to do |format|
      if @section.save
        format.html { redirect_to @section, notice: 'Section was successfully created.' }
        format.json { render json: @section, status: :created, location: @section }
      else
        format.html { render action: "new" }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sections/1
  # PUT /sections/1.json
  def update
    @section = Section.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        format.html { redirect_to @section, notice: 'Section was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    @section = Section.find(params[:id])
    book = @section.book
    @section.destroy
    respond_to do |format|
      format.html { redirect_to book_sections_url(book) }
      format.json { head :no_content }
    end
  end

  def edit_lesson_category
    @section = Section.find(params[:section_id])
  end
  def update_lesson_category
    @section = Section.find(params[:section_id])
    ActiveRecord::Base.transaction do
      1.upto(@section.num_lessons) do |n|
        @section.lesson_categories(n).each { |c| SectionLessonCategory.where(section_id: @section.id, lesson: n, category_id: c.id).last.destroy}
      end
      Category.all.each do |c|
        lesson_num = params["cat_#{c.id}"].to_i
        section_lesson_category = SectionLessonCategory.new(section_id: @section.id, lesson: lesson_num, category_id: c.id)
        section_lesson_category.save
      end
    end
    render action: :edit_lesson_category
  end
end
