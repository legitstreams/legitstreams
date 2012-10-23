# == Schema Information
#
# Table name: movies
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  year       :integer
#  language   :string(255)
#  image      :string(255)
#  actor1     :string(255)
#  actor2     :string(255)
#  director   :string(255)
#  synopsis   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Movie < ActiveRecord::Base
  extend FriendlyId
    friendly_id :title, use: [:slugged, :history]

  has_many :vods, dependent: :destroy
  has_many :platforms, :through => :vods
  has_many :actors , dependent: :destroy

  accepts_nested_attributes_for :vods, allow_destroy: true
  accepts_nested_attributes_for :actors, allow_destroy: true

  attr_accessible :title, :year, :poster,  :language, :actor1, :actor2, :director, :synopsis, :vods_attributes, :actors_attributes, :remote_poster_url

  scope :language, lambda {|language| where(:language => language) }
  scope :actor_1, lambda { |actor_1| joins("INNER JOIN actors as a1 ON movies.id = a1.movie_id").where( 'a1.name=?', actor_1) }
  scope :actor_2, lambda { |actor_2| joins("INNER JOIN actors as a2 ON movies.id = a2.movie_id").where( 'a2.name=?', actor_2) }
  scope :year, lambda { |year| where("year >=  ?", year) }

  mount_uploader :poster, PosterUploader
  strip_attributes :only => :remote_poster_url

  validates :title, presence: true
  validates :year, presence: true, length: { is: 4 }
  validates :language, presence: true



  def strip_whitespace
    :remote_poster_url.strip
  end


  def is_active?
    vods.count > 0
  end

end
