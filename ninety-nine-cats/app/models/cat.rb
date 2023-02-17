# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper
  attr_accessor :birth_date, :color, :name, :sex, :description
  
  CAT_COLORS = ['brown','white','orange','gray','black']

  validates :birth_date, :color, :name, :sex, prescence: true
  
  validates :sex, inclusion: { in: %w(M F) }
  validates :color, inclusion: {in: CAT_COLORS}
  validate :birth_date_cannot_be_future

  def birth_date_cannot_be_future
    if birth_date > Date.today
      errors.add(:birth_date, "Cant be in the future")
    end
  end

  def age 
    age = Today.now - birth_date 
    time_ago_in_words(age)
  end

  def initialize(birth_date, color, name, sex, description)
    @birth_date = birth_date
    @color = color
    @name = name
    @sex = sex
    @description = description
  end

end
