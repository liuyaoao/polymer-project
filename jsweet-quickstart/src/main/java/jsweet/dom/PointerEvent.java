package jsweet.dom;
/**  <p>A <em>pointer</em> is a hardware agnostic representation of input devices (such as a mouse, pen or contact point on a touch-enable surface). The pointer can target a specific coordinate (or set of coordinates) on the contact surface such as a screen.</p> <p>A pointer's <em>hit test</em> is the process a browser uses to determine the target element for a pointer event. Typically, this is determined by considering the pointer's location and also the visual layout of elements in a document on screen media.</p> <p>The <strong><code>PointerEvent</code></strong> interface represents the state of a DOM event produced by a pointer such as the geometry of the contact point, the device type that generated the event, the amount of pressure that was applied on the contact surface, etc.</p>  */
public class PointerEvent extends MouseEvent {
    public Object currentPoint;
    /** 
 The height (magnitude on the Y axis), in CSS pixels, of the contact geometry of the pointer.  */
    public double height;
    public double hwTimestamp;
    public Object intermediatePoints;
    /** 
 Indicates if the pointer represents the primary pointer of this pointer type.  */
    public Boolean isPrimary;
    /** 
 A unique identifier for the pointer causing the event.  */
    public double pointerId;
    /** 
 Indicates the device type that caused the event (mouse, pen, touch, etc.)  */
    public Object pointerType;
    /** 
 The normalized pressure of the pointer input in the range of 0 to 1, where 0 and 1 represent the minimum and maximum pressure the hardware is capable of detecting, respectively.  */
    public double pressure;
    public double rotation;
    /** 
 The plane angle (in degrees, in the range of -90 to 90) between the Y-Z plane and the plane containing both the transducer (e.g. pen stylus) axis and the Y axis.  */
    public double tiltX;
    /** 
 The plane angle (in degrees, in the range of -90 to 90) between the X-Z plane and the plane containing both the transducer (e.g. pen stylus) axis and the X axis.  */
    public double tiltY;
    /** 
 The width (magnitude on the X axis), in CSS pixels, of the contact geometry of the pointer.  */
    public double width;
    native public void getCurrentPoint(Element element);
    native public void getIntermediatePoints(Element element);
    native public void initPointerEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, Window viewArg, double detailArg, double screenXArg, double screenYArg, double clientXArg, double clientYArg, Boolean ctrlKeyArg, Boolean altKeyArg, Boolean shiftKeyArg, Boolean metaKeyArg, double buttonArg, EventTarget relatedTargetArg, double offsetXArg, double offsetYArg, double widthArg, double heightArg, double pressure, double rotation, double tiltX, double tiltY, double pointerIdArg, Object pointerType, double hwTimestampArg, Boolean isPrimary);
    public static PointerEvent prototype;
    public PointerEvent(String typeArg, PointerEventInit eventInitDict){}
    public PointerEvent(String typeArg){}
    protected PointerEvent(){}
}

