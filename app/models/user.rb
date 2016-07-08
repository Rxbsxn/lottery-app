class User < ApplicationRecord
  resourcify

  rolify :before_add => :before_add_method

  def before_add_method(role)

  end

  has_and_belongs_to_many :auctions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         def admin?
           self.admin
         end

end
