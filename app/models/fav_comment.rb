# frozen_string_literal: true

class FavComment < ApplicationRecord
  belongs_to :user
  belongs_to :comment
end
