/**
 * https://zxing.github.io/zxing/apidocs/
 */
component singleton="true" {

	property name="javaloader" inject="loader@cbjavaloader";


	variables.codes = {
		"AZTEC"       : "com.google.zxing.aztec.AztecWriter",
		"CODABAR"     : "com.google.zxing.oned.CodaBarWriter",
		"CODE_39"     : "com.google.zxing.oned.Code39Writer",
		"CODE_93"     : "com.google.zxing.oned.Code93Writer",
		"CODE_128"    : "com.google.zxing.oned.Code128Writer",
		"DATA_MATRIX" : "com.google.zxing.datamatrix.DataMatrixWriter",
		"EAN_8"       : "com.google.zxing.oned.EAN8Writer",
		"EAN_13"      : "com.google.zxing.oned.EAN13Writer",
		"ITF"         : "com.google.zxing.oned.ITFWriter",
		// 'MAXICODE'
		// 'PDF_417'
		"QR_CODE"     : "com.google.zxing.qrcode.QRCodeWriter",
		// 'RSS_14'
		// 'RSS_EXPANDED'
		"UPC_A"       : "com.google.zxing.oned.UPCAWriter"
		// 'UPC_E': 'com.google.zxing.oned.UPCEWriter',
		// 'UPC_EAN_EXTENSION': 'com.google.zxing.oned.UPCEANWriter'
	}



	/**
	 * Undocumented function
	 *
	 * @contents
	 * @type
	 * @width
	 * @height
	 */
	any function getBarcodeImage(
		required string contents,
		required string type,
		required numeric width,
		required numeric height
	) {
		local.typelist = structKeyList( variables.codes );

		local.MatrixToImageWriter = variables.javaloader.create( "com.google.zxing.client.j2se.MatrixToImageWriter" );


		if ( !listFindNoCase( local.typelist, arguments.type ) ) {
			throw(
				type    = "CFzxing.InvalidType",
				message = "CFzxing type must be one of the following (#local.typelist#)"
			);
		}

		try {
			local.theMatrix = variables.javaloader.create( variables.codes[ arguments.type ] ).encode(
				javacast( "string", arguments.contents ),
				variables.javaloader
					.create( "com.google.zxing.BarcodeFormat" )
					.valueOf( javacast( "string", arguments.type ) ),
				javacast( "int", arguments.width ),
				javacast( "int", arguments.height )
			);
		} catch ( any x ) {
			throw( type = "CFzxing.InvalidType", message = "CFzxing (#arguments.type#) - (#x.message#)" );
		}


		local.imageBuffer = local.MatrixToImageWriter.toBufferedImage( local.theMatrix );

		return imageNew( local.imageBuffer );
	}


	/**
	 * Write the barcode image to a destination
	 *
	 * @contents
	 * @width
	 * @height
	 * @destination
	 * @overwrite
	 */
	void function writeBarcodeImage(
		required string contents,
		required string type,
		required numeric width,
		required numeric height,
		required destination,
		boolean overwrite = true
	) {

		local.bcimage = this.getBarcodeImage( argumentCollection = arguments );

		if ( isImage( local.bcimage ) ) {
			imageWrite(
				local.bcimage,
				arguments.destination,
				arguments.overwrite
			);
		} else {
			throw( type = "CFzxing.InvalidImage", message = "CFzxing getBarcodeImage() did not return a valid image." );
		}
	}

}
