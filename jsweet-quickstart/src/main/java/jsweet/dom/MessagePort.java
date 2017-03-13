package jsweet.dom;
/**  <p>The <strong><code>MessagePort</code></strong> interface of the Channel Messaging API represents one of the two ports of a <code>MessageChannel</code>, allowing sending of messages from one port and listening out for them arriving at the other.</p> <div> <p><strong>Note</strong>: This feature is available in Web Workers.</p> </div>  */
public class MessagePort extends EventTarget {
    /** 
 Is an <code>EventListener</code> that is called whenever an <code>MessageEvent</code> of type <code>message</code> is fired on the port — that is, when the port receives a message.  */
    public java.util.function.Function<MessageEvent,Object> onmessage;
    native public void close();
    native public void postMessage(Object message, Object ports);
    native public void start();
    native public void addEventListener(jsweet.util.StringTypes.message type, java.util.function.Function<MessageEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static MessagePort prototype;
    public MessagePort(){}
    native public void postMessage(Object message);
    native public void postMessage();
    native public void addEventListener(jsweet.util.StringTypes.message type, java.util.function.Function<MessageEvent,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

