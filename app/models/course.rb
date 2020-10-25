class Course < ApplicationRecord
  validates :title, :short_description, :language, :level, :price, presence: true
  validates :description, presence: true, length: { minimum: 5}

  belongs_to :user, counter_cache: true
  #User.find_each { |user| User.reset_counters(user.id, :courses) }
  has_many :lessons, dependent: :destroy
  has_many :enrollments

  validates :title, uniqueness: true

  def to_s
    title
  end

  LANGUAGES = ["English", "Polish", "Russian", "Spanish"]
  def self.languages
    LANGUAGES.map { |language| language  }
  end

  LEVELS = ["Beginner", "Intermediate", "Advanced"]
  def self.levels
    LEVELS.map { |level| level  }
  end

  has_rich_text :description

  extend FriendlyId
  friendly_id :title, use: :slugged

  # friendly_id :generated_slug, use: :slugged
  # def generated_slug
  #   require 'securerandom'
  #   @random_slug ||= persisted? ? friendly_id : SecureRandom.hex(4)
  # end
  #
  # def to_s
  #   slug
  # end
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  def bought(user)
    self.enrollments.where(user_id: [user.id], course_id: [self.id]).present?
  end

  def update_rating
    if enrollments.any? && enrollments.where.not(rating: nil).any?
      update_column :average_rating, (enrollments.average(:rating).round(2).to_f)
    else
      update_column :average_rating, (0)
    end
  end
end
