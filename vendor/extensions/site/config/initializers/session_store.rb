# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tienda_session',
  :secret      => 'f6f7bde544136d1e37985d7d5f4e0806b74a35df94038814a5b5ddd130c14f32947706335ba87def390d40848872a06c0b7a4396236e4abeb2e36f92ac4fadcd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store