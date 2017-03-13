package jsweet.dom;
/** <div> <p><span><i> </i></span> <strong>This is an experimental technology</strong><br></br>Because this technology's specification has not stabilized, check the compatibility table for the proper prefixes to use in various browsers. Also note that the syntax and behavior of an experimental technology is subject to change in future versions of browsers as the spec changes.</p> </div> <p>The <strong><code>SourceBufferList</code></strong> interface represents a simple container list for multiple <code>SourceBuffer</code> objects.</p> <p>The source buffer list containing the <code>SourceBuffer</code>s appended to a particular <code>MediaSource</code> can be retrieved using the <code>MediaSource.sourceBuffers</code> property.</p>  */
public class SourceBufferList extends EventTarget implements Iterable<SourceBuffer> {
    /** 
 Returns the number of <code>SourceBuffer</code> objects in the list.  */
    public double length;
    native public SourceBuffer item(double index);
    native public SourceBuffer $get(double index);
    public static SourceBufferList prototype;
    public SourceBufferList(){}
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<SourceBuffer> iterator();
}

