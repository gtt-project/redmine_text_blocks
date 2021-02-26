# Redmine Text Blocks Plugin

![CI #develop](https://github.com/gtt-project/redmine_text_blocks/workflows/Test%20with%20Redmine/badge.svg)

This plugin adds configurable text blocks for replying to issues.

## Requirements

- Redmine >= 4.0.0

## Installation

To install Redmine text blocks plugin, download or clone this repository in your Redmine installation plugins directory!
```
cd path/to/plugin/directory
git clone https://github.com/gtt-project/redmine_text_blocks.git
```

Then run

```
bundle install
bundle exec rake redmine:plugins:migrate
```

After restarting Redmine, you should be able to see the Redmine Text Blocks plugin in the Plugins page.

More information on installing (and uninstalling) Redmine plugins can be found here: http://www.redmine.org/wiki/redmine/Plugins

## How to use

[Settings, screenshots, etc.]

## Contributing and Support

The Text Blocks Project appreciates any [contributions](https://github.com/gtt-project/.github/blob/main/CONTRIBUTING.md)! Feel free to contact us for [reporting problems and support](https://github.com/gtt-project/.github/blob/main/CONTRIBUTING.md).

## Version History

- 1.0.2 Fixes localization
- 1.0.1 Bugfix

See [all releases](https://github.com/gtt-project/redmine_text_blocks/releases) with release notes.

## Authors

  - [Jens Kraemer](https://github.com/jkraemer)
  - [Daniel Kastl](https://github.com/dkastl)
  - [Thibault Mutabazi](https://github.com/eyewritecode)
  - [Ko Nagase](https://github.com/sanak)
  - ... [and others](https://github.com/gtt-project/redmine_text_blocks/graphs/contributors)

## LICENSE

This program is free software. See [LICENSE](LICENSE) for more information.
