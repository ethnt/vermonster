# Vermonster

Vermonster is a way to consume the [Cheddar API](https://cheddarapp.com/developer).

# Objective

_Obviously this isn't implemented yet. But eventually..._

    cheddar = Vermonster::Client.new(:id => "oauth-id", :secret => "oauth-secret")


### Authentication

    # Get the URL for the user to authorize the application.
    url = cheddar.authorize!

    # Do whatever to send the user to that URL...
    # It redirects back to whatever you sent as callback URL.

    # In your controller (or wherever the callback URL is)...
    cheddar.token!(code)

    # You are now authorized!
    cheddar.authorized?


### Lists

    # Get all of your lists.
    lists = cheddar.lists.all

    # Get a list called "Foobar" with an ID of 42.
    foobar = cheddar.lists.find(:id => "42")

    # Get the tasks in that list.
    tasks = foobar.tasks
    tasks = cheddar.lists.find(:id => "42").tasks

    # Update that list.
    foobar.update(:title => "Barfoo")

    # Destroy that list!
    foobar.destroy!

    # Make a new list called "Barfoo".
    barfoo = cheddar.lists.new(:title => "Barfoo")

    # Reorder your lists.
    barfoo.reorder([42, 12, 23])


### Tasks

    # Get one task.
    task = cheddar.task.find(:id => "42")

    # Update that task.
    task.update(:text => "Boom!")

    # Create a task in a list.
    foobar.tasks.new(:text => "Be awesome!")

    # Reorder...
    foobar.tasks.reorder([42, 12])

    # Archive completed items
    foobar.tasks.archive
    foobar.tasks.archive.completed

    # Archive all items!
    foobar.tasks.archive!
    foobar.tasks.archive.all


### User

    # Get info about yourself.
    moi = cheddar.me

    moi.lists
    moi.tasks
    