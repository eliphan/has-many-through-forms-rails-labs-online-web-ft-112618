class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def user_attributes=(user_attributes)
    user_attributes.values.each do |user_attribute|
    user = User.find_or_create_by(user_attribute)
    self.users << user 
    end
  end
  
  def user_username
    self.try(:user).try(:username)
  end
  
  def user_username=(username)
    user = User.find_or_create_by(username: username)
    self.user = user
  end

end
