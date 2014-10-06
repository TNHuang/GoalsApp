class Goal < ActiveRecord::Base
  validates :title, presence: true
  validates :private, :completed, :inclusion => {:in => [true, false]}
  belongs_to :user, inverse_of: :goals


end
