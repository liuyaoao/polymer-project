package jsweet.dom;
/**  <p>The <strong><code>Worker</code></strong> interface of the Web Workers API represents a background task that can be easily created and can send messages back to its creator. Creating a worker is as simple as calling the <code>Worker()</code>&nbsp;constructor and specifying a script to be run in the worker thread.</p> <p>Workers may in turn spawn new workers as long as those workers are hosted within the same origin as the parent page (Note: nested workers are currently not implemented in Blink).&nbsp; In addition workers may use <code>XMLHttpRequest</code> for network I/O, with the stipulation that the <code>responseXML</code> and <code>channel</code> attributes on <code>XMLHttpRequest</code> always return <code>null</code>.</p> <p>Not all interfaces and functions are available to the script associated with a <code>Worker</code>.</p> <p>In Firefox, if you want to use workers in extensions and would like to have access to js-ctypes, you should use the <code>ChromeWorker</code> object instead.</p>  */
@jsweet.lang.Extends({AbstractWorker.class})
public class Worker extends EventTarget {
    /** 
 An <code>EventListener</code> called whenever a <code>MessageEvent</code> of type <code>message</code> bubbles through the worker — i.e. when a message is sent to the parent document from the worker via <code>DedicatedWorkerGlobalScope.postMessage</code>. The message is stored in the event's <code>data</code> property.  */
    public java.util.function.Function<MessageEvent,Object> onmessage;
    /** 
 Sends a message — which can consist of <code>any</code> JavaScript object — to the worker's inner scope.  */
    native public void postMessage(Object message, Object ports);
    /** 
 Immediately terminates the worker. This does not offer the worker an opportunity to finish its operations; it is simply stopped at once. ServiceWorker instances do not support this method.  */
    native public void terminate();
    native public void addEventListener(jsweet.util.StringTypes.message type, java.util.function.Function<MessageEvent,Object> listener, Boolean useCapture);
    public static Worker prototype;
    public Worker(String stringUrl){}
    public java.util.function.Function<Event,Object> onerror;
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    /** 
 Sends a message — which can consist of <code>any</code> JavaScript object — to the worker's inner scope.  */
    native public void postMessage(Object message);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.message type, java.util.function.Function<MessageEvent,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
    protected Worker(){}
}

