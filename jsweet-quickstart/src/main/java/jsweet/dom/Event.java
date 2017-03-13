package jsweet.dom;
/**  <p>The <code><strong>Event</strong></code> interface represents any event of the DOM. It contains common properties and methods to any event.</p> <p>A lot of other interfaces implement the <code>Event</code> interface, either directly or by implementing another interface which does so:</p> <div> <ul> <li><code>AnimationEvent</code></li> <li><code>AudioProcessingEvent</code></li> <li><code>BeforeInputEvent</code></li> <li><code>BeforeUnloadEvent</code></li> <li><code>BlobEvent</code></li> <li><code>ClipboardEvent</code></li> <li><code>CloseEvent</code></li> <li><code>CompositionEvent</code></li> <li><code>CSSFontFaceLoadEvent</code></li> <li><code>CustomEvent</code></li> <li><code>DeviceLightEvent</code></li> <li><code>DeviceMotionEvent</code></li> <li><code>DeviceOrientationEvent</code></li> <li><code>DeviceProximityEvent</code></li> <li><code>DOMTransactionEvent</code></li> <li><code>DragEvent</code></li> <li><code>EditingBeforeInputEvent</code></li> <li><code>ErrorEvent</code></li> <li><code>FetchEvent</code></li> <li><code>FocusEvent</code></li> <li><code>GamepadEvent</code></li> <li><code>HashChangeEvent</code></li> <li><code>IDBVersionChangeEvent</code></li> <li><code>InputEvent</code></li> <li><code>KeyboardEvent</code></li> <li><code>MediaStreamEvent</code></li> <li><code>MessageEvent</code></li> <li><code>MouseEvent</code></li> <li><code>MutationEvent</code></li> <li><code>OfflineAudioCompletionEvent</code></li> <li><code>PageTransitionEvent</code></li> <li><code>PointerEvent</code></li> <li><code>PopStateEvent</code></li> <li><code>ProgressEvent</code></li> <li><code>RelatedEvent</code></li> <li><code>RTCDataChannelEvent</code></li> <li><code>RTCIdentityErrorEvent</code></li> <li><code>RTCIdentityEvent</code></li> <li><code>RTCPeerConnectionIceEvent</code></li> <li><code>SensorEvent</code></li> <li><code>StorageEvent</code></li> <li><code>SVGEvent</code></li> <li><code>SVGZoomEvent</code></li> <li><code>TimeEvent</code></li> <li><code>TouchEvent</code></li> <li><code>TrackEvent</code></li> <li><code>TransitionEvent</code></li> <li><code>UIEvent</code></li> <li><code>UserProximityEvent</code></li> <li><code>WebGLContextEvent</code></li> <li><code>WheelEvent</code></li> </ul> </div>  */
public class Event extends jsweet.lang.Object {
    /** 
 A boolean indicating whether the event bubbles up through the DOM or not.  */
    public Boolean bubbles;
    public Boolean cancelBubble;
    /** 
 A boolean indicating whether the event is cancelable.  */
    public Boolean cancelable;
    /** 
 A reference to the currently registered target for the event.  */
    public EventTarget currentTarget;
    /** 
 Indicates whether or not <code>event.preventDefault()</code> has been called on the event.  */
    public Boolean defaultPrevented;
    /** 
 Indicates which phase of the event flow is being processed.  */
    public double eventPhase;
    /** 
 Indicates whether or not the event was initiated by the browser (after a user click for instance) or by a script (using an event creation method, like event.initEvent)  */
    public Boolean isTrusted;
    public Boolean returnValue;
    /** 
 A nonstandard alias for <code>Event.target</code>. (old Internet Explorer-specific)  */
    public Element srcElement;
    /** 
 A reference to the target to which the event was originally dispatched.  */
    public EventTarget target;
    /** 
 The time that the event was created.  */
    public double timeStamp;
    /** 
 The name of the event (case-insensitive).  */
    public String type;
    /** 
 Initializes the value of an Event created. If the event has already being dispatched, this method does nothing.  */
    native public void initEvent(String eventTypeArg, Boolean canBubbleArg, Boolean cancelableArg);
    /** 
 Cancels the event (if it is cancelable).  */
    native public void preventDefault();
    /** 
 For this particular event, no other listener will be called. Neither those attached on the same element, nor those attached on elements which will be traversed later (in capture phase, for instance)  */
    native public void stopImmediatePropagation();
    /** 
 Stops the propagation of events further along in the DOM.  */
    native public void stopPropagation();
    public double AT_TARGET;
    public double BUBBLING_PHASE;
    public double CAPTURING_PHASE;
    public static Event prototype;
    public Event(String type, EventInit eventInitDict){}
    public Event(String type){}
    protected Event(){}
}

