'use strict';

const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const shexPage = fs.readFileSync(
	path.join(__dirname, '../public_html/vue_components/shex-page.html'),
	'utf8'
);
const regexDeclaration = shexPage.match(/const regex1 = ([^;]+);/);

assert.ok(regexDeclaration, 'ShEx shape regex declaration exists');

function getStartShapeBody( schemaText ) {
	const startMatch = schemaText.match( /\n *start\s*=\s*@<\s*(.+?)\s*>/ );
	if ( startMatch === null ) {
		return null;
	}

	const startShape = startMatch[1];
	const flattenedText = schemaText
		.replace( /(?<!\<)#.*(\n|$)/mg, '\n' )
		.replace( /\n/mg, ' ' );
	const regex = vm.runInNewContext( regexDeclaration[1] );
	let match;

	while ( ( match = regex.exec( flattenedText ) ) !== null ) {
		if ( match[1] === startShape ) {
			return match[2];
		}
	}

	return null;
}

const prefixAndStart = 'PREFIX wdt: <http://example.test/prop/direct/>\n'
	+ 'PREFIX wd: <http://example.test/entity/>\n'
	+ 'start = @<human>\n';

test( 'matches the start shape when whitespace precedes its opening brace', () => {
	const schema = prefixAndStart + '<human> {\n  wdt:P1 [wd:Q1]\n}';
	const body = getStartShapeBody( schema );

	assert.ok( body, 'the start shape should be detected' );
	assert.match( body, /wdt:P1/ );
} );

test( 'continues to match compact shape syntax', () => {
	const schema = prefixAndStart + '<human>{\n  wdt:P1 [wd:Q1]\n}';
	const body = getStartShapeBody( schema );

	assert.ok( body, 'the start shape should be detected' );
	assert.match( body, /wdt:P1/ );
} );

test( 'matches shapes with an EXTRA declaration', () => {
	const schema = prefixAndStart
		+ '<human> EXTRA wdt:P31 {\n  wdt:P1 [wd:Q1]\n}';
	const body = getStartShapeBody( schema );

	assert.ok( body, 'the start shape should be detected' );
	assert.match( body, /wdt:P1/ );
} );

test( 'allows whitespace around EXTRA and before the opening brace', () => {
	const schema = prefixAndStart
		+ '<human>   EXTRA   wdt:P31   {\n  wdt:P1 [wd:Q1]\n}';
	const body = getStartShapeBody( schema );

	assert.ok( body, 'the start shape should be detected' );
	assert.match( body, /wdt:P1/ );
} );
