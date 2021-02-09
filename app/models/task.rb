class Task < ApplicationRecord
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true
  validates :status, presence: true
  enum status: { "未着手": 0, "着手中": 1, "完了": 2}
  enum priority: { "高": 0, "中": 1, "低": 2}
  scope :search_with_name, -> (name) { where('name LIKE ?', "%#{name}%") }
  scope :search_with_status, -> (status) { where(status: status) }
  scope :search_with_priority, -> (priority) { where(priority: priority) }
  scope :sort_priority, -> { order(priority: :asc) }
  scope :order_expiration_date_desc, -> { order(expiration_date: :desc)}
  scope :order_create_at_desc, -> { order(created_at: :desc) }
  scope :order_expiration_date_asc, -> { order(expiration_date: :asc)}
  scope :sort_date_and_status, -> { order(status: :asc).order_expiration_date_asc }
end