package jsweet.dom;
/**  <p><code>EventTarget</code> is an interface implemented by objects that can receive events and may have listeners for them.</p> <p><code>Element</code>, <code>document</code>, and <code>window</code> are the most common event targets, but other objects can be event targets too, for example <code>XMLHttpRequest</code>, <code>AudioNode</code>, <code>AudioContext</code>, and others.</p> <p>Many event targets (including elements, documents, and windows) also support setting event handlers via <code>on...</code> properties and attributes.</p>  */
public class EventTarget extends jsweet.lang.Object {
    /** 
 Register an event handler of a specific event type on the <code>EventTarget</code>.  */
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    /** 
 Dispatch an event to this <code>EventTarget</code>.  */
    native public Boolean dispatchEvent(Event evt);
    /** 
 Removes an event listener from the <code>EventTarget</code>.  */
    native public void removeEventListener(String type, EventListener listener, Boolean useCapture);
    public static EventTarget prototype;
    public EventTarget(){}
    /** 
 Register an event handler of a specific event type on the <code>EventTarget</code>.  */
    native public void addEventListener(String type, EventListener listener);
    /** 
 Removes an event listener from the <code>EventTarget</code>.  */
    native public void removeEventListener(String type, EventListener listener);
    /** 
 Register an event handler of a specific event type on the <code>EventTarget</code>.  */
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    /** 
 Removes an event listener from the <code>EventTarget</code>.  */
    native public void removeEventListener(String type, EventListenerObject listener, Boolean useCapture);
    /** 
 Register an event handler of a specific event type on the <code>EventTarget</code>.  */
    native public void addEventListener(String type, EventListenerObject listener);
    /** 
 Removes an event listener from the <code>EventTarget</code>.  */
    native public void removeEventListener(String type, EventListenerObject listener);
}

