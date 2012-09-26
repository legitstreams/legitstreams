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

require 'spec_helper'

describe Movie do
  pending "add some examples to (or delete) #{__FILE__}"
end
