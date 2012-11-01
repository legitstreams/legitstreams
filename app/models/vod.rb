# == Schema Information
#
# Table name: vods
#
#  id         :integer          not null, primary key
#  movie_url  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vod < ActiveRecord::Base

  attr_accessible :movie_url, :movie_id, :platform_id #, :platforms_attributes
  belongs_to :movie
  belongs_to :platform


  validates :movie_url, presence: true, uniqueness: true
  validates :movie_id, presence: true
  validates :platform_id, presence: true

  # accepts_nested_attributes_for :platforms, allow_destroy: true


end
