# Development Instructions
 
## Installation

1. Make sure you have Ruby 2.1.2 installed. You can check this by running `ruby -v` in your terminal. [rvm](https://rvm.io/) is a great tool for managing Ruby installations, [rbenv](https://github.com/sstephenson/rbenv) is another good alternative for managing your Rubies.
1. Fork the repo on GitHub
1. Clone it `$ git clone git@github.com:YOUR-GH-USERNAME/answers.git`
1. `$ cd answers`
1. Create a `.env` file (`$ cp .env.example .env`). 
  - There is a sample .env file in the root directory of the application called ".env.sample" (you can see it if you type ls -a).
  - Fill in the blanks with your own API keys. 
  - Minimum keys needed are:
    - `SECRET_TOKEN`: run `rake secret` to generate one.
1. Install postgres and qt dependency with Homebrew
  - Install homebrew: `$ ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)`
  - Install dependencies: `$ brew install postgresql qt`  
1. Check you have at least 1.2.x of bundler with bundle -v. To upgrade, first remove bundler with gem uninstall -ax bundler and then reinstall with gem install bundler -v 1.2.1
1. Install required gems: `$ bundle`
  - (`gem install bundler` if it's not already installed). You might have to open a new terminal tab after installing.)
1. Create a `database.yml` (`$ cp config/database.yml.example config/database.yml`)
1. `$ rake db:prepare`
1. `$ rake db:setup`
1. Provision a VM with ElasticSearch
  - `vagrant up`
1. Ensure that tests pass
  - `bundle exec rake`
1. `$ foreman run rails s` to start the server and visit http://localhost:3000/articles

## Development

This codebase adheres to the [git-flow](http://nvie.com/posts/a-successful-git-branching-model/) model of branching.

1. Develop using [git-flow](http://nvie.com/posts/a-successful-git-branching-model/).
2. Send a pull request when the feature is ready (typically, it shouldn't break any tests). Pull requests should be made against the `dev` branch.
3. Repeat.

### Gotchas

- [`capybara-webkit` error after running bundler](https://github.com/18F/answers_take1/issues/11)
- [pg error after running bundler](https://github.com/18F/answers_take1/issues/12)
- [Install GraphViz](https://github.com/18F/answers_take1/issues/13)
