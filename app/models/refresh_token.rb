class RefreshToken < ApplicationRecord
  belongs_to :user

  def self.generate_for(user)
    create!(
      user: user,
      token: SecureRandom.hex(32),
      expires_at: 7.days.from_now
    )
  end

  def expired?
    expires_at < Time.current
  end
end
