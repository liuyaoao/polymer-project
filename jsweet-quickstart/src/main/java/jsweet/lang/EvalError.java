package jsweet.lang;
/** <p>The <strong><code>EvalError</code></strong> object indicates an error regarding the global <code>eval()</code> function.</p>  */
@java.lang.SuppressWarnings("serial")
public class EvalError extends Error {
    public EvalError(java.lang.String message){}
    native public static EvalError applyStatic(java.lang.String message);
    /** 
 Allows the addition of properties to an <code>EvalError</code> object.  */
    public static final EvalError prototype=null;
    public EvalError(){}
    native public static EvalError applyStatic();
}

