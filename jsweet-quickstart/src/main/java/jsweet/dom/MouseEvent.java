package jsweet.dom;
/**  <p>The <code><strong>MouseEvent</strong></code> interface represents events that occur due to the user interacting with a pointing device (such as a mouse). Common events using this interface include <code>click</code>, <code>dblclick</code>, <code>mouseup</code>, <code>mousedown</code>.</p> <p><code>MouseEvent</code> derives from <code>UIEvent</code>, which in turn derives from <code>Event</code>. Though the <code>MouseEvent.initMouseEvent()</code> method is kept for backward compatibility, creating of a <code>MouseEvent</code> object should be done using the <code>MouseEvent()</code> constructor.</p> <p>Several more specific events derivate from <code>MouseEvent</code>: <code>WheelEvent</code> and <code>DragEvent</code>.</p>  */
public class MouseEvent extends UIEvent {
    /** 
 Returns <code>true</code> if the <kbd>alt</kbd> key was down when the mouse event was fired.  */
    public Boolean altKey;
    /** 
 The button number that was pressed when the mouse event was fired.&nbsp;  */
    public double button;
    /** <p>The buttons being pressed when the mouse event was fired</p>  */
    public double buttons;
    /** 
 The X coordinate of the mouse pointer in local (DOM content)&nbsp;coordinates.  */
    public double clientX;
    /** 
 The Y coordinate of the mouse pointer in local (DOM content)&nbsp;coordinates.  */
    public double clientY;
    /** 
 Returns <code>true</code> if the <kbd>control</kbd> key was down when the mouse event was fired.  */
    public Boolean ctrlKey;
    public Element fromElement;
    public double layerX;
    public double layerY;
    /** 
 Returns <code>true</code> if the <kbd>meta</kbd> key was down when the mouse event was fired.  */
    public Boolean metaKey;
    /** 
 The X coordinate of the mouse pointer relative to the position of the last <code>mousemove</code> event.  */
    public double movementX;
    /** 
 The Y coordinate of the mouse pointer relative to the position of the last <code>mousemove</code> event.  */
    public double movementY;
    /** 
 The X coordinate of the mouse pointer relative to the position of the padding edge of the target node.  */
    public double offsetX;
    /** 
 The Y coordinate of the mouse pointer relative to the position of the padding edge of the target node.  */
    public double offsetY;
    /** 
 The X coordinate of the mouse pointer relative to the whole document.  */
    public double pageX;
    /** 
 The Y coordinate of the mouse pointer relative to the whole document.  */
    public double pageY;
    /** <p>The secondary target for the event, if there is one.</p>  */
    public EventTarget relatedTarget;
    /** 
 The X coordinate of the mouse pointer in global (screen)&nbsp;coordinates.  */
    public double screenX;
    /** 
 The Y coordinate of the mouse pointer in global (screen)&nbsp;coordinates.  */
    public double screenY;
    /** 
 Returns <code>true</code> if the <kbd>shift</kbd> key was down when the mouse event was fired.  */
    public Boolean shiftKey;
    public Element toElement;
    /** 
 The button being pressed when the mouse event was fired.  */
    public double which;
    /** 
 Alias for <code>MouseEvent.clientX</code>.  */
    public double x;
    /** 
 Alias for <code>MouseEvent.clientY</code>  */
    public double y;
    /** 
 Returns the current state of the specified modifier key. See the <code>KeyboardEvent.getModifierState</code>() for details.  */
    native public Boolean getModifierState(String keyArg);
    /** 
 Initializes the value of a <code>MouseEvent</code> created. If the event has already being dispatched, this method does nothing.  */
    native public void initMouseEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, Window viewArg, double detailArg, double screenXArg, double screenYArg, double clientXArg, double clientYArg, Boolean ctrlKeyArg, Boolean altKeyArg, Boolean shiftKeyArg, Boolean metaKeyArg, double buttonArg, EventTarget relatedTargetArg);
    public static MouseEvent prototype;
    public MouseEvent(String typeArg, MouseEventInit eventInitDict){}
    public MouseEvent(String typeArg){}
    protected MouseEvent(){}
}

