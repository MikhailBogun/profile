JWTSessions.algorithm = 'RS256'
JWTSessions.private_key = OpenSSL::PKey::RSA.generate(2048)
JWTSessions.public_key  = JWTSessions.private_key.public_key
JwtSessions.refresh_token_exp_time = 4.week.to_i

JWTSessions.token_store = :redis, {
  redis_host: '127.0.0.1',
  redis_port: '6379',
  redis_db_name: '0',
  token_prefix: 'jwt_'
}
