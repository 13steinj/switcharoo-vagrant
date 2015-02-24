# Quick Setup for Switcharoo

Eventually this will be generalized for any [switcharoo](https://github.com/reddit/switcharoo) environment so you can quickly spin up a new Vagrant enviornment for it. As of now, it is specific to the reddit implementation of it.

## Requirements

- [Vagrant](https://www.vagrantup.com)
- [Virtualbox](https://www.virtualbox.org/) – We plan on supporting other VM providers later.
- [iojs](https://iojs.org/en/index.html) or [node](https://nodejs.org/)

## What's in the Vagrant Box

- Ubuntu 14.04 (Trusty Tahr)
- [nvm](https://github.com/creationix/nvm) which will install iojs or node depending on your config.
- Properly npm linked dependencies so you can develop plugins in tandem with the core experience.
- Some shortcuts inside the environment.

## Get me up and running

1. Clone this repo.
1. Copy `vagrant_config.example.yml` to `vagrant_config.yml`. Modify the settings to suit your needs. If you want just all defaults, it should be good to go as is. This will clone all the necessary repos and npm link them together. If have all the repos already, modify the synced folders and local plugins configs to point at the correct ones.
1. Run `vagrant up` from the root of the repo in your **host** system.
1. After it finishes, run `vagrant ssh` from the host environment to enter the *guest* system and run `reddit` from the **guest** system. This will start the server on port 4444 which is shared to your *host* system.
1. Open a browser and go to `localhost:4444`. Enjoy.

## What is where

If you run the default config, all your code with be in the `src/` directory in this project. This will make all your code live in `/vagrant/src/` on your **guest** machine.

If you have synced folders from your `vagrant_config.yml`, those will go to /host-raw/src/` directory.

## License

MIT