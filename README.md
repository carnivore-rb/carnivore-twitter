# Carnivore Twitter

Provides Twitter `Carnivore::Source`

# Usage

## Basic (follows user timeline)

```ruby
require 'carnivore'
require 'carnivore-twitter'

Carnivore.configure do
  source = Carnivore::Source.build(
    :type => :twitter, :args => {
      :consumer_key => '',
      :consumer_secret => '',
      :access_token => '',
      :access_token_secret => '',
      :polling_wait => 120
    }
  )
end
```

## User timeline (follows other user timeline)

```ruby
require 'carnivore'
require 'carnivore-twitter'

Carnivore.configure do
  source = Carnivore::Source.build(
    :type => :twitter, :args => {
      :consumer_key => '',
      :consumer_secret => '',
      :access_token => '',
      :access_token_secret => '',
      :polling_wait => 120,
      :user_timeline => 'otheruser'
    }
  )
end
```

## Streaming

```ruby
require 'carnivore'
require 'carnivore-twitter'

Carnivore.configure do
  source = Carnivore::Source.build(
    :type => :twitter, :args => {
      :consumer_key => '',
      :consumer_secret => '',
      :access_token => '',
      :access_token_secret => '',
      :streaming => true
    }
  )
end
```

# Info
* Carnivore: https://github.com/carnivore-rb/carnivore
* Repository: https://github.com/carnivore-rb/carnivore-twitter
* IRC: Freenode @ #carnivore
