class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  has_many :comments
  accepts_nested_attributes_for :categories

  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      category = Category.find_or_create_by(category_attribute)
      self.categories << category 
    end
  end
  
  def comment_contents=(comments)
    comments.each do |content|
      if content.strip != ''
        self.comments.build(content: content)
      end
    end
  end
  
  def comment_contents
    self.comments.map(&:content)
  end
  
  def user_username
    self.try(:user).try(:username)
  end
  
  def user_username=(username)
    user = User.find_or_create_by(username: username)
    self.user = user
  end

end
