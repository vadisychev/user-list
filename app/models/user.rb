class User < ApplicationRecord
    validates :name, :email, presence: true, allow_nil: false, allow_blank: false
    validates :name, length: { in: 2..20 }, format: { with: /\A[a-zA-Z]+\z/ }
    validates :email, length: { in: 5..30 }, format: { with: 
        /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}
end
