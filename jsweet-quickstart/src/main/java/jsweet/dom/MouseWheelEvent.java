package jsweet.dom;
/** <div> <p><strong>Non-standard</strong><br></br> This feature is non-standard and is not on a standards track. Do not use it on production sites facing the Web: it will not work for every user. There may also be large incompatibilities between implementations and the behavior may change in the future.</p> </div><div> <p><strong>Deprecated</strong><br></br>This feature has been removed from the Web standards. Though some browsers may still support it, it is in the process of being dropped. Do not use it in old or new projects. Pages or Web apps using it may break at any time.</p> </div> <p>The <strong><code>MouseWheelEvent</code></strong> interface represents events that occur due to the user turning a mouse wheel.</p> <div> <p><strong>Do not use this interface for wheel events.</strong></p> <p>Like <code>MouseScrollEvent</code>, this interface is non-standard and deprecated. It was used in non-Gecko browsers only. Instead use the standard <em><code>WheelEvent</code>.</em></p> </div>  */
public class MouseWheelEvent extends MouseEvent {
    /** 
The distance in pixels (defined as so by MSDN, but the actual usage is different, see <code>mousewheel</code>). <strong>Read only.</strong> */
    public double wheelDelta;
    /** 
The value along horizontal axis of <code>wheelDelta</code>. <strong>Read only.</strong> */
    public double wheelDeltaX;
    /** 
The value along vertical axis of <code>wheelDelta</code>. <strong>Read only.</strong> */
    public double wheelDeltaY;
    native public void initMouseWheelEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, Window viewArg, double detailArg, double screenXArg, double screenYArg, double clientXArg, double clientYArg, double buttonArg, EventTarget relatedTargetArg, String modifiersListArg, double wheelDeltaArg);
    public static MouseWheelEvent prototype;
    public MouseWheelEvent(){}
}

