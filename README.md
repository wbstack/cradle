> ℹ️ Issues for this repository are tracked on [Phabricator](https://phabricator.wikimedia.org/project/board/5563/) - ([Click here to open a new one](https://phabricator.wikimedia.org/maniphest/task/edit/form/1/?tags=wikibase_cloud
))

# WBStack/Wikibase.cloud info
This repo is a fork of https://github.com/magnusmanske/cradle
The Dockerfile build process runs composer and pulls a version the wbstack fork of magnus-tools from https://github.com/wbstack/magnustools/

This is then copied out of `/vendor` by a `composer` post-update/install hook and then finally copied into the correct place in the final image.

To update this repository you need to pull the updates from the upstream and ensure our customisations are working on them. This may be easiest to do with a `git pull --rebase` from upstream. You may also need to update our magnustools fork for compatibility and then use that updated version.

If you go through this process please also update here to document it

# Changelog

# Cradle
Cradle is a tool to help create Wikibase (eg Wikidata) items that are based on a specific pattern (eg "ancient ceramicist"). These patterns can be defined on-wiki as wikitext or ShEX. The user is then presented with a form that allows a hard-limited. soft-limites, or free addition of statements.

# Setup

## Config file
- Create a `config.js` JavaScript (_not_ JSON!) file in `public_html`. Make sure the donfig object remains valid JSON (keys in double quotes etc).
- Copy the code from `config.js.template`, and modify it according to your installation.
- Create an `oauth.ini` file with the OAuth data from your tool, on your wiki, in the tool root directory (_not_ `public_html`!):
```
[settings]
agent = YOUR_TOOL_NAME
consumerKey = FOO
consumerSecret = BAR
```

## Composer
Install the required PHP via composer:
```
composer install
```
