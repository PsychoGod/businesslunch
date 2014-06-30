class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :menu_set

  validates :user, :menu_set, presence: true
  validates :state, presence: true, inclusion: { in: %w[pending paid] }

  after_create :set_created_on

  delegate :name, to: :menu_set, prefix: true
  delegate :email, to: :user, prefix: true

  scope :today, -> {
    where(created_at: DateTime.current.beginning_of_day..DateTime.current.end_of_day)
  }

  aasm column: 'state' do
    state :pending, initial: true
    state :paid

    event :pay do
      transitions to: :paid
    end
  end

  private
  def set_created_on
    update_column :created_on, self.created_at.to_date
  end
end
