package jsweet.dom;
/**  <div> <p>The <strong><code>IDBOpenDBRequest</code></strong> interface of the IndexedDB&nbsp;API provides access to the results of requests to open or delete databases (performed using <code>IDBFactory.open</code> and <code>IDBFactory.deleteDatabase</code>), using specific event handler attributes.</p> </div> <p>Inherits from: <code>IDBRequest</code></p> <div> <strong>Note:</strong>&nbsp;This feature is available in Web Workers. </div>  */
public class IDBOpenDBRequest extends IDBRequest {
    /** 
 The event handler for the blocked event. This event is triggered when the <code>upgradeneeded</code> event should be triggered because of a version change but the database is still in use (i.e. not closed) somewhere, even after the <code>versionchange</code> event was sent.  */
    public java.util.function.Function<Event,Object> onblocked;
    /** 
 The event handler for the <code>upgradeneeded</code> event, fired when a database of a bigger version number than the existing stored database is loaded.  */
    public java.util.function.Function<IDBVersionChangeEvent,Object> onupgradeneeded;
    native public void addEventListener(jsweet.util.StringTypes.blocked type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.success type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.upgradeneeded type, java.util.function.Function<IDBVersionChangeEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static IDBOpenDBRequest prototype;
    public IDBOpenDBRequest(){}
    native public void addEventListener(jsweet.util.StringTypes.blocked type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.success type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.upgradeneeded type, java.util.function.Function<IDBVersionChangeEvent,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

