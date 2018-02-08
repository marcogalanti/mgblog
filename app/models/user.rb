class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  attachment :profile_image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def admin?
    self.group == "admin"
  end
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
