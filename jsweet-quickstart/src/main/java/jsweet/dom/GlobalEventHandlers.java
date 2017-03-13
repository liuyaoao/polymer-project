package jsweet.dom;
/** <p>The <strong><code>GlobalEventHandlers</code></strong> mixin describes the event handlers common to several interfaces like <code>HTMLElement</code>, <code>Document</code>, or <code>Window</code>. Each of these interfaces can implement more event handlers.</p> <p><code>GlobalEventHandlers</code> is a mixin and not an interface and no object of this type can be created.</p>  */
@jsweet.lang.Interface
public abstract class GlobalEventHandlers extends jsweet.lang.Object {
    /** 
 Is an <code>EventHandler</code> representing the code to be called when the <code>pointercancel</code> event is raised.  */
    public java.util.function.Function<PointerEvent,Object> onpointercancel;
    /** 
 Is an <code>EventHandler</code> representing the code to be called when the <code>pointerdown</code> event is raised.  */
    public java.util.function.Function<PointerEvent,Object> onpointerdown;
    /** 
 Is an <code>EventHandler</code> representing the code to be called when the <code>pointerevent</code> event is raised.  */
    public java.util.function.Function<PointerEvent,Object> onpointerenter;
    /** 
 Is an <code>EventHandler</code> representing the code to be called when the <code>pointerleave</code> event is raised.  */
    public java.util.function.Function<PointerEvent,Object> onpointerleave;
    /** 
 Is an <code>EventHandler</code> representing the code to be called when the <code>pointermove</code> event is raised.  */
    public java.util.function.Function<PointerEvent,Object> onpointermove;
    /** 
 Is an <code>EventHandler</code> representing the code to be called when the <code>pointerout</code> event is raised.  */
    public java.util.function.Function<PointerEvent,Object> onpointerout;
    /** 
 Is an <code>EventHandler</code> representing the code to be called when the <code>pointerover</code> event is raised.  */
    public java.util.function.Function<PointerEvent,Object> onpointerover;
    /** 
 Is an <code>EventHandler</code> representing the code to be called when the <code>pointerup</code> event is raised.  */
    public java.util.function.Function<PointerEvent,Object> onpointerup;
    public java.util.function.Function<WheelEvent,Object> onwheel;
    native public void addEventListener(jsweet.util.StringTypes.pointercancel type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerdown type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerenter type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerleave type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointermove type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerout type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerover type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerup type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.wheel type, java.util.function.Function<WheelEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointercancel type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerdown type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerenter type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerleave type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointermove type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerout type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerover type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerup type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.wheel type, java.util.function.Function<WheelEvent,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

