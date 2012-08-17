= FeatherCms

# Motivation
 We have felt the pain of integrating static pages into a Rails application. There are plenty of gems available for this (Radiant, Locomotiv, etc.) but they are very heavy for what we need.

So, we built FeatherCMS. As the name suggests, its a Do-It-Yourself, lightweight CMS - just pages, caching and nothing more!

# Usage
Add the gem to your Gemfile

    gem 'feather_cms'

Now, generate the pages 

    $ rails g feather_cms 
    $ rake db:migrate

This generates a route, the controller action and the view for each page. Start the server and use the URL http://localhost:3000/feathers/pages to go to the admin panel. 

This has basic HTTP authentication setup.The default username and password are feather/password and you can change this in feathers_controller.rb. 

To change basic authentication: config/initializers/feather_cms.rb

    c.authentication = {name: 'feather', password: 'password'}

If you want to add devise authentication set

    c.authentication = :authenticate_user! 
    or
    c.authentication = :authenticate_admin!


# Contribute
Fork away and send me pull requests!

# License 
The MIT license

