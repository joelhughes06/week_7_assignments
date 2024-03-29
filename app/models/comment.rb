class Comment < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post
  has_many :post_categories
  has_many :posts, through: :post_categories
  has_many :votes, as: :voteable

  validates :body, presence: true

  def up_votes
  	self.votes.where(vote: true).size
  end

  def down_votes
  	self.votes.where(vote: false).size
  end

  def total_votes
  	self.up_votes - self.down_votes
  end
  
end

