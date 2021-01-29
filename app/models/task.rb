class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :status, presence: true
  enum status: { "未着手": 0, "着手中": 1, "完了": 2}
  scope :search_with_name, -> (name) { where('name LIKE ?', "%#{name}%") }
  scope :search_with_status, -> (status) { where(status: status) }
  scope :order_expiration_date_desc, -> { order(expiration_date: :desc)}
  scope :order_create_at_desc, -> { order(created_at: :desc) }

  scope :order_expiration_date_asc, -> { order(expiration_date: :asc)}
  scope :one, -> { where(status: 0).order_expiration_date_asc }
  scope :two, -> { where(status: 1).order_expiration_date_asc }
  scope :three, -> { where(status: 2).order_expiration_date_asc }

end