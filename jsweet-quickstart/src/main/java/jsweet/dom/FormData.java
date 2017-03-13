package jsweet.dom;
/**  <p>XMLHttpRequest Level 2 adds support for the new <code>FormData</code> interface. <code>FormData</code> objects provide a way to easily construct a set of key/value pairs representing form fields and their values, which can then be easily sent using the XMLHttpRequest <code>send()</code>&nbsp;method.</p> <p>It uses the same format a form would use if the encoding type were set to &quot;multipart/form-data&quot;.</p> <div> <p><strong>Note</strong>: This feature is available in Web Workers.</p> </div> <div> <p><strong>Note</strong>: For details on how to use the <code>FormData</code> object, see Using FormData objects.</p> </div>  */
public class FormData extends jsweet.lang.Object {
    /** 
 Appends a new value onto an existing key inside a <code>FormData</code> object, or adds the key if it does not already exist.  */
    native public void append(Object name, Object value, String blobName);
    public static FormData prototype;
    public FormData(HTMLFormElement form){}
    /** 
 Appends a new value onto an existing key inside a <code>FormData</code> object, or adds the key if it does not already exist.  */
    native public void append(Object name, Object value);
    public FormData(){}
}

