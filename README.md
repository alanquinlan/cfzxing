# CFzxing

A barcode generator using the ZXING java library.

## Supports Barcode Types: 

AZTEC, CODABAR, CODE_39, CODE_93, CODE_128, DATA_MATRIX, EAN_8, EAN_13, ITF, QR_CODE, UPC_A


## Examples

```bash
box install cfzxing
```

```cfc
// returns an image
image = wirebox.getInstance( "Barcode@cfzxing" ).getBarcodeImage(   contents = 'Hello World!',
                                                                    type = 'QR_CODE',
                                                                    width = 128,
                                                                    height = 128 );

// writes an image to a destination
wirebox.getInstance( "Barcode@cfzxing" ).getBarcodeImage(   contents = 'Hello World!',
                                                            type = 'QR_CODE',
                                                            width = 128,
                                                            height = 128,
                                                            destination = '/img/foobar.jpg',
                                                            overwrite = true );
```
