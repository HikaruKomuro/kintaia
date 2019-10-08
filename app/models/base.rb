class Base < ApplicationRecord
    
  validates :base_number, uniqueness: true, presence: true, length: { maximum: 4 }
  validates :base_name, uniqueness: true, presence: true, length: { maximum: 20 }
  validates :work_type, presence: true, length: { maximum: 10 }

end
