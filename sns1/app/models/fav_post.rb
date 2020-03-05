# frozen_string_literal: true

class FavPost < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
