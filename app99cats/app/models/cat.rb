# == Schema Information
#
# Table name: cats
#
#  id         :integer          not null, primary key
#  age        :integer
#  birth_date :date
#  color      :string(255)
#  name       :string(255)
#  sex        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Cat < ActiveRecord::Base
  validates :age, numericality: { only_integer: true }
  validates :name, :age, :color, :sex, :presence => true

  has_many :cat_rental_requests, dependent: :destroy
end
