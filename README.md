[![security](https://hakiri.io/github/18F/answers/dev.svg)](https://hakiri.io/github/18F/answers/dev)
[![Build Status](https://travis-ci.org/18F/answers.svg?branch=dev)](https://travis-ci.org/18F/answers)
[![Coverage Status](https://coveralls.io/repos/18F/answers/badge.png?branch=dev)](https://coveralls.io/r/18F/answers?branch=dev)
[![Code Climate](https://codeclimate.com/github/18F/answers.png)](https://codeclimate.com/github/18F/answers)
[![Inline docs](http://inch-pages.github.io/github/18F/answers.png)](http://inch-pages.github.io/github/18F/answers)
[![Dependency Status](https://gemnasium.com/18F/answers.svg)](https://gemnasium.com/18F/answers)


The Answers Platform is a city-agnostic adaptation of [Honolulu Answers](http://answers.honolulu.gov): a new approach to make it easier for people to navigate city information and services quickly. It's a citizen-focused website that is question-driven, with clean, easy-to-navigate design. Unlike a portal destination, Honolulu Answers is like Google -- type in anything, and it probably gives you the answer you're looking for, using the words you know. Every page on the site is an answer to a potential Google search question by a citizen, written in simple, friendly language, as if you'd asked your neighbor a question. The content is organized based on citizen understanding, the intuitive way you'd think of a problem, not the way the city is organized internally.

Honolulu Answers is designed to be very user-friendly. It declutters the govt website experience, and it solves a problem people ordinarily have. And we hope it makes people's lives easier. Inspired by Gov.uk, Honolulu Answers is a first-of-its-kind for municipal government, a partnership between Code for America and the City & County of Honolulu.

A big thank you for the background photo courtesy of [Royal Realty](http://royalrealtyllc.com/)


## Installation

We use [Vagrant](http://www.vagrantup.com/) with [VirtualBox](https://www.virtualbox.org/) for the development and test environments. To install, clone the repo, change to the directory, and run `script/bootstrap.sh` (If you have windows, run `script/bootstrap.bat` instead from a Command Prompt as ADMINISTRATOR).  This will:

* create the required files based on `.example` files
* temporarily increase the memory of the VM to 4GB to increase the speed of compiling various dependencies
* run tests in VM
* open browser to [http://localhost:9080](http://localhost:9080) (osx only)

The initial provision may take up to 30 minutes (there's a lot things to download and compile), however subsequent runs should only take a few seconds. Alternatively, you can use a preinstalled image by unquoting this [line](https://github.com/18F/answers/blob/dev/Vagrantfile.example#L16) in your [Vagrantfile.example](https://github.com/18F/answers/blob/dev/Vagrantfile.example) before running `script/boostrap.sh`.


### Development

Most development can occur witout having to login to the VM.  The answers codebase on your local computer is shared with the VM so changes in one env will be instantly reflected in the other. Most development can be done using the text editor of your choice on your local computer.  If you need further access to the application environment (console, rake tasks, tests) you'll need to login to the VM via SSH or use the `vagrant sss -c "remote code to be excuted in VM"`.


### Working Within The VM

You can access the VM by ssh using either `vagrant ssh` or `ssh vagrant@localhost -p 2222`.  The answers repo is symlinked to the VM user's (vagrant) home folder and exists in /var/www/answers/current (capistrano deployment layout).


### Help with Vagrant VM

The VM is shutdown anytime the host comptuer is shut down.  When that occurs you must run `vagrant up` from the root directory of the answers repo in order to boot the VM and interact with the answers app.

Most errors within the VM can be fixed using chef.  Running `vagrant provision` will spawn a chef run that will restore the entire answers env.  [Please open an issue](https://github.com/18F/answers/issues/new) if you continue to experience an error.


## Local Install

Instructions to install answers locally are located here: [DEV-SETUP.md](DEV-SETUP.md). 


## Testing

Open a terminal and change directories to the answers repo. `vagrant -c 'cd answers && rake'` will run the test suite if you're using Vagrant.  If you've installed answers locally run `bundle exec rake` (note, you may need to create and migrate the test db).


## Contributing

In the spirit of [free software][free-sw], **everyone** is encouraged to help
improve this project. For more information, please view [CONTRIBUTING.md](https://github.com/18F/answers/blob/dev/CONTRIBUTING.md)

[free-sw]: http://www.fsf.org/licensing/essays/free-sw.html


## Roadmap

The milestones in the issues section has the most up-to-date info pertaining to our project roadmap.  Feel free to create issues if you feel a feature is left out or neglected.


## Supported Ruby Versions

This library aims to support and is [tested against][travis] the following Ruby
implementations:

 * Ruby 1.9.3
 * Ruby 2.1.2

If something doesn't work on one of these interpreters, it should be considered
a bug.


## License

Copyright (c) 2012, Code for America.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of Code for America nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.