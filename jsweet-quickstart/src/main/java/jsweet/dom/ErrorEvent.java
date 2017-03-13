package jsweet.dom;
/**  <p>The <strong><code>ErrorEvent</code></strong> interface represents events providing information related to errors in scripts or in files.</p>  */
public class ErrorEvent extends Event {
    /** 
 Is an <code>integer</code> containing the column number of the script file on which the error occurred.  */
    public double colno;
    /** 
 Is a JavaScript <code>Object</code> that is concerned by the event.  */
    public Object error;
    /** 
 Is a <code>DOMString</code> containing the name of the script file in which the error occurred.  */
    public String filename;
    /** 
 Is an <code>integer</code> containing the line number of the script file on which the error occurred.  */
    public double lineno;
    /** 
 Is a <code>DOMString</code> containing a human-readable error message describing the problem.  */
    public String message;
    native public void initErrorEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, String messageArg, String filenameArg, double linenoArg);
    public static ErrorEvent prototype;
    public ErrorEvent(){}
}

