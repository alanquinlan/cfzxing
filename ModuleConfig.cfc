/**
 * Module Directives as public properties
 *
 * this.title 				= "Title of the module";
 * this.author 			= "Author of the module";
 * this.webURL 			= "Web URL for docs purposes";
 * this.description 		= "Module description";
 * this.version 			= "Module Version";
 * this.viewParentLookup   = (true) [boolean] (Optional) // If true, checks for views in the parent first, then it the module.If false, then modules first, then parent.
 * this.layoutParentLookup = (true) [boolean] (Optional) // If true, checks for layouts in the parent first, then it the module.If false, then modules first, then parent.
 * this.entryPoint  		= "" (Optional) // If set, this is the default event (ex:forgebox:manager.index) or default route (/forgebox) the framework will use to create an entry link to the module. Similar to a default event.
 * this.cfmapping			= "The CF mapping to create";
 * this.modelNamespace		= "The namespace to use for registered models, if blank it uses the name of the module."
 * this.dependencies 		= "The array of dependencies for this module"
 *
 * structures to create for configuration
 * - parentSettings : struct (will append and override parent)
 * - settings : struct
 * - interceptorSettings : struct of the following keys ATM
 * 	- customInterceptionPoints : string list of custom interception points
 * - interceptors : array
 * - layoutSettings : struct (will allow to define a defaultLayout for the module)
 * - wirebox : The wirebox DSL to load and use
 *
 * Available objects in variable scope
 * - controller
 * - appMapping (application mapping)
 * - moduleMapping (include,cf path)
 * - modulePath (absolute path)
 * - log (A pre-configured logBox logger object for this object)
 * - binder (The wirebox configuration binder)
 * - wirebox (The wirebox injector)
 *
 * Required Methods
 * - configure() : The method ColdBox calls to configure the module.
 *
 * Optional Methods
 * - onLoad() 		: If found, it is fired once the module is fully loaded
 * - onUnload() 	: If found, it is fired once the module is unloaded
 **/
component {

	// Module Properties
	this.title              = "CFzxing";
	this.author             = "Alan Quinlan";
	this.webURL             = "https://github.com/alanquinlan/cfzxing";
	this.description        = "A barcode generator using the ZXING java library. Supports: AZTEC, CODABAR, CODE_39, CODE_93, CODE_128, DATA_MATRIX, EAN_8, EAN_13, ITF, QR_CODE ,UPC_A";
	this.version            = "1.0.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup   = true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint         = "cfzxing";
	// Inherit Entry Point
	this.inheritEntryPoint  = false;
	// Model Namespace
	this.modelNamespace     = "cfzxing";
	// CF Mapping
	this.cfmapping          = "cfzxing";
	// Auto-map models
	this.autoMapModels      = true;
	// Module Dependencies
	this.dependencies       = [ "cbjavaloader" ];

	/**
	 * Configure the module
	 */
	function configure() {
	}

	/**
	 * Fired when the module is registered and activated.
	 */
	function onLoad() {
		// Add the QR code jars to the cbjavaloader
		variables.wirebox.getInstance( "loader@cbjavaloader" ).appendPaths( "#variables.modulePath#/lib" );

		// Map the Barcode resouce
		binder.map( "Barcode@cfzxing" ).to( "#moduleMapping#.models.Barcode" );
	}

}
