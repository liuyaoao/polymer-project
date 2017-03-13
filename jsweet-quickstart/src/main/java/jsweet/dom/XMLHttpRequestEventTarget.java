package jsweet.dom;
/**  <p><code>XMLHttpRequestEventTarget</code> is the interface that describes the event handlers you can implement in an object that will handle events for an <code>XMLHttpRequest</code>.</p>  */
@jsweet.lang.Interface
public abstract class XMLHttpRequestEventTarget extends jsweet.lang.Object {
    /** 
 The function to call when a request is aborted.  */
    public java.util.function.Function<Event,Object> onabort;
    /** 
 The function to call when a request encounters an error.  */
    public java.util.function.Function<Event,Object> onerror;
    /** 
 The function to call when an HTTP request returns after successfully loading content.  */
    public java.util.function.Function<Event,Object> onload;
    /** 
 A function that is called when the load is completed, even if the request failed.  */
    public java.util.function.Function<ProgressEvent,Object> onloadend;
    /** 
 A function that gets called when the HTTP request first begins loading data.  */
    public java.util.function.Function<Event,Object> onloadstart;
    /** 
 A function that is called periodically with information about the progress of the request.  */
    public java.util.function.Function<ProgressEvent,Object> onprogress;
    /** 
 A function that is called if the event times out; this only happens if a timeout has been previously established by setting the value of the <code>XMLHttpRequest</code> object's <code>timeout</code> attribute.  */
    public java.util.function.Function<ProgressEvent,Object> ontimeout;
    native public void addEventListener(jsweet.util.StringTypes.abort type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.load type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.loadend type, java.util.function.Function<ProgressEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.loadstart type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.progress type, java.util.function.Function<ProgressEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.timeout type, java.util.function.Function<ProgressEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.abort type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.load type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.loadend type, java.util.function.Function<ProgressEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.loadstart type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.progress type, java.util.function.Function<ProgressEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.timeout type, java.util.function.Function<ProgressEvent,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

