package jsweet.dom;
/**  <p>The <strong><code>TouchEvent</code></strong> interface represents an event sent when the state of contacts with a touch-sensitive surface changes. This surface can be a touch screen or trackpad, for example. The event can describe one or more points of contact with the screen and includes support for detecting movement, addition and removal of contact points, and so forth.</p> <p>Touches are represented by the <code>Touch</code>&nbsp;object; each touch is described by a position, size and shape, amount of pressure, and target element. Lists of touches are represented by <code>TouchList</code> objects.</p>  */
public class TouchEvent extends UIEvent {
    /** 
 A Boolean value indicating whether or not the alt key was down when the touch event was fired.  */
    public Boolean altKey;
    /** 
 A <code>TouchList</code> of all the <code>Touch</code> objects representing individual points of contact whose states changed between the previous touch event and this one.  */
    public TouchList changedTouches;
    /** 
 A Boolean value indicating whether or not the control key was down when the touch event was fired.  */
    public Boolean ctrlKey;
    /** 
 A Boolean value indicating whether or not the meta key was down when the touch event was fired.  */
    public Boolean metaKey;
    /** 
 A Boolean value indicating whether or not the shift key was down when the touch event was fired.  */
    public Boolean shiftKey;
    /** 
 A <code>TouchList</code> of all the <code>Touch</code>&nbsp;objects that are both currently in contact with the touch surface <strong>and</strong> were also started on the same element that is the target of the event.  */
    public TouchList targetTouches;
    /** 
 A <code>TouchList</code> of all the <code>Touch</code>&nbsp;objects representing all current points of contact with the surface, regardless of target or changed status.  */
    public TouchList touches;
    public static TouchEvent prototype;
    public TouchEvent(){}
}

