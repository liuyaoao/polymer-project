package jsweet.dom;
/**  <p>The <strong><code>AbstractWorker</code></strong> interface of the Web Workers API abstracts properties and methods common to all kind of workers, being <code>Worker</code> or <code>SharedWorker</code>.</p>  */
@jsweet.lang.Interface
public abstract class AbstractWorker extends jsweet.lang.Object {
    /** 
 Is an <code>EventListener</code> that is called whenever an <code>ErrorEvent</code> of type <code>error</code> bubbles through the worker.  */
    public java.util.function.Function<Event,Object> onerror;
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

