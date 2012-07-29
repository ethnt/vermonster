# Vermonster

Vermonster is a way to consume the [Cheddar API](https://cheddarapp.com/developer).

**Want Python instead? Check out [vermonster-py](https://github.com/jpennell/vermonster-py).**

## Usage

```ruby
cheddar = Vermonster::Client.new(:id => "client-id", :secret => "client-secret")
```


### Authentication

```ruby
# Get the URL for the user to authorize the application (all parameters optional).
url = cheddar.authorize_url(:callback => "http://github.com", :state => "Foobar")

# Do whatever to send the user to that URL...
# It redirects back to whatever you set as the callback URL.

# In your controller (or wherever Cheddar sent the user back to),
# request the token with the code Cheddar sent back.
cheddar.token!(code)

# Or, if you're just using your own user with your own
# user token...
cheddar.use_token!("your-user-token")

# You're now authorized!
cheddar.authorized?
```


### Lists

```ruby
# Get all of your lists.
lists = cheddar.lists.all

# Get a list "Foobar" with the ID of 42.
foobar = cheddar.lists.find(42)

# Get the tasks in that list.
tasks = foobar.tasks

# Update that list.
foobar.update(:title => "Foosbar")

# Create a new list called "Foobaz".
foobaz = cheddar.lists.create(:title => "Foobaz")

# Reorder your lists.
cheddar.lists.reorder([42, 12, 35])
```


### Tasks

```ruby
# Get all the tasks in a list.
tasks = cheddar.lists.find(42).tasks

# Find a single task.
task = cheddar.tasks.find(4242)

# Update that task.
task.update(:text => "Foo to the bar.")

# Create a task in list 42.
awesome = cheddar.tasks.create(42, :text => "Be awesome!")

# Reorder task in list 42.
cheddar.tasks.reorder(42, [54, 23, 42])

# Archive completed items in list 42.
cheddar.tasks.archive(42)

# Archive all items in list 42.
cheddar.tasks.archive!(42)

# Move to another list.
awesome.move(32)
```


### User

```ruby
# Get information about the authorized user.
cheddar.me
```


## Contributing

Vermonster is under active development, and we would really appreciate you helping us out! Here's how.

1. Fork this repository.
2. Take a look [at the issues](https://github.com/eturk/vermonster/issues). What needs to be done?
3. Make a topic branch for what you want to do. Bonus points for referencing an issue (like `2-authentication`).
4. Make your changes.
5. Create a Pull Request.
6. Profit!
