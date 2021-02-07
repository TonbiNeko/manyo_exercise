class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  before_update :do_not_delete_last_admin
  before_destroy :do_not_delete_last_admin

private
# def ensure_admin
#   throw(:abort) unless self.admin
# end

# def last_admin?(user)
#   user.admin && User.all.map(&:admin).one?
# end

  def do_not_delete_last_admin
    if User.find_by(id: self.id).admin && User.all.map(&:admin).one?
      throw(:abort)
    else
      true
    end
  end
end