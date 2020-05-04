class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, -> { order('updated_at DESC')}, dependent: :destroy

    validates :title, presence: true, uniqueness: true
    validates :body, presence: true, length: { minimum: 50}
end
