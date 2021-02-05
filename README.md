# CFzxing

A barcode generator using the ZXING java library.

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
