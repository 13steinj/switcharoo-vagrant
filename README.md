# Quick Setup for Switcharoo

Eventually this will be generalized for any [switcharoo](https://github.com/reddit/switcharoo) environment so you can quickly spin up a new Vagrant enviornment for it. As of now, it is specific to the reddit implementation of it.

## Requirements

- [Vagrant](https://www.vagrantup.com/v)
- [Virtualbox](https://www.virtualbox.org/) – We plan on supporting other VM providers later.
- [iojs](https://iojs.org/en/index.html) or [node](https://nodejs.org/)

## What's in the Vagrant Box

- Ubuntu 14.04 (Trusty Tahr)
- iojs 1.2
- Properly npm linked dependencies so you can develop plugins in tandem with the core experience.
- Some shortcuts inside the environment.

## Get me up and running

1. Clone this repo.
1. `cd` into the repo and run `sh/setup.sh` in the *host* system. This will clone all the necessary repos, install the npm dependencies, and npm link them together. Note: at this point, you could stop and just run the project on your *host* system.
1. Run `vagrant up` from the root of the repo in your *host* system.
1. After it finishes, run `vagrant ssh` from the host environment to enter the *guest* system and run `reddit` from the *guest* system. This will start the server on port 4444 which is shared to your *host* system.
1. Open a browser and go to `localhost:4444`. Enjoy.

## What is where

Right now the `setup.sh` script will put all of your code into `switcharoo-vagrant/src` which git will ignore. We will make this flexible in the future.

## License

MIT