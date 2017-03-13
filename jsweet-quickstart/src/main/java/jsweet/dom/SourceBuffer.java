package jsweet.dom;
import jsweet.lang.ArrayBuffer;
import jsweet.lang.ArrayBufferView;
/** <div> <p><span><i> </i></span> <strong>This is an experimental technology</strong><br></br>Because this technology's specification has not stabilized, check the compatibility table for the proper prefixes to use in various browsers. Also note that the syntax and behavior of an experimental technology is subject to change in future versions of browsers as the spec changes.</p> </div> <p>The <strong><code>SourceBuffer</code></strong> interface represents a chunk of media to be passed into an <code>HTMLMediaElement</code> and played, via a <code>MediaSource</code> object. This can be made up of one or several media segments.</p>  */
public class SourceBuffer extends EventTarget {
    /** 
 Controls the timestamp for the end of the append window.  */
    public double appendWindowEnd;
    /** 
 Controls the timestamp for the start of the append window. This is a timestamp range that can be used to filter what media data is appended to the <code>SourceBuffer</code>. Coded media frames with timestamps wthin this range will be appended, whereas those outside the range will be filtered out.  */
    public double appendWindowStart;
    /** 
 A list of the audio tracks currently contained inside the <code>SourceBuffer</code>.  */
    public AudioTrackList audioTracks;
    /** 
 Returns the time ranges that are currently buffered in the <code>SourceBuffer</code>.  */
    public TimeRanges buffered;
    /** 
 Controls how the order of media segments in the <code>SourceBuffer</code> is handled, in terms of whether they can be appended in any order, or they have to be kept in a strict sequence.  */
    public String mode;
    /** 
 Controls the offset applied to timestamps inside media segments that are subsequently appended to the <code>SourceBuffer</code>.  */
    public double timestampOffset;
    /** 
 Indicates whether the <code>SourceBuffer</code> is currently being updated — i.e. whether an <code>SourceBuffer.appendBuffer()</code>, <code>SourceBuffer.appendStream()</code>, or <code>SourceBuffer.remove()</code> operation is currently in progress.  */
    public Boolean updating;
    /** 
 A list of the video tracks currently contained inside the <code>SourceBuffer</code>.  */
    public VideoTrackList videoTracks;
    /** 
 Aborts the current segment and resets the segment parser.  */
    native public void abort();
    /** 
 Appends media segment data from an <code>ArrayBuffer</code> or <code>ArrayBufferView</code> object to the <code>SourceBuffer</code>.  */
    native public void appendBuffer(ArrayBuffer data);
    /** 
 Appends media segment data from a <code>ReadableStream</code> object to the <code>SourceBuffer</code>.  */
    native public void appendStream(MSStream stream, double maxSize);
    /** 
 Removes media segments within a specific time range from the <code>SourceBuffer</code>.  */
    native public void remove(double start, double end);
    public static SourceBuffer prototype;
    public SourceBuffer(){}
    /** 
 Appends media segment data from a <code>ReadableStream</code> object to the <code>SourceBuffer</code>.  */
    native public void appendStream(MSStream stream);
    /** 
 Appends media segment data from an <code>ArrayBuffer</code> or <code>ArrayBufferView</code> object to the <code>SourceBuffer</code>.  */
    native public void appendBuffer(ArrayBufferView data);
}

