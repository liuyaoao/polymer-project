package jsweet.dom;
/** <div> <p><span><i> </i></span> <strong>This is an experimental technology</strong><br></br>Because this technology's specification has not stabilized, check the compatibility table for the proper prefixes to use in various browsers. Also note that the syntax and behavior of an experimental technology is subject to change in future versions of browsers as the spec changes.</p> </div> <p>The <strong><code>FocusEvent</code></strong> interface represents focus-related events like <code>focus</code>, <code>blur</code>, <code>focusin</code>, or <code>focusout</code>.</p>  */
public class FocusEvent extends UIEvent {
    /** 
 Is an <code>EventTarget</code> representing a secondary target for this event. As in some cases (like when tabbing in or out a page), this property may be set to <code>null</code> for security reasons.  */
    public EventTarget relatedTarget;
    native public void initFocusEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, Window viewArg, double detailArg, EventTarget relatedTargetArg);
    public static FocusEvent prototype;
    public FocusEvent(String typeArg, FocusEventInit eventInitDict){}
    public FocusEvent(String typeArg){}
    protected FocusEvent(){}
}

