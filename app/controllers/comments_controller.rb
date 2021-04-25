class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @course = Course.friendly.find(params[:course_id])
    @lesson = Lesson.friendly.find(params[:lesson_id])
    @comment.user_id = current_user.id
    @comment.lesson_id = @lesson.id
    if @comment.save
      redirect_to course_lesson_path(@course, @lesson), notice: "Comment was successfully added."
    else
      redirect_to course_lesson_path(@course, @lesson), alert: "Oops! Is content blank?"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
