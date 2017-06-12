# iOS-SDK
A simple framework for firing MediaMath Pixels

## Usage
The SDK has four static reporting functions: 
* `report(advertiser: Int, pixel: Int, addlParams: String?)`
* `report(advertiser: String, pixel: String, addlParams: String?)`
* `report(advertiser: Int, pixel: Int, addlParams: [String: String])`
* `report(advertiser: String, pixel: String, addlParams: [String: String])`

  * `advertiser` : TerminalOne Advertiser ID (value from `&mt_adid=` of a JS pixel from a website)
  * `pixel` : TerminalOne Pixel ID (value from `&mt_id=` of a JS pixel from a website)
  * `addlParams` : Additional information to send to TerminalOne at the time of pixel fire (see ['The addlParams argment'](#the-addlparams-argument))
  
### The `addlParams` argument
`addlParams` may be passed in as a `[String: String]` dictionary or as a URL-encoded string of parameters joined by ampersand characters (e.g.`"v1=data1&v2=data2&s1=data3"`) It may be omitted from function calls if not needed. Advertisers typically use these in scenarios such as the following:
The `addlParams` may be used in the following ways:
* Revenue tracking: To send a pixel tracking the value of an order, include something like `v1=99.99&s1=USD`.
* Deterministic reinforcement: include a `mt_exem` or `mt_excl` argument
  * The value for the mt_exem (for hashed emails, 'john@email.com') or the mt_excl (for hashed account ids, e.g. 'john2015', '829852', etc) must be SHA-256 hashed at the time of pixel firing
  * When using `addlParams: [String: String]`, the value of `mt_excl` is automatically hashed. The value of `mt_exem` is hashed if it contains an '@' character (i.e. if it is an email address)
  * When using `addlParams: String`, hashing is not performed by the MediaMath Pixel SDK. The app developer must SHA-256 hash the value.
  * For more information, see the [API docs on mobile pixels](https://apidocs.mediamath.com/v1/mobile-pixel-sdk/mobile-pixel-sdk#SHA256).
* For more information on additional parameters, consule the [Knowledge Base](https://kb.mediamath.com/wiki/x/pwCR#EventPixels-PixelFields).

### Debugging 
There is a `setDebugOutput(debug: Bool)` function for enabling the printing of debug output to console. 

### Example App
Check out the `MMPixelExampleApp` for a simple implementation of the framework.
