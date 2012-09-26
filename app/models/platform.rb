# == Schema Information
#
# Table name: platforms
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  base_url   :string(255)
#  logo       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Platform < ActiveRecord::Base

  attr_accessible :name, :base_url, :logo, :vods_attributes, :remote_logo_url

  has_many :vods, dependent: :destroy
  has_many :movies, :through => :vods

  mount_uploader :logo, LogoUploader

  validates :name, presence: true
  validates :base_url, presence: true


  accepts_nested_attributes_for :vods, allow_destroy: true

end
