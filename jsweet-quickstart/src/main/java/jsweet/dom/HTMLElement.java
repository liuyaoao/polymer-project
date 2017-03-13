package jsweet.dom;
/** <div>
 &nbsp; </div> <p>The <strong><code>HTMLElement</code></strong> interface represents any HTML element. Some elements directly implement this interface, others implement it via an interface that inherits it.</p>  */
public class HTMLElement extends Element {
    /** 
 Is a <code>DOMString</code> representing the access key assigned to the element.  */
    public String accessKey;
    public HTMLCollection children;
    /** 
 Is a <code>DOMString</code>, where a value of <code>&quot;true&quot;</code> means the element is editable and a value of <code>&quot;false&quot;</code> means it isn't.  */
    public String contentEditable;
    /** 
 Returns a <code>DOMStringMap</code> that allows access to read and write the element custom data attributes ( <code>data-*</code>) .  */
    public DOMStringMap dataset;
    /** 
 Is a <code>DOMString</code>, reflecting the <code>dir</code> global attribute, representing the directionality of the element. Possible values are <code>&quot;ltr&quot;</code>, <code>&quot;rtl&quot;</code>, and <code>&quot;auto&quot;</code>.  */
    public String dir;
    /** 
 Is a <code>Boolean</code> indicating if the element can be dragged.  */
    public Boolean draggable;
    /** 
 Is a <code>Boolean</code> indicating if the element is hidden or not.  */
    public Boolean hidden;
    public Boolean hideFocus;
    public String innerHTML;
    public String innerText;
    /** 
 Returns a <code>Boolean</code> that indicates whether or not the content of the element can be edited.  */
    public Boolean isContentEditable;
    /** 
 Is a <code>DOMString</code> representing the language of an element's attributes, text, and element contents.  */
    public String lang;
    /** 
 Returns a <code>double</code> containing the height of an element, relative to the layout.  */
    public double offsetHeight;
    /** 
 Returns a <code>double</code>, the distance from this element's left border to its <code>offsetParent</code>'s left border.  */
    public double offsetLeft;
    /** 
 Returns an <code>Element</code> that is the element from which all offset calculations are currently computed.  */
    public Element offsetParent;
    /** 
 Returns a <code>double</code>, the distance from this element's top border to its <code>offsetParent</code>'s top border.  */
    public double offsetTop;
    /** 
 Returns a <code>double</code> containing the width of an element, relative to the layout.  */
    public double offsetWidth;
    public java.util.function.Function<Event,Object> onabort;
    public java.util.function.Function<UIEvent,Object> onactivate;
    public java.util.function.Function<UIEvent,Object> onbeforeactivate;
    public java.util.function.Function<DragEvent,Object> onbeforecopy;
    public java.util.function.Function<DragEvent,Object> onbeforecut;
    public java.util.function.Function<UIEvent,Object> onbeforedeactivate;
    public java.util.function.Function<DragEvent,Object> onbeforepaste;
    public java.util.function.Function<FocusEvent,Object> onblur;
    public java.util.function.Function<Event,Object> oncanplay;
    public java.util.function.Function<Event,Object> oncanplaythrough;
    public java.util.function.Function<Event,Object> onchange;
    public java.util.function.Function<MouseEvent,Object> onclick;
    public java.util.function.Function<PointerEvent,Object> oncontextmenu;
    /** 
 Returns the event handling code for the <code>copy</code> event ( bug&nbsp;280959).  */
    public java.util.function.Function<DragEvent,Object> oncopy;
    public java.util.function.Function<Event,Object> oncuechange;
    /** 
 Returns the event handling code for the <code>cut</code> event ( bug&nbsp;280959).  */
    public java.util.function.Function<DragEvent,Object> oncut;
    public java.util.function.Function<MouseEvent,Object> ondblclick;
    public java.util.function.Function<UIEvent,Object> ondeactivate;
    public java.util.function.Function<DragEvent,Object> ondrag;
    public java.util.function.Function<DragEvent,Object> ondragend;
    public java.util.function.Function<DragEvent,Object> ondragenter;
    public java.util.function.Function<DragEvent,Object> ondragleave;
    public java.util.function.Function<DragEvent,Object> ondragover;
    public java.util.function.Function<DragEvent,Object> ondragstart;
    public java.util.function.Function<DragEvent,Object> ondrop;
    public java.util.function.Function<Event,Object> ondurationchange;
    public java.util.function.Function<Event,Object> onemptied;
    public java.util.function.Function<Event,Object> onended;
    public java.util.function.Function<Event,Object> onerror;
    public java.util.function.Function<FocusEvent,Object> onfocus;
    public java.util.function.Function<Event,Object> oninput;
    public java.util.function.Function<KeyboardEvent,Object> onkeydown;
    public java.util.function.Function<KeyboardEvent,Object> onkeypress;
    public java.util.function.Function<KeyboardEvent,Object> onkeyup;
    public java.util.function.Function<Event,Object> onload;
    public java.util.function.Function<Event,Object> onloadeddata;
    public java.util.function.Function<Event,Object> onloadedmetadata;
    public java.util.function.Function<Event,Object> onloadstart;
    public java.util.function.Function<MouseEvent,Object> onmousedown;
    public java.util.function.Function<MouseEvent,Object> onmouseenter;
    public java.util.function.Function<MouseEvent,Object> onmouseleave;
    public java.util.function.Function<MouseEvent,Object> onmousemove;
    public java.util.function.Function<MouseEvent,Object> onmouseout;
    public java.util.function.Function<MouseEvent,Object> onmouseover;
    public java.util.function.Function<MouseEvent,Object> onmouseup;
    public java.util.function.Function<MouseWheelEvent,Object> onmousewheel;
    public java.util.function.Function<UIEvent,Object> onmscontentzoom;
    public java.util.function.Function<MSManipulationEvent,Object> onmsmanipulationstatechanged;
    /** 
 Returns the event handling code for the <code>paste</code> event ( bug&nbsp;280959).  */
    public java.util.function.Function<DragEvent,Object> onpaste;
    public java.util.function.Function<Event,Object> onpause;
    public java.util.function.Function<Event,Object> onplay;
    public java.util.function.Function<Event,Object> onplaying;
    public java.util.function.Function<ProgressEvent,Object> onprogress;
    public java.util.function.Function<Event,Object> onratechange;
    public java.util.function.Function<Event,Object> onreset;
    public java.util.function.Function<UIEvent,Object> onscroll;
    public java.util.function.Function<Event,Object> onseeked;
    public java.util.function.Function<Event,Object> onseeking;
    public java.util.function.Function<UIEvent,Object> onselect;
    public java.util.function.Function<Event,Object> onselectstart;
    public java.util.function.Function<Event,Object> onstalled;
    public java.util.function.Function<Event,Object> onsubmit;
    public java.util.function.Function<Event,Object> onsuspend;
    public java.util.function.Function<Event,Object> ontimeupdate;
    public java.util.function.Function<Event,Object> onvolumechange;
    public java.util.function.Function<Event,Object> onwaiting;
    public String outerHTML;
    public String outerText;
    /** 
 Is a <code>Boolean</code> that controls spell-checking. It is present on all HTML&nbsp;elements, though it hasn't an effect on all of them.  */
    public Boolean spellcheck;
    /** 
 Is <code>CSSStyleDeclaration</code>, an object representing the declarations of an element's style attributes.  */
    public CSSStyleDeclaration style;
    /** 
 Is a <code>long</code> representing the position of the element in the tabbing order.  */
    public double tabIndex;
    /** 
 Is a <code>DOMString</code> containing the text that appears in a popup box when mouse is over the element.  */
    public String title;
    /** 
 Removes keyboard focus from the currently focused element.  */
    native public void blur();
    /** 
 Sends a mouse click event to the element.  */
    native public void click();
    native public Boolean dragDrop();
    /** 
 Makes the element the current keyboard focus.  */
    native public void focus();
    native public Element insertAdjacentElement(String position, Element insertedElement);
    native public void insertAdjacentHTML(String where, String html);
    native public void insertAdjacentText(String where, String text);
    native public MSInputMethodContext msGetInputContext();
    native public void scrollIntoView(Boolean top);
    native public void setActive();
    native public void addEventListener(jsweet.util.StringTypes.MSContentZoom type, java.util.function.Function<UIEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureChange type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureDoubleTap type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureEnd type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureHold type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureStart type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureTap type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGotPointerCapture type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSInertiaStart type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSLostPointerCapture type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSManipulationStateChanged type, java.util.function.Function<MSManipulationEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerCancel type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerDown type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerEnter type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerLeave type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerMove type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerOut type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerOver type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerUp type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.abort type, java.util.function.Function<UIEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.activate type, java.util.function.Function<UIEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.ariarequest type, java.util.function.Function<AriaRequestEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.beforeactivate type, java.util.function.Function<UIEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.beforecopy type, java.util.function.Function<DragEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.beforecut type, java.util.function.Function<DragEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.beforedeactivate type, java.util.function.Function<UIEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.beforepaste type, java.util.function.Function<DragEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.blur type, java.util.function.Function<FocusEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.canplay type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.canplaythrough type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.change type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.click type, java.util.function.Function<MouseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.command type, java.util.function.Function<CommandEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.contextmenu type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.copy type, java.util.function.Function<DragEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.cuechange type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.cut type, java.util.function.Function<DragEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.dblclick type, java.util.function.Function<MouseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.deactivate type, java.util.function.Function<UIEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.drag type, java.util.function.Function<DragEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.dragend type, java.util.function.Function<DragEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.dragenter type, java.util.function.Function<DragEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.dragleave type, java.util.function.Function<DragEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.dragover type, java.util.function.Function<DragEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.dragstart type, java.util.function.Function<DragEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.drop type, java.util.function.Function<DragEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.durationchange type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.emptied type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.ended type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.focus type, java.util.function.Function<FocusEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.gotpointercapture type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.input type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.keydown type, java.util.function.Function<KeyboardEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.keypress type, java.util.function.Function<KeyboardEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.keyup type, java.util.function.Function<KeyboardEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.load type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.loadeddata type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.loadedmetadata type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.loadstart type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.lostpointercapture type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.mousedown type, java.util.function.Function<MouseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.mouseenter type, java.util.function.Function<MouseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.mouseleave type, java.util.function.Function<MouseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.mousemove type, java.util.function.Function<MouseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.mouseout type, java.util.function.Function<MouseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.mouseover type, java.util.function.Function<MouseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.mouseup type, java.util.function.Function<MouseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.mousewheel type, java.util.function.Function<MouseWheelEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.paste type, java.util.function.Function<DragEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pause type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.play type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.playing type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointercancel type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerdown type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerenter type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerleave type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointermove type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerout type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerover type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerup type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.progress type, java.util.function.Function<ProgressEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.ratechange type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.reset type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.scroll type, java.util.function.Function<UIEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.seeked type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.seeking type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.select type, java.util.function.Function<UIEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.selectstart type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.stalled type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.submit type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.suspend type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.timeupdate type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.touchcancel type, java.util.function.Function<TouchEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.touchend type, java.util.function.Function<TouchEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.touchmove type, java.util.function.Function<TouchEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.touchstart type, java.util.function.Function<TouchEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.volumechange type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.waiting type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.webkitfullscreenchange type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.webkitfullscreenerror type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.wheel type, java.util.function.Function<WheelEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static HTMLElement prototype;
    public HTMLElement(){}
    native public void scrollIntoView();
    native public void addEventListener(jsweet.util.StringTypes.MSContentZoom type, java.util.function.Function<UIEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureChange type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureDoubleTap type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureEnd type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureHold type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureStart type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureTap type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGotPointerCapture type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSInertiaStart type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSLostPointerCapture type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSManipulationStateChanged type, java.util.function.Function<MSManipulationEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerCancel type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerDown type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerEnter type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerLeave type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerMove type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerOut type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerOver type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerUp type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.abort type, java.util.function.Function<UIEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.activate type, java.util.function.Function<UIEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.ariarequest type, java.util.function.Function<AriaRequestEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.beforeactivate type, java.util.function.Function<UIEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.beforecopy type, java.util.function.Function<DragEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.beforecut type, java.util.function.Function<DragEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.beforedeactivate type, java.util.function.Function<UIEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.beforepaste type, java.util.function.Function<DragEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.blur type, java.util.function.Function<FocusEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.canplay type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.canplaythrough type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.change type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.click type, java.util.function.Function<MouseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.command type, java.util.function.Function<CommandEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.contextmenu type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.copy type, java.util.function.Function<DragEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.cuechange type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.cut type, java.util.function.Function<DragEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.dblclick type, java.util.function.Function<MouseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.deactivate type, java.util.function.Function<UIEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.drag type, java.util.function.Function<DragEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.dragend type, java.util.function.Function<DragEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.dragenter type, java.util.function.Function<DragEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.dragleave type, java.util.function.Function<DragEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.dragover type, java.util.function.Function<DragEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.dragstart type, java.util.function.Function<DragEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.drop type, java.util.function.Function<DragEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.durationchange type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.emptied type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.ended type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.focus type, java.util.function.Function<FocusEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.gotpointercapture type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.input type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.keydown type, java.util.function.Function<KeyboardEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.keypress type, java.util.function.Function<KeyboardEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.keyup type, java.util.function.Function<KeyboardEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.load type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.loadeddata type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.loadedmetadata type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.loadstart type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.lostpointercapture type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.mousedown type, java.util.function.Function<MouseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.mouseenter type, java.util.function.Function<MouseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.mouseleave type, java.util.function.Function<MouseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.mousemove type, java.util.function.Function<MouseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.mouseout type, java.util.function.Function<MouseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.mouseover type, java.util.function.Function<MouseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.mouseup type, java.util.function.Function<MouseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.mousewheel type, java.util.function.Function<MouseWheelEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.paste type, java.util.function.Function<DragEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pause type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.play type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.playing type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointercancel type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerdown type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerenter type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerleave type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointermove type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerout type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerover type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerup type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.progress type, java.util.function.Function<ProgressEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.ratechange type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.reset type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.scroll type, java.util.function.Function<UIEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.seeked type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.seeking type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.select type, java.util.function.Function<UIEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.selectstart type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.stalled type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.submit type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.suspend type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.timeupdate type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.touchcancel type, java.util.function.Function<TouchEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.touchend type, java.util.function.Function<TouchEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.touchmove type, java.util.function.Function<TouchEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.touchstart type, java.util.function.Function<TouchEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.volumechange type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.waiting type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.webkitfullscreenchange type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.webkitfullscreenerror type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.wheel type, java.util.function.Function<WheelEvent,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

