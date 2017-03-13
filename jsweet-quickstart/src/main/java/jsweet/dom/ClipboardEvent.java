package jsweet.dom;
/** <div> <p><span><i> </i></span> <strong>This is an experimental technology</strong><br></br>Because this technology's specification has not stabilized, check the compatibility table for the proper prefixes to use in various browsers. Also note that the syntax and behavior of an experimental technology is subject to change in future versions of browsers as the spec changes.</p> </div> <p>The <strong><code>ClipboardEvent</code></strong> interface represents events providing information related to modification of the clipboard, that is <code>cut</code>, <code>copy</code>, and <code>paste</code> events.</p>  */
public class ClipboardEvent extends Event {
    /** 
 Is a <code>DataTransfer</code> object containing the data affected by the user-initiated <code>cut</code>, <code>copy</code>, or <code>paste</code> operation, along with its MIME type.  */
    public DataTransfer clipboardData;
    public static ClipboardEvent prototype;
    public ClipboardEvent(String type, ClipboardEventInit eventInitDict){}
    public ClipboardEvent(String type){}
    protected ClipboardEvent(){}
}

