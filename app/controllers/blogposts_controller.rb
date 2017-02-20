class BlogpostsController < ApplicationController
  before_action :set_blogpost, only: [:show, :edit, :update, :destroy]

  def index
    @blogposts = Blogpost.all
  end


  def show
    set_meta_tags   title: @blogpost.title,
                    keywords: [@blogpost.title, "Pampered", "PamperedUp", "GetYourPamp"]
  end


  def new
    @blogpost = Blogpost.new
  end

  def edit
  end


  def create
    @blogpost = Blogpost.new(blogpost_params)
    @blogpost.user_id = current_user.id 



    respond_to do |format|
      if @blogpost.save
        format.html { redirect_to @blogpost, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @blogpost }
      else
        format.html { render :new }
        format.json { render json: @blogpost.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @blogpost.update(blogpost_params)
        format.html { redirect_to @blogpost, notice: 'Blogpost was successfully updated.' }
        format.json { render :show, status: :ok, location: @blogpost }
      else
        format.html { render :edit }
        format.json { render json: @blogpost.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blogpost.destroy
    respond_to do |format|
      format.html { redirect_to blogposts_url, notice: 'Blogpost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_blogpost
      @blogpost = Blogpost.find(params[:id])
    end

    def blogpost_params
      params.require(:blogpost).permit(:title, :body, :user_id)
    end
end
