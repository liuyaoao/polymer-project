package jsweet.dom;
/**  <p>The <strong><code>UIEvent</code></strong> interface represents simple user interface events.</p> <p><code>UIEvent</code> derives from <code>Event</code>. Although the <code>UIEvent.initUIEvent()</code> method is kept for backward compatibility, you should create a <code>UIEvent</code> object using the <code>UIEvent()</code> constructor.</p> <p>Several interfaces are direct or indirect descendants of this one: <code>MouseEvent</code>, <code>TouchEvent</code>,&nbsp;<code>FocusEvent</code>, <code>KeyboardEvent</code>, <code>WheelEvent</code>, <code>InputEvent</code>, and <code>CompositionEvent</code>.</p>  */
public class UIEvent extends Event {
    /** 
 Returns a <code>long</code> with details about the event, depending on the event type.  */
    public double detail;
    /** 
 Returns a <code>WindowProxy</code> that contains the view that generated the event.  */
    public Window view;
    /** 
 Initializes a <code>UIEvent</code> object. If the event has already being dispatched, this method does nothing.  */
    native public void initUIEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, Window viewArg, double detailArg);
    public static UIEvent prototype;
    public UIEvent(String type, UIEventInit eventInitDict){}
    public UIEvent(String type){}
    protected UIEvent(){}
}

