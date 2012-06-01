# Motivation
 We have felt the pain of integrating static pages into a Rails application. There are plenty of gems available for this (Radiant, Locomotiv, etc.) but they are very heavy for what we need.

So, we built FeatherCMS. As the name suggests, its a Do-It-Yourself, lightweight CMS - just pages, caching and nothing more!

# Usage
Add the gem to your Gemfile

    gem 'feather_cms'

Now, generate the pages 

    # Use file system to store pages( default: public/system/templates)
    $ rails g feather_cms about_us jobs team
    
    OR
    
    #Use db to store pages
    $ rails g feather_cms about_us jobs team --storage=db
    or
    $ rails g feather_cms about_us jobs team -t=db

    $ rake db:migrate

This generates a route, the controller action and the view for each page. Start the server and use the URL http://localhost:3000/feathers/pages to go to the admin panel. 

This has basic HTTP authentication setup.The default username and password are feather/password and you can change this in feathers_controller.rb

      http_basic_authenticate_with name: 'feather', password: 'password', except: :published

Template types can be added in the feather_cms initializer 

    eg. c.template_types = ["html", "haml"]

# Features

* Creates a route for each static page.
* Caching the static pages.
* Creates the view in app/views/feathers folder
* Easily customization FeathersController
* CodeMirror Editor for syntax highlighting. (Default: HTML)
* Storage is file (default) or database.

# Caveats
You may need to ensure that the public/system folder exists (for file storage)

# TODO

* Move the basic authentication to the config/initializers/feather_cms.rb
* Override the default authentication strategy from the controller
* Move the code from generated controller to the gem (if required)
    
# Contribute
Fork away and send me pull requests!

# License 
The MIT license

