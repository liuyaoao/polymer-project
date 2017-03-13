package jsweet.dom;
/** <div> <p><span><i> </i></span> <strong>This is an experimental technology</strong><br></br>Because this technology's specification has not stabilized, check the compatibility table for the proper prefixes to use in various browsers. Also note that the syntax and behavior of an experimental technology is subject to change in future versions of browsers as the spec changes.</p> </div> */
@jsweet.lang.Interface
public abstract class URL extends jsweet.lang.Object {
    /** 
 Returns a <code>DOMString</code> containing a unique blob URL, that is a URL with <code>blob:</code> as its scheme, followed by an opaque string uniquely identifying the object in the browser.  */
    native public static String createObjectURL(Object object, ObjectURLOptions options);
    /** 
 Revokes an object URL previously created using <code>URL.createObjectURL()</code>.  */
    native public static void revokeObjectURL(String url);
    /** 
 Returns a <code>DOMString</code> containing a unique blob URL, that is a URL with <code>blob:</code> as its scheme, followed by an opaque string uniquely identifying the object in the browser.  */
    native public static String createObjectURL(Object object);
}

