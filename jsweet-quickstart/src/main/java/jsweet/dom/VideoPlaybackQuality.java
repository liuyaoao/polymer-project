package jsweet.dom;
/** <div> <p><span><i> </i></span> <strong>This is an experimental technology</strong><br></br>Because this technology's specification has not stabilized, check the compatibility table for the proper prefixes to use in various browsers. Also note that the syntax and behavior of an experimental technology is subject to change in future versions of browsers as the spec changes.</p> </div> <p>The <code><strong>VideoPlaybackQuality</strong></code> interface represents the set of metrics describing the playback quality of a video.</p> <p>An instance is created using the <code>HTMLVideoElement.getVideoPlaybackQuality()</code> method.</p>  */
public class VideoPlaybackQuality extends jsweet.lang.Object {
    /** 
 An <code>unsigned long</code> giving the number of video frames corrupted since the creation of the associated <code>HTMLVideoElement</code>. A corrupted frame may be created or dropped.  */
    public double corruptedVideoFrames;
    /** 
 A <code>DOMHighResTimeStamp</code> containing the time in miliseconds since the start of the navigation and the creation of the object.  */
    public double creationTime;
    /** 
 An <code>unsigned long</code> giving the number of video frames dropped since the creation of the associated <code>HTMLVideoElement</code>.  */
    public double droppedVideoFrames;
    /** 
 A <code>double</code> containing the sum of the frame delay since the creation of the associated <code>HTMLVideoElement</code>. The frame delay is the difference between a frame's theoretical presentation time and its effective display time.  */
    public double totalFrameDelay;
    /** 
 An <code>unsigned long</code> giving the number of video frames created and dropped since the creation of the associated <code>HTMLVideoElement</code>.  */
    public double totalVideoFrames;
    public static VideoPlaybackQuality prototype;
    public VideoPlaybackQuality(){}
}

