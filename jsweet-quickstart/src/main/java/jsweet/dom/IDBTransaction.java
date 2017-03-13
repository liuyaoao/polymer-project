package jsweet.dom;
/**  <div> <p>The <strong><code>IDBTransaction</code></strong> interface of the IndexedDB API provides a static, asynchronous transaction on a database using event handler attributes. All reading and writing of data is done within transactions. You actually use <code>IDBDatabase</code> to start transactions and <code>IDBTransaction</code> to set the mode of the transaction (e.g. is it readonly or readwrite), and access an <code>IDBObjectStore</code> to make a request. You can also use it to abort transactions.</p> <p>Note that as of Firefox 40, IndexedDB transactions have relaxed durability guarantees to increase performance (see bug&nbsp;1112702.) Previously in a <code>readwrite</code> transaction <code>IDBTransaction.oncomplete</code> was fired only when all data was guaranteed to have been flushed to disk. In Firefox 40+ the <code>complete</code> event is fired after the OS has been told to write the data but potentially before that data has actually been flushed to disk. The <code>complete</code> event may thus be delivered quicker than before, however, there exists a small chance that the entire transaction will be lost if the OS crashes or there is a loss of system power before the data is flushed to disk. Since such catastrophic events are rare most consumers should not need to concern themselves further.</p> <p>If you must ensure durability for some reason (e.g. you're storing critical data that cannot be recomputed later) you can force a transaction to flush to disk before delivering the <code>complete</code> event by creating a transaction using the experimental (non-standard) <code>readwriteflush</code> mode (see <code>IDBDatabase.transaction</code>.</p>  <div> <strong>Note:</strong>&nbsp;This feature is available in Web Workers. </div>  </div>  */
public class IDBTransaction extends EventTarget {
    /** 
 The database connection with which this transaction is associated.  */
    public IDBDatabase db;
    /** 
 The error returned in the event of an unsuccessful transaction. Null if the transaction is not finished, is finished and successfully committed, or was aborted with <code>IDBTransaction.abort</code> function. Returns the same DOMError as the request object which caused the transaction to be aborted due to a failed request, or a DOMError for the transaction failure not due to a failed request (such as <code>QuotaExceededError</code> or <code>UnknownError</code>).  */
    public DOMError error;
    /** 
 The mode for isolating access to data in the object stores that are in the scope of the transaction. For possible values, see the Constants section below. The default value is <code>readonly</code>.  */
    public String mode;
    /** 
 The event handler for the <code>abort</code> event, fired when the transaction is aborted.  */
    public java.util.function.Function<Event,Object> onabort;
    /** 
 The event handler for the <code>complete</code> event, thrown when the transaction completes successfully.  */
    public java.util.function.Function<Event,Object> oncomplete;
    /** 
 The event handler for the <code>error</code> event, thrown when the transaction fails to complete.  */
    public java.util.function.Function<Event,Object> onerror;
    native public void abort();
    native public IDBObjectStore objectStore(String name);
    /** <p>Allows data to be read but not changed.</p>  */
    public String READ_ONLY;
    /** 
Allows reading and writing of data in existing data stores to be changed. */
    public String READ_WRITE;
    /** 
Allows any operation to be performed, including ones that delete and create object stores and indexes. This mode is for updating the version number of transactions that were started using the <code>setVersion()</code> method of IDBDatabase objects. Transactions of this mode cannot run concurrently with other transactions. */
    public String VERSION_CHANGE;
    native public void addEventListener(jsweet.util.StringTypes.abort type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.complete type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static IDBTransaction prototype;
    public IDBTransaction(){}
    native public void addEventListener(jsweet.util.StringTypes.abort type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.complete type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

