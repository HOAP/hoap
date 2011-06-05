class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
    Authlogic::CryptoProviders::BCrypt.cost = 12
  end
end
