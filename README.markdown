# Vermonster

Vermonster is a way to consume the [Cheddar API](https://cheddarapp.com/developer).

**Want Python instead? Check out [vermonster-py](https://github.com/jpennell/vermonster-py).**

## Objective

_Obviously this isn't implemented yet. But eventually..._

``` ruby
cheddar = Vermonster::Client.new(:id => "oauth-id", :secret => "oauth-secret")
```


### Authentication

``` ruby
# Get the URL for the user to authorize the application.
url = cheddar.authorize_url

# Do whatever to send the user to that URL...
# It redirects back to whatever you sent as callback URL.

# In your controller (or wherever the callback URL is)...
cheddar.token!(code)

# You are now authorized!
cheddar.authorized?
```


### Lists

``` ruby
# Get all of your lists.
lists = cheddar.lists.all

# Get a list called "Foobar" with an ID of 42.
foobar = cheddar.lists.find(:id => "42")

# Get the tasks in that list.
tasks = foobar.tasks
tasks = cheddar.lists.find(:id => "42").tasks

# Update that list.
foobar.update(:title => "Barfoo")

# Make a new list called "Barfoo".
barfoo = cheddar.lists.create(:title => "Barfoo")

# Reorder your lists.
cheddar.lists.reorder([42, 12, 23])
```


### Tasks

``` ruby
# Get one task.
task = cheddar.task.find(:id => "42")

# Update that task.
task.update(:text => "Boom!")

# Create a task in a list.
foobar.tasks.create(:text => "Be awesome!")

# Reorder...
foobar.tasks.reorder([42, 12])

# Archive completed items
foobar.tasks.archive
foobar.tasks.archive.completed

# Archive all items!
foobar.tasks.archive!
foobar.tasks.archive.all
```


### User

``` ruby
# Get info about yourself.
moi = cheddar.me

moi.lists
moi.tasks
```

## Contributing

Vermonster is under active development, and we would really appreciate you helping us out! Here's how.

1. Fork this repository.
2. Take a look [at the issues](https://github.com/eturk/vermonster/issues). What needs to be done?
3. Make a topic branch for what you want to do. Bonus points for referencing an issue (like `2-authentication`).
4. Make your changes.
5. Create a Pull Request.
6. Profit!
