class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :status, presence: true
  scope :search_with_name, -> (name) { where('name LIKE ?', "%#{name}%") }
  scope :search_with_status, -> (status) { where(status: status) }
  scope :order_expiration_date_desc, -> { order(expiration_date: :desc)}
  scope :order_create_at_desc, -> { order(created_at: :desc) }
end