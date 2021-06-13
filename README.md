# AccountsSession

Authentication library for learnlife accounts.

## How authentication works?

- User fills in his login credentials to Accounts login form
- Accounts app will verify login credentials, create session in Redis and generate JWT token with session_id.
- User is redirected to one of the Learnlife apps and JWT token is passed as url parameter
- Destination application can read the JWT token and store it to users cookie.
- JWT token can be used by application to verify if user is authenticated, or to read user's profile information.


## Installation

Add this line to your application's Gemfile:

```ruby
gem "accounts_session", github: "learnlifecom/accounts_session"
```

And then execute:

    $ bundle install


## Configuration

```ruby
REDIS_INSTANCE = Redis.new(url: ENV.fetch("REDIS_URL"), id: ENV.fetch("APP_NAME"))

AccountsSession.configure do |config|
  config.jwt_token_secret = ENV.fetch("JWT_SECRET")
  config.redis_instance = REDIS_INSTANCE
  config.session_key_prefix = "accounts:session:"
end
```

## Usage

#### Check if token is authenticated
```ruby
session = AccountsSession.from_token(jwt_token)
session.authenticated?
```

#### Get session data
```ruby
session = AccountsSession.from_token(jwt_token)
session.session_id    # 1234
session.uuid          # cd7aaa85-ecc8-42a7-811b-266cf7d2ed96"
session.first_name    # John
session.last_name     # Doe
session.email         # john@doe.com
session.avatar_url    # http://image.com
```

#### Build JWT token
```ruby
session = AccountsSession.build(
  session_id: "1234",
  uuid: "cd7aaa85-ecc8-42a7-811b-266cf7d2ed96",
  first_name: "John",
  last_name: "Doe",
  email: "john@doe.com",
  avatar_url: "http://image.com"
)
session.to_jwt
```

## Development
#### Running tests
```
make test
```
