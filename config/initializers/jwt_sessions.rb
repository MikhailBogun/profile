JWTSessions.algorithm = 'RS256'
JWTSessions.private_key = OpenSSL::PKey::RSA.generate(2048)
JWTSessions.public_key  = JWTSessions.private_key.public_key
JWTSessions.refresh_exp_time = 4.week.to_i
# JWTSessions.access_header = 'HTTP_AUTH_TOKEN'

JWTSessions.token_store = :redis, {
  redis_host: '127.0.0.1',
  redis_port: '6379',
  redis_db_name: '0',
  token_prefix: 'jwt_'
}

# if Rails.env.test?
#   JWTSessions.token_store = :memory
# elsif Rails.env.development?
#   JWTSessions.token_store = :redis, { redis_url: 'redis://127.0.0.1:6379/0' }
# end
