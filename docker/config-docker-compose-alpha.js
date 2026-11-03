'use strict';

const wikibaseBaseUrl = 'https://addshore-alpha.wiki.opencura.com';
const cradleBaseUrl = 'http://localhost:8087';

let config = {
    "source_page": 'Project:Cradle',
    "wikibase_url": `${wikibaseBaseUrl}/wiki/`,
    "api": `${wikibaseBaseUrl}/w/api.php`,
    "wikibase_api": `${wikibaseBaseUrl}/w/api.php`,
    "oauth_url": `${wikibaseBaseUrl}/w/index.php?title=Special:OAuth`,
    "cradle_url": `${cradleBaseUrl}/`,
    "cradle_api": `${cradleBaseUrl}/api.php`,
    "vue_components_base_url": `${cradleBaseUrl}/resources/vue/`
} ;
