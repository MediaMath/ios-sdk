# ios-sdk
A simple framework for firing MediaMath Pixels

## Usage
The SDK has two static reporting functions: `report(advertiser: Int, pixel: Int, addlParams: String?)` and `report(advertiser: String, pixel: String, addlParams: String?)`.
* `advertiser` : TerminalOne Advertiser ID (value from `&mt_adid=` of a JS pixel from a website)
* `pixel` : TerminalOne Pixel ID (value from `&mt_id=` of a JS pixel from a website)
* `addlParams` : Additional information to send to TerminalOne at the time of pixel fire, in the format of a URL-encoded string of parameters joined by & characters (e.g.`"v1=data1&v2=data2&s1=data3"`). May be omitted from function calls if not needed. Advertisers typically use these in scenarios like the following:
  * Revenue tracking: To send a pixel tracking the value of an order, include something like `v1=99.99&s1=USD`.
  * Deterministic reinforcement: include a `mt_exem` or `mt_excl` argument
    * The value for the mt_exem (for hashed emails, 'john@email.com') or the mt_excl (for hashed account ids, e.g. 'john2015', '829852', etc) the parameter value must be the SHA-256 hashed, when available at the time of pixel firing.
    * The hashing of the email address is not performed by the MediaMath Pixel SDK. The app developer must SHA-256 hash the email address. For more information, see the [API docs on mobile pixels](https://apidocs.mediamath.com/v1/mobile-pixel-sdk/mobile-pixel-sdk#SHA256).
  * See the [Knowledge Base](https://kb.mediamath.com/wiki/x/pwCR#EventPixels-PixelFields) for more information about additional parameters.

### Debugging 
There is a `setDebugOutput(debug: Bool)` function for enabling the printing of debug output to console. 

### Example App
Check out the `MMPixelExampleApp` for a simple implementation of the framework.
