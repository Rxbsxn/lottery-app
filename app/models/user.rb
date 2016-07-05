class User < ApplicationRecord
  resourcify
  rolify :before_add => :before_add_method
  def before_add_method(role)

  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
