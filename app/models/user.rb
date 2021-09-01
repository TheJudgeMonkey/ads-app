# frozen_string_literal: true

class User < ApplicationRecord
  extend Enumerize

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :advertisements, dependent: :destroy

  enumerize :role, in: %i[user admin], predicates: true
end
