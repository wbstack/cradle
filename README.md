> ℹ️ Issues for this repository are tracked on [Phabricator](https://phabricator.wikimedia.org/project/board/5563/) - ([Click here to open a new one](https://phabricator.wikimedia.org/maniphest/task/edit/form/1/?tags=wikibase_cloud
))

# Cradle

Cradle is a tool to help create Wikibase (eg Wikidata) items that are based on a specific pattern (eg "ancient ceramicist").
These patterns can be defined on-wiki as wikitext or ShEX.
The user is then presented with a form that allows a hard-limited, soft-limitesd, or free addition of statements.

## Changelog
- 2024-01-08: Synced with upstream https://github.com/magnusmanske/cradle/commit/cc3aef8a7e5572857314db54a4a19b15a96548fe

## Syncing this fork
- Switch/Create a branch for the merge
- Add local upstream remote: `git remote add upstream https://github.com/magnusmanske/cradle`
- Fetch upstream: `git fetch upstream`  
- Merge master(!) branch: `git merge upstream/master`
- Resolve conflictcs (if any)
- Update Changelog

## Setup

### Config file

- Create a `config.js` JavaScript (_not_ JSON!) file in `public_html`. Make sure the donfig object remains valid JSON (keys in double quotes etc).
- Copy the code from `config.js.template`, and modify it according to your installation.
- Create an `oauth.ini` file with the OAuth data from your tool, on your wiki, in the tool root directory (_not_ `public_html`!):

```ini
[settings]
agent = YOUR_TOOL_NAME
consumerKey = FOO
consumerSecret = BAR
```

### Composer

Install the required PHP via composer:

```sh
composer install
```
