class Game < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :my_score,:opponent_score,:opponent
  validates_numericality_of :my_score,:opponent_score
  validates :my_score,  numericality: { less_than: 22, greater_than_or_equal_to: 0 ,:message => "Please enter number between 0 and 21"}
  validates :opponent_score,  numericality: { less_than: 22, greater_than_or_equal_to: 0 ,:message => "Please enter number between 0 and 21"}
end

