Rolify.configure do |config|
  # By default ORM adapter is ActiveRecord. uncomment to use mongoid
  # config.use_mongoid

# user = User.find(1)
#
# user.add_role :admin
# user.has_role? :admin => true
#
# user = User.find(2)
# user.add_role :moderator, Auction.first
# user.has_role? :moderrator, Auction.first => true
# user.has_role? :moderator, Auction.last => false
# user = User.find(3)
# user.add_role :moderator, Auction
#
# user = User.find(3)
# user.add_role :moderator, Auction # sets a role scoped to a resource class
# user.has_role? :moderator, Auction
# => true
# user.has_role? :moderator, Auction.first
# => true
# user.has_role? :moderator, Auction.last
# => true
#
# user = User.find(4)
# user.add_role :moderator # sets a global role
# user.has_role? :moderator, Auction.first
# => true
# user.has_role? :moderator, Auction.last
# => true
#


  # Dynamic shortcuts for User class (user.admin? like methods). Default is: false
  # config.use_dynamic_shortcuts
end
