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
    def do_not_delete_last_admin
      admins = User.all.map(&:admin) 
      a = []
      admins.each do |admin|
        if admin == true
        a << admin
        end
      if 1 > a.size
        throw(:abort)
      end
    end
  end
end
