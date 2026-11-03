<?PHP

#error_reporting(E_ERROR|E_CORE_ERROR|E_COMPILE_ERROR|E_ALL);
#ini_set('display_errors', 'On');

require __DIR__ . '/../vendor/autoload.php';

function get_config() {
	// $js = file_get_contents('config.js');
	// $js = str_replace ( "\n" , ' ' , $js ) ;
	// $js = preg_replace ( '|^.*let +config\s*=\s*|' , '' , $js ) ;
	// $js = preg_replace ( '|\s*;\s*$|' , '' , $js ) ;
	// $j = json_decode($js) ;

	$s = $_SERVER['SERVER_NAME'];
	$j = [
		'source_page' => 'Project:Cradle',
		'wikibase_url' => "https://${s}/wiki/",
		'api' => "https://${s}/w/api.php",
		'wikibase_api' => "https://${s}/w/api.php",
		'oauth_url' => "https://${s}/w/index.php?title=Special:OAuth",
		'cradle_url' => "https://${s}/tools/cradle/",
		'cradle_api' => "https://${s}/tools/cradle/api.php",
		'vue_components_base_url' => "https://${s}/tools/cradle/resources/vue/",
	];
	$wikibaseBaseUrl = getenv('CRADLE_WIKIBASE_BASE_URL');
	if ( $wikibaseBaseUrl !== false && $wikibaseBaseUrl !== '' ) {
		$wikibaseBaseUrl = rtrim( $wikibaseBaseUrl, '/' );
		$j['wikibase_url'] = "${wikibaseBaseUrl}/wiki/";
		$j['api'] = "${wikibaseBaseUrl}/w/api.php";
		$j['wikibase_api'] = "${wikibaseBaseUrl}/w/api.php";
		$j['oauth_url'] = "${wikibaseBaseUrl}/w/index.php?title=Special:OAuth";
	}
	$cradleBaseUrl = getenv('CRADLE_BASE_URL');
	if ( $cradleBaseUrl !== false && $cradleBaseUrl !== '' ) {
		$cradleBaseUrl = rtrim( $cradleBaseUrl, '/' );
		$j['cradle_url'] = "${cradleBaseUrl}/";
		$j['cradle_api'] = "${cradleBaseUrl}/api.php";
		$j['vue_components_base_url'] = "${cradleBaseUrl}/resources/vue/";
	}
	$j = json_decode( json_encode( $j ) );// Convert to object
	return $j ;
}


$config = get_config() ;
$oauth_url = $config->oauth_url ;
$widar = new Toolforge\Widar ( 'cradle' , $oauth_url ) ;
$widar->attempt_verification_auto_forward ( $config->cradle_url ) ;
$widar->authorization_callback = $config->cradle_api ;
try {
	if ( $widar->render_reponse ( true ) ) exit ( 0 ) ;
} catch ( Exception $e ) {

}
print json_encode ( ['data'=>'ERROR'] ) ;

?>