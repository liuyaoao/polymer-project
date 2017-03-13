package jsweet.lang;
/** <p>The <strong><code>Error</code></strong> constructor creates an error object. Instances of <code>Error</code> objects are thrown when runtime errors occur. The <code>Error</code> object can also be used as a base objects for user-defined exceptions. See below for standard built-in error types.</p>  */
@java.lang.SuppressWarnings("serial")
public class Error extends RuntimeException {
    public java.lang.String name;
    public java.lang.String message;
    public Error(java.lang.String message){}
    native public static Error applyStatic(java.lang.String message);
    /** 
 Allows the addition of properties to <code>Error</code> instances.  */
    public static final Error prototype=null;
    public Error(){}
    native public static Error applyStatic();
}

