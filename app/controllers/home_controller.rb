class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    @courses = Course.all.limit(3)
    @latest = Course.published.latest
    @top_rated = Course.published.top_rated
    @popular = Course.published.popular
    @purchased_courses = Course.published.joins(:enrollments).where(enrollments: {user: current_user}).order(created_at: :desc).limit(3)
    @latest_good_reviews = Enrollment.reviewed.latest_good_reviews
  end

  def activity
    if current_user.has_role?(:admin)
      @activities = PublicActivity::Activity.all
    else
      redirect_to root_path, alert: 'You are not authorized to access this page!'
    end
  end

  def analytics
    if current_user.has_role?(:admin)
      # @users = User.all # We hide it out as we are using json to render charts
      # @enrollments = Enrollment.all # We hide it out as we are using json to render charts
      # @courses = Course.all
    else
      redirect_to root_path, alert: 'You are not authorized to access this page!'
    end
  end
end
