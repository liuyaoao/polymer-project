package jsweet.lang;
/** <p>The <code><strong>ReferenceError</strong></code> object represents an error when a non-existent variable is referenced.</p>  */
@java.lang.SuppressWarnings("serial")
public class ReferenceError extends Error {
    public ReferenceError(java.lang.String message){}
    native public static ReferenceError applyStatic(java.lang.String message);
    /** 
 Allows the addition of properties to an <code>ReferenceError</code> object.  */
    public static final ReferenceError prototype=null;
    public ReferenceError(){}
    native public static ReferenceError applyStatic();
}

