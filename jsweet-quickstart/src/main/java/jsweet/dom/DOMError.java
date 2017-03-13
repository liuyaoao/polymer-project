package jsweet.dom;
/**  <p>The <strong><code>DOMError</code></strong> interface describes an error object that contains an error name.</p>  */
public class DOMError extends jsweet.lang.Object {
    /** 
 Returns a <code>DOMString</code> representing one of the error type names (see below).  */
    public String name;
    native public String toString();
    public static DOMError prototype;
    public DOMError(){}
}

