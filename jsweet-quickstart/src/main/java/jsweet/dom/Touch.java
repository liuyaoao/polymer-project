package jsweet.dom;
/**  <p>The <strong><code>Touch</code></strong> interface represents a single contact point on a touch-sensitive device. The contact point is commonly a finger or stylus and the device may be a touchscreen or trackpad.</p> <p>The <code>Touch.radiusX</code>, <code>Touch.radiusY</code>, and <code>Touch.rotationAngle</code>&nbsp;describe the area of contact between the user and the screen, the <em>touch area</em>. This can be helpful when dealing with imprecise pointing devices such as fingers. These values are set to describe an ellipse that as closely as possible matches the entire area of contact (such as the user's fingertip). <span><i> </i></span></p> <div> <p><strong>Note:</strong> Many of the properties' values are hardware-dependent; for example, if the device doesn't have a way to detect the amount of pressure placed on the surface, the <code>force</code> value will always be 0. This may also be the case for <code>radiusX</code>&nbsp;and <code>radiusY</code>; if the hardware reports only a single point, these values will be 1.</p> </div>  */
public class Touch extends jsweet.lang.Object {
    public double clientX;
    public double clientY;
    /** 
 Returns a unique identifier for this <code>Touch</code> object. A given touch point (say, by a finger) will have the same identifier for the duration of its movement around the surface. This lets you ensure that you're tracking the same touch all the time.  */
    public double identifier;
    /** 
 Returns the X coordinate of the touch point relative to the left edge of the document. Unlike <code>clientX</code>, this value includes the horizontal scroll offset, if any.  */
    public double pageX;
    /** 
 Returns the Y coordinate of the touch point relative to the top of the document. Unlike <code>clientY,</code> this value includes the vertical scroll offset, if any.  */
    public double pageY;
    public double screenX;
    public double screenY;
    /** 
 Returns the <code>Element</code> on which the touch point started when it was first placed on the surface, even if the touch point has since moved outside the interactive area of that element or even been removed from the document.  */
    public EventTarget target;
    public static Touch prototype;
    public Touch(){}
}

