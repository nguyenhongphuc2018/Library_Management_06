class Role < ApplicationRecord
  has_many :users_roles
  has_many :users, through: :users_roles
  belongs_to :resource, polymorphic: true, optional: true

  validates :name, presence: true, inclusion: %w(guest admin banned)
  validates :resource_type, inclusion: { in: Rolify.resource_types },
                            allow_nil: true

  scopify
end
