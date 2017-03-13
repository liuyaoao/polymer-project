package jsweet.dom;
/** <p>The <code>SVGSVGElement</code> interface provides access to the properties of <code>&lt;svg&gt;</code> elements, as well as methods to manipulate them. This interface contains also various miscellaneous commonly-used utility methods, such as matrix operations and the ability to control the time of redraw on visual rendering devices.</p>  */
@jsweet.lang.Extends({DocumentEvent.class,SVGLocatable.class,SVGTests.class,SVGStylable.class,SVGLangSpace.class,SVGExternalResourcesRequired.class,SVGFitToViewBox.class,SVGZoomAndPan.class})
public class SVGSVGElement extends SVGElement {
    /** 
Corresponds to attribute <code>contentScriptType</code> on the given <code>&lt;svg&gt;</code> element. */
    public String contentScriptType;
    /** 
Corresponds to attribute <code>contentStyleType</code> on the given <code>&lt;svg&gt;</code> element. */
    public String contentStyleType;
    /** 
On an outermost <code>&lt;svg&gt;</code> element, this attribute indicates the current scale factor relative to the initial view to take into account user magnification and panning operations. DOM attributes <code>currentScale</code> and <code>currentTranslate</code> are equivalent to the 2x3 matrix <code>[a b c d e f] = [currentScale 0 0 currentScale currentTranslate.x currentTranslate.y]</code>. If &quot;magnification&quot; is enabled (i.e., <code>zoomAndPan=&quot;magnify&quot;</code>), then the effect is as if an extra transformation were placed at the outermost level on the SVG document fragment (i.e., outside the outermost <code>&lt;svg&gt;</code> element). */
    public double currentScale;
    /** 
On an outermost <code>&lt;svg&gt;</code> element, the corresponding translation factor that takes into account user &quot;magnification&quot;. */
    public SVGPoint currentTranslate;
    /** 
Corresponds to attribute <code>height</code> on the given <code>&lt;svg&gt;</code> element. */
    public SVGAnimatedLength height;
    public java.util.function.Function<Event,Object> onabort;
    public java.util.function.Function<Event,Object> onerror;
    public java.util.function.Function<UIEvent,Object> onresize;
    public java.util.function.Function<UIEvent,Object> onscroll;
    public java.util.function.Function<Event,Object> onunload;
    public java.util.function.Function<SVGZoomEvent,Object> onzoom;
    /** 
Size of a pixel units (as defined by CSS2) along the x-axis of the viewport, which represents a unit somewhere in the range of 70dpi to 120dpi, and, on systems that support this, might actually match the characteristics of the target medium. On systems where it is impossible to know the size of a pixel, a suitable default pixel size is provided. */
    public double pixelUnitToMillimeterX;
    /** 
Corresponding size of a pixel unit along the y-axis of the viewport. */
    public double pixelUnitToMillimeterY;
    /** 
User interface (UI) events in DOM Level 2 indicate the screen positions at which the given UI event occurred. When the browser actually knows the physical size of a &quot;screen unit&quot;, this attribute will express that information; otherwise, user agents will provide a suitable default value such as .28mm. */
    public double screenPixelToMillimeterX;
    /** 
Corresponding size of a screen pixel along the y-axis of the viewport. */
    public double screenPixelToMillimeterY;
    /** 
The position and size of the viewport (implicit or explicit) that corresponds to this <code>&lt;svg&gt;</code> element. When the browser is actually rendering the content, then the position and size values represent the actual values when rendering. The position and size values are unitless values in the coordinate system of the parent element. If no parent element exists (i.e., <code>&lt;svg&gt;</code> element represents the root of the document tree), if this SVG document is embedded as part of another document (e.g., via the HTML <code>&lt;object&gt;</code> element), then the position and size are unitless values in the coordinate system of the parent document. (If the parent uses CSS or XSL layout, then unitless values represent pixel units for the current CSS or XSL viewport.) */
    public SVGRect viewport;
    /** 
Corresponds to attribute <code>width</code> on the given <code>&lt;svg&gt;</code> element. */
    public SVGAnimatedLength width;
    /** 
Corresponds to attribute <code>x</code> on the given <code>&lt;svg&gt;</code> element. */
    public SVGAnimatedLength x;
    /** 
Corresponds to attribute <code>y</code> on the given <code>&lt;svg&gt;</code> element. */
    public SVGAnimatedLength y;
    /** 
Returns true if the rendered content of the given element is entirely contained within the supplied rectangle. Each candidate graphics element is to be considered a match only if the same graphics element can be a target of pointer events as defined in <code>pointer-events</code> processing. */
    native public Boolean checkEnclosure(SVGElement element, SVGRect rect);
    /** 
Returns true if the rendered content of the given element intersects the supplied rectangle. Each candidate graphics element is to be considered a match only if the same graphics element can be a target of pointer events as defined in <code>pointer-events</code> processing. */
    native public Boolean checkIntersection(SVGElement element, SVGRect rect);
    /** 
Creates an <code>SVGAngle</code> object outside of any document trees. The object is initialized to a value of zero degrees (unitless). */
    native public SVGAngle createSVGAngle();
    /** 
Creates an <code>SVGLength</code> object outside of any document trees. The object is initialized to a value of zero user units. */
    native public SVGLength createSVGLength();
    /** 
Creates an <code>SVGMatrix</code> object outside of any document trees. The object is initialized to the identity matrix. */
    native public SVGMatrix createSVGMatrix();
    /** 
Creates an <code>SVGNumber</code> object outside of any document trees. The object is initialized to a value of zero. */
    native public SVGNumber createSVGNumber();
    /** 
Creates an <code>SVGPoint</code> object outside of any document trees. The object is initialized to the point (0,0) in the user coordinate system. */
    native public SVGPoint createSVGPoint();
    /** 
Creates an <code>SVGRect</code> object outside of any document trees. The object is initialized such that all values are set to 0 user units. */
    native public SVGRect createSVGRect();
    /** 
Creates an <code>SVGTransform</code> object outside of any document trees. The object is initialized to an identity matrix transform (<code>SVG_TRANSFORM_MATRIX</code>). */
    native public SVGTransform createSVGTransform();
    /** 
Creates an <code>SVGTransform</code> object outside of any document trees. The object is initialized to the given matrix transform (i.e., <code>SVG_TRANSFORM_MATRIX</code>). The values from the parameter matrix are copied, the matrix parameter is not adopted as <code>SVGTransform::matrix</code>. */
    native public SVGTransform createSVGTransformFromMatrix(SVGMatrix matrix);
    /** 
Unselects any selected objects, including any selections of text strings and type-in bars. */
    native public void deselectAll();
    /** 
In rendering environments supporting interactivity, forces the user agent to immediately redraw all regions of the viewport that require updating. */
    native public void forceRedraw();
    native public CSSStyleDeclaration getComputedStyle(Element elt, String pseudoElt);
    /** 
Returns the current time in seconds relative to the start time for the current SVG document fragment. If getCurrentTime is called before the document timeline has begun (for example, by script running in a <code>&lt;script&gt;</code> element before the document's SVGLoad event is dispatched), then 0 is returned. */
    native public double getCurrentTime();
    /** 
Searches this SVG document fragment (i.e., the search is restricted to a subset of the document tree) for an Element whose id is given by <em>elementId</em>. If an Element is found, that Element is returned. If no such element exists, returns null. Behavior is not defined if more than one element has this id. */
    native public Element getElementById(String elementId);
    /** 
Returns the list of graphics elements whose rendered content is entirely contained within the supplied rectangle. Each candidate graphics element is to be considered a match only if the same graphics element can be a target of pointer events as defined in <code>pointer-events</code> processing. */
    native public NodeList getEnclosureList(SVGRect rect, SVGElement referenceElement);
    /** 
Returns the list of graphics elements whose rendered content intersects the supplied rectangle. Each candidate graphics element is to be considered a match only if the same graphics element can be a target of pointer events as defined in <code>pointer-events</code> processing. */
    native public NodeList getIntersectionList(SVGRect rect, SVGElement referenceElement);
    /** 
Suspends (i.e., pauses) all currently running animations that are defined within the SVG document fragment corresponding to this <code>&lt;svg&gt;</code> element, causing the animation clock corresponding to this document fragment to stand still until it is unpaused. */
    native public void pauseAnimations();
    /** 
Adjusts the clock for this SVG document fragment, establishing a new current time. If <code>setCurrentTime</code> is called before the document timeline has begun (for example, by script running in a <code>&lt;script&gt;</code> element before the document's SVGLoad event is dispatched), then the value of seconds in the last invocation of the method gives the time that the document will seek to once the document timeline has begun. */
    native public void setCurrentTime(double seconds);
    /** <p>Takes a time-out value which indicates that redraw shall not occur until:</p> <ol> <li>the corresponding unsuspendRedraw() call has been made,</li> <li>an unsuspendRedrawAll() call has been made, or</li> <li>its timer has timed out.</li> </ol> <p>In environments that do not support interactivity (e.g., print media), then redraw shall not be suspended. Calls to <code>suspendRedraw()</code> and <code>unsuspendRedraw()</code> should, but need not be, made in balanced pairs.</p> <p>To suspend redraw actions as a collection of SVG DOM changes occur, precede the changes to the SVG DOM with a method call similar to:</p> <p><code>suspendHandleID = suspendRedraw(maxWaitMilliseconds);</code></p> <p>and follow the changes with a method call similar to:</p> <p><code>unsuspendRedraw(suspendHandleID);</code></p> <p>Note that multiple suspendRedraw calls can be used at once and that each such method call is treated independently of the other suspendRedraw method calls.</p>  */
    native public double suspendRedraw(double maxWaitMilliseconds);
    /** 
Unsuspends (i.e., unpauses) currently running animations that are defined within the SVG document fragment, causing the animation clock to continue from the time at which it was suspended. */
    native public void unpauseAnimations();
    /** 
Cancels a specified <code>suspendRedraw()</code> by providing a unique suspend handle ID that was returned by a previous <code>suspendRedraw()</code> call. */
    native public void unsuspendRedraw(double suspendHandleID);
    /** 
Cancels all currently active <code>suspendRedraw()</code> method calls. This method is most useful at the very end of a set of SVG DOM calls to ensure that all pending <code>suspendRedraw()</code> method calls have been cancelled. */
    native public void unsuspendRedrawAll();
    native public void addEventListener(jsweet.util.StringTypes.MSGestureChange type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureDoubleTap type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureEnd type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureHold type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureStart type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureTap type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGotPointerCapture type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSInertiaStart type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSLostPointerCapture type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerCancel type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerDown type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerEnter type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerLeave type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerMove type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerOut type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerOver type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerUp type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.SVGAbort type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.SVGError type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.SVGUnload type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.SVGZoom type, java.util.function.Function<SVGZoomEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.ariarequest type, java.util.function.Function<AriaRequestEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.click type, java.util.function.Function<MouseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.command type, java.util.function.Function<CommandEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.dblclick type, java.util.function.Function<MouseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.focusin type, java.util.function.Function<FocusEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.focusout type, java.util.function.Function<FocusEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.gotpointercapture type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.load type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.lostpointercapture type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.mousedown type, java.util.function.Function<MouseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.mousemove type, java.util.function.Function<MouseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.mouseout type, java.util.function.Function<MouseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.mouseover type, java.util.function.Function<MouseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.mouseup type, java.util.function.Function<MouseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointercancel type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerdown type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerenter type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerleave type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointermove type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerout type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerover type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerup type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.resize type, java.util.function.Function<UIEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.scroll type, java.util.function.Function<UIEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.touchcancel type, java.util.function.Function<TouchEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.touchend type, java.util.function.Function<TouchEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.touchmove type, java.util.function.Function<TouchEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.touchstart type, java.util.function.Function<TouchEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.webkitfullscreenchange type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.webkitfullscreenerror type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.wheel type, java.util.function.Function<WheelEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGSVGElement prototype;
    public SVGSVGElement(){}
    native public AnimationEvent createEvent(jsweet.util.StringTypes.AnimationEvent eventInterface);
    native public AriaRequestEvent createEvent(jsweet.util.StringTypes.AriaRequestEvent eventInterface);
    native public AudioProcessingEvent createEvent(jsweet.util.StringTypes.AudioProcessingEvent eventInterface);
    native public BeforeUnloadEvent createEvent(jsweet.util.StringTypes.BeforeUnloadEvent eventInterface);
    native public ClipboardEvent createEvent(jsweet.util.StringTypes.ClipboardEvent eventInterface);
    native public CloseEvent createEvent(jsweet.util.StringTypes.CloseEvent eventInterface);
    native public CommandEvent createEvent(jsweet.util.StringTypes.CommandEvent eventInterface);
    native public CompositionEvent createEvent(jsweet.util.StringTypes.CompositionEvent eventInterface);
    native public CustomEvent createEvent(jsweet.util.StringTypes.CustomEvent eventInterface);
    native public DeviceMotionEvent createEvent(jsweet.util.StringTypes.DeviceMotionEvent eventInterface);
    native public DeviceOrientationEvent createEvent(jsweet.util.StringTypes.DeviceOrientationEvent eventInterface);
    native public DragEvent createEvent(jsweet.util.StringTypes.DragEvent eventInterface);
    native public ErrorEvent createEvent(jsweet.util.StringTypes.ErrorEvent eventInterface);
    native public Event createEvent(jsweet.util.StringTypes.Event eventInterface);
    native public Event createEvent(jsweet.util.StringTypes.Events eventInterface);
    native public FocusEvent createEvent(jsweet.util.StringTypes.FocusEvent eventInterface);
    native public GamepadEvent createEvent(jsweet.util.StringTypes.GamepadEvent eventInterface);
    native public HashChangeEvent createEvent(jsweet.util.StringTypes.HashChangeEvent eventInterface);
    native public IDBVersionChangeEvent createEvent(jsweet.util.StringTypes.IDBVersionChangeEvent eventInterface);
    native public KeyboardEvent createEvent(jsweet.util.StringTypes.KeyboardEvent eventInterface);
    native public LongRunningScriptDetectedEvent createEvent(jsweet.util.StringTypes.LongRunningScriptDetectedEvent eventInterface);
    native public MSGestureEvent createEvent(jsweet.util.StringTypes.MSGestureEvent eventInterface);
    native public MSManipulationEvent createEvent(jsweet.util.StringTypes.MSManipulationEvent eventInterface);
    native public MSMediaKeyMessageEvent createEvent(jsweet.util.StringTypes.MSMediaKeyMessageEvent eventInterface);
    native public MSMediaKeyNeededEvent createEvent(jsweet.util.StringTypes.MSMediaKeyNeededEvent eventInterface);
    native public MSPointerEvent createEvent(jsweet.util.StringTypes.MSPointerEvent eventInterface);
    native public MSSiteModeEvent createEvent(jsweet.util.StringTypes.MSSiteModeEvent eventInterface);
    native public MessageEvent createEvent(jsweet.util.StringTypes.MessageEvent eventInterface);
    native public MouseEvent createEvent(jsweet.util.StringTypes.MouseEvent eventInterface);
    native public MouseEvent createEvent(jsweet.util.StringTypes.MouseEvents eventInterface);
    native public MouseWheelEvent createEvent(jsweet.util.StringTypes.MouseWheelEvent eventInterface);
    native public MutationEvent createEvent(jsweet.util.StringTypes.MutationEvent eventInterface);
    native public MutationEvent createEvent(jsweet.util.StringTypes.MutationEvents eventInterface);
    native public NavigationCompletedEvent createEvent(jsweet.util.StringTypes.NavigationCompletedEvent eventInterface);
    native public NavigationEvent createEvent(jsweet.util.StringTypes.NavigationEvent eventInterface);
    native public NavigationEventWithReferrer createEvent(jsweet.util.StringTypes.NavigationEventWithReferrer eventInterface);
    native public OfflineAudioCompletionEvent createEvent(jsweet.util.StringTypes.OfflineAudioCompletionEvent eventInterface);
    native public PageTransitionEvent createEvent(jsweet.util.StringTypes.PageTransitionEvent eventInterface);
    native public PermissionRequestedEvent createEvent(jsweet.util.StringTypes.PermissionRequestedEvent eventInterface);
    native public PointerEvent createEvent(jsweet.util.StringTypes.PointerEvent eventInterface);
    native public PopStateEvent createEvent(jsweet.util.StringTypes.PopStateEvent eventInterface);
    native public ProgressEvent createEvent(jsweet.util.StringTypes.ProgressEvent eventInterface);
    native public SVGZoomEvent createEvent(jsweet.util.StringTypes.SVGZoomEvent eventInterface);
    native public SVGZoomEvent createEvent(jsweet.util.StringTypes.SVGZoomEvents eventInterface);
    native public ScriptNotifyEvent createEvent(jsweet.util.StringTypes.ScriptNotifyEvent eventInterface);
    native public StorageEvent createEvent(jsweet.util.StringTypes.StorageEvent eventInterface);
    native public TextEvent createEvent(jsweet.util.StringTypes.TextEvent eventInterface);
    native public TouchEvent createEvent(jsweet.util.StringTypes.TouchEvent eventInterface);
    native public TrackEvent createEvent(jsweet.util.StringTypes.TrackEvent eventInterface);
    native public TransitionEvent createEvent(jsweet.util.StringTypes.TransitionEvent eventInterface);
    native public UIEvent createEvent(jsweet.util.StringTypes.UIEvent eventInterface);
    native public UIEvent createEvent(jsweet.util.StringTypes.UIEvents eventInterface);
    native public UnviewableContentIdentifiedEvent createEvent(jsweet.util.StringTypes.UnviewableContentIdentifiedEvent eventInterface);
    native public WebGLContextEvent createEvent(jsweet.util.StringTypes.WebGLContextEvent eventInterface);
    native public WheelEvent createEvent(jsweet.util.StringTypes.WheelEvent eventInterface);
    native public Event createEvent(String eventInterface);
    public SVGElement farthestViewportElement;
    public SVGElement nearestViewportElement;
    native public SVGRect getBBox();
    native public SVGMatrix getCTM();
    native public SVGMatrix getScreenCTM();
    native public SVGMatrix getTransformToElement(SVGElement element);
    public SVGStringList requiredExtensions;
    public SVGStringList requiredFeatures;
    public SVGStringList systemLanguage;
    native public Boolean hasExtension(String extension);
    public Object className;
    public CSSStyleDeclaration style;
    public String xmllang;
    public String xmlspace;
    public SVGAnimatedBoolean externalResourcesRequired;
    public SVGAnimatedPreserveAspectRatio preserveAspectRatio;
    public SVGAnimatedRect viewBox;
    public double zoomAndPan;
    public static double SVG_ZOOMANDPAN_DISABLE;
    public static double SVG_ZOOMANDPAN_MAGNIFY;
    public static double SVG_ZOOMANDPAN_UNKNOWN;
    native public CSSStyleDeclaration getComputedStyle(Element elt);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureChange type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureDoubleTap type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureEnd type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureHold type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureStart type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureTap type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGotPointerCapture type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSInertiaStart type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSLostPointerCapture type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerCancel type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerDown type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerEnter type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerLeave type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerMove type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerOut type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerOver type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerUp type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.SVGAbort type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.SVGError type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.SVGUnload type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.SVGZoom type, java.util.function.Function<SVGZoomEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.ariarequest type, java.util.function.Function<AriaRequestEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.click type, java.util.function.Function<MouseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.command type, java.util.function.Function<CommandEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.dblclick type, java.util.function.Function<MouseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.focusin type, java.util.function.Function<FocusEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.focusout type, java.util.function.Function<FocusEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.gotpointercapture type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.load type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.lostpointercapture type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.mousedown type, java.util.function.Function<MouseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.mousemove type, java.util.function.Function<MouseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.mouseout type, java.util.function.Function<MouseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.mouseover type, java.util.function.Function<MouseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.mouseup type, java.util.function.Function<MouseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointercancel type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerdown type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerenter type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerleave type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointermove type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerout type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerover type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerup type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.resize type, java.util.function.Function<UIEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.scroll type, java.util.function.Function<UIEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.touchcancel type, java.util.function.Function<TouchEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.touchend type, java.util.function.Function<TouchEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.touchmove type, java.util.function.Function<TouchEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.touchstart type, java.util.function.Function<TouchEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.webkitfullscreenchange type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.webkitfullscreenerror type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.wheel type, java.util.function.Function<WheelEvent,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

