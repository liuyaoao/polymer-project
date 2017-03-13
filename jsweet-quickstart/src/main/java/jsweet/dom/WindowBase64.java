package jsweet.dom;
/**  <p>The <code><strong>WindowBase64</strong></code> helper contains utility methods to convert data to and from base64, a binary-to-text encoding scheme. For example it is used in data URIs.</p> <p>There is no object of this type, though the context object, either the <code>Window</code> for regular browsing scope, or the <code>WorkerGlobalScope</code>&nbsp; for workers, implements it.</p>  */
@jsweet.lang.Interface
public abstract class WindowBase64 extends jsweet.lang.Object {
    /** 
 Decodes a string of data which has been encoded using base-64 encoding.  */
    native public String atob(String encodedString);
    /** 
 Creates a base-64 encoded ASCII string from a string of binary data.  */
    native public String btoa(String rawString);
}

