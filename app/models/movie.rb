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



  attr_accessible :title, :year, :poster,  :language, :actor1, :actor2, :director, :synopsis, :vods_attributes, :remote_poster_url

  scope :language, lambda {|language| where(:language => language) }
  scope :actor1, lambda { |actor1| where(:actor1 => actor1) }
  scope :actor2, lambda { |actor2| where(:actor2 => actor2) }
  scope :year, lambda { |year| where("year >=  ?", year) }



  has_many :vods, dependent: :destroy
  has_many :platforms, :through => :vods

  mount_uploader :poster, PosterUploader

  validates :title, presence: true
  validates :year, presence: true, length: { is: 4 }
  validates :language, presence: true

  accepts_nested_attributes_for :vods, allow_destroy: true



  def is_active?
    vods.count > 0
  end

end
