# frozen_string_literal: true

class Follow < ApplicationRecord
    belongs_to :follower_user, class_name: "User"
    belongs_to :followed_user, class_name: "User"
end
