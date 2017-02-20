class BlogcommentsController < ApplicationController


  def create
    @blogpost = Blogpost.find(params[:blogpost_id])   
    @blogcomment = @blogpost.blogcomments.create(blogcomment_params)

    redirect_to blogpost_path(@blogpost)

  end

  def destroy
    @blogpost = Blogpost.find(params[:blogpost_id])
    @blogcomment = @blogpost.blogcomments.find(params[:id])
    @blogcomment.destroy

    redirect_to blogpost_path(@blogpost)
  end

  private

    def blogcomment_params
      params.require(:blogcomment).permit(:user_id, :body)
    end

end
