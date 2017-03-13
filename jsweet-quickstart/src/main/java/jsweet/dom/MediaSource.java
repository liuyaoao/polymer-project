package jsweet.dom;
/** <div> <p><span><i> </i></span> <strong>This is an experimental technology</strong><br></br>Because this technology's specification has not stabilized, check the compatibility table for the proper prefixes to use in various browsers. Also note that the syntax and behavior of an experimental technology is subject to change in future versions of browsers as the spec changes.</p> </div> <p>The <strong><code>MediaSource</code></strong> interface represents a source of media data for an <code>HTMLMediaElement</code> object. A <code>MediaSource</code> object can be attached to a <code>HTMLMediaElement</code> to be played in the user agent.</p>  */
public class MediaSource extends EventTarget {
    /** 
 Returns a <code>SourceBufferList</code> object containing a subset of the&nbsp; <code>SourceBuffer</code> objects contained within <code>SourceBuffers</code> — the list of objects providing the selected video track,&nbsp; enabled audio tracks, and shown/hidden text tracks.  */
    public SourceBufferList activeSourceBuffers;
    /** 
 Gets and sets the duration of the current media being presented.  */
    public double duration;
    /** 
 Returns an enum representing the state of the current <code>MediaSource</code>, whether it is not currently attached to a media element ( <code>closed</code>), attached and ready to receive <code>SourceBuffer</code> objects ( <code>open</code>), or attached but the stream has been ended via <code>MediaSource.endOfStream()</code> ( <code>ended</code>.)  */
    public String readyState;
    /** 
 Returns a <code>SourceBufferList</code> object containing the list of <code>SourceBuffer</code> objects associated with this <code>MediaSource</code>.  */
    public SourceBufferList sourceBuffers;
    /** 
 Creates a new <code>SourceBuffer</code> of the given MIME type and adds it to the <code>MediaSource</code>'s <code>SourceBuffers</code> list.  */
    native public SourceBuffer addSourceBuffer(String type);
    /** 
 Signals the end of the stream.  */
    native public void endOfStream(double error);
    /** 
 Removes the given <code>SourceBuffer</code> from the <code>SourceBuffers</code> list associated with this <code>MediaSource</code> object.  */
    native public void removeSourceBuffer(SourceBuffer sourceBuffer);
    public static MediaSource prototype;
    public MediaSource(){}
    /** 
 Returns a <code>Boolean</code> value indicating if the given MIME type is supported by the current user agent — this is, if it can successfully create <code>SourceBuffer</code> objects for that MIME type.  */
    native public static Boolean isTypeSupported(String type);
    /** 
 Signals the end of the stream.  */
    native public void endOfStream();
}

