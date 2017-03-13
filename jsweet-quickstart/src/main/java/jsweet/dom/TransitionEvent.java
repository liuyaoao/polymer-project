package jsweet.dom;
/** <div> <p><span><i> </i></span> <strong>This is an experimental technology</strong><br></br>Because this technology's specification has not stabilized, check the compatibility table for the proper prefixes to use in various browsers. Also note that the syntax and behavior of an experimental technology is subject to change in future versions of browsers as the spec changes.</p> </div> <p>The <code><strong>Transition</strong></code><strong><code>Event</code></strong> interface represents events providing information related to transitions.</p>  */
public class TransitionEvent extends Event {
    /** 
 Is a <code>float</code> giving the amount of time the transtion has been running, in seconds, when this event fired. This value is not affected by the <code>transition-delay</code> property.  */
    public double elapsedTime;
    /** 
 Is a <code>DOMString</code> containing the name CSS property associated with the transition.  */
    public String propertyName;
    /** 
 Initializes a <code>TransitionEvent</code> created using the deprecated <code>Document.createEvent(&quot;TransitionEvent&quot;)</code> method.  */
    native public void initTransitionEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, String propertyNameArg, double elapsedTimeArg);
    public static TransitionEvent prototype;
    public TransitionEvent(){}
}

