# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_reHour_session',
  :secret      => '98378db55648f6ea15ca22c74786a4c4607b1bc98a38017d81ac41d7725496eb0f608e84b59b02425768f64a43d05a4c667febcf2f01b9201557e532c8b96d02'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
