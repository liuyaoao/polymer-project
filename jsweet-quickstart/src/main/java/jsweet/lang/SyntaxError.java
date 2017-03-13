package jsweet.lang;
/** <p>The <code><strong>SyntaxError</strong></code> object represents an error when trying to interpret syntactically invalid code.</p>  */
@java.lang.SuppressWarnings("serial")
public class SyntaxError extends Error {
    public SyntaxError(java.lang.String message){}
    native public static SyntaxError applyStatic(java.lang.String message);
    /** 
 Allows the addition of properties to a <code>SyntaxError</code> object.  */
    public static final SyntaxError prototype=null;
    public SyntaxError(){}
    native public static SyntaxError applyStatic();
}

