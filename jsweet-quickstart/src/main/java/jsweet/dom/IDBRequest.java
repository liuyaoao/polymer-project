package jsweet.dom;
import jsweet.util.union.Union3;
/**  <div> <p>The <strong><code>IDBRequest</code></strong> interface of the IndexedDB&nbsp;API provides access to results of asynchronous requests to databases and database objects using event handler attributes. Each reading and writing operation on a database is done using a request.</p> </div> <p>The request object does not initially contain any information about the result of the operation, but once information becomes available, an event is fired on the request, and the information becomes available through the properties of the <code>IDBRequest</code> instance.</p> <p>All asynchronous operations immediately return an <code>IDBRequest</code> instance. Each request has a <code>readyState</code> that is set to the <font><span>pending</span></font>&nbsp;state; this changes to <code>done</code> when the request is completed or fails. When the state is set to <code>done</code>, every request returns a&nbsp;<code>result</code>&nbsp;and an&nbsp;<code>error</code>, and an event is fired on the request. When the state is still <code>pending</code>, any attempt to access the <code>result</code> or <code>error</code>&nbsp;raises an <code>InvalidStateError</code>&nbsp;exception.</p> <div> <strong>Note:</strong>&nbsp;This feature is available in Web Workers. </div> <div> <p><strong>Note</strong>: In plain words, all asynchronous methods return a request object. If the request has been completed successfully, the result is made available through the <code>result</code> property and an event indicating success is fired at the request (<code>IDBRequest.onsuccess</code>). If an error occurs while performing the operation, the exception is made available through the <code>result</code> property and an error event is fired (<code>IDBRequest.onerror</code>).</p> </div> <div> <p><strong>Note</strong>: <code>IDBRequest</code> inherits from&nbsp;EventTarget;&nbsp;<span><code>IDBOpenDBRequest</code> is derived from it.</span></p> </div>  */
public class IDBRequest extends EventTarget {
    /** 
 Returns an error in the event of an unsuccessful request, indicating what went wrong.  */
    public DOMError error;
    /** 
 The event handler for the error event.  */
    public java.util.function.Function<Event,Object> onerror;
    /** 
 The event handler for the success event.  */
    public java.util.function.Function<Event,Object> onsuccess;
    /** 
 The state of the request. Every request starts in the <code>pending</code>&nbsp;state. The state changes to <code>done</code> when the request completes successfully or when an error occurs.  */
    public String readyState;
    /** <p>Returns the result of the request. If the the request failed and the result is not available, an&nbsp;<span>InvalidStateError</span>&nbsp;exception is thrown.</p>  */
    public Object result;
    /** 
 The source of the request, such as an <code>IDBIndex</code> or an <code>IDBObjectStore</code>. If no source exists (such as when calling <code>IDBFactory.open</code>), it returns null.  */
    public Union3<IDBObjectStore,IDBIndex,IDBCursor> source;
    /** 
 The transaction for the request. This property can be null for certain requests, for example those returned from <code>IDBFactory.open</code> (You're just connecting to a database, so there is no transaction to return).  */
    public IDBTransaction transaction;
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.success type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static IDBRequest prototype;
    public IDBRequest(){}
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.success type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

