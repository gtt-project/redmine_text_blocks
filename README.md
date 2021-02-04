# Redmine Text Blocks Plugin

This plugin adds configurable text blocks for replying to issues.

## Project health

![CI #develop](https://github.com/gtt-project/redmine_text_blocks/workflows/Test%20with%20Redmine/badge.svg)

## Requirements

- Redmine >= 3.4.0

## Installation

To install Redmine text blocks plugin, download or clone this repository in your Redmine installation plugins directory!

`git clone https://hub.georepublic.net/gtt/redmine_text_blocks.git`

Then run

`bundle install`

followed by

`bundle exec rake redmine:plugins:migrate`


After restarting Redmine, you should be able to see the Redmine Resource Manager in the Plugins page.

More information on installing Redmine plugins can be found here: http://www.redmine.org/wiki/redmine/Plugins


## Version History

  - 1.0.2 Fixes localization
  - 1.0.1 Bugfix


## Authors

  - [Jens Kraemer](https://github.com/jkraemer)

  - [Daniel Kastl](https://github.com/dkastl)


## LICENSE

This program is free software. See [LICENSE](LICENSE) for more information.
