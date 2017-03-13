package jsweet.dom;
/**  <div> <p>The <strong><code>IDBDatabase</code></strong> interface of the IndexedDB API provides a connection to a database; you can use an <code>IDBDatabase</code> object to open a transaction on your database then create, manipulate, and delete objects (data) in that database. The interface provides the only way to get and manage versions of the database.</p>  <div> <strong>Note:</strong>&nbsp;This feature is available in Web Workers. </div>  </div> <div> <p><strong>Note</strong>: Everything you do in IndexedDB always happens in the context of a transaction, representing interactions with data in the database. All objects in IndexedDB — including object stores, indexes, and cursors — are tied to a particular transaction. Thus, you cannot execute commands, access data, or open anything outside of a transaction.</p> </div> <div> <p><strong>Note</strong>: Note that as of Firefox 40, IndexedDB transactions have relaxed durability guarantees to increase performance (see bug&nbsp;1112702.) Previously in a <code>readwrite</code> transaction <code>IDBTransaction.oncomplete</code> was fired only when all data was guaranteed to have been flushed to disk. In Firefox 40+ the <code>complete</code> event is fired after the OS has been told to write the data but potentially before that data has actually been flushed to disk. The <code>complete</code> event may thus be delivered quicker than before, however, there exists a small chance that the entire transaction will be lost if the OS crashes or there is a loss of system power before the data is flushed to disk. Since such catastrophic events are rare most consumers should not need to concern themselves further. If you must ensure durability for some reason (e.g. you're storing critical data that cannot be recomputed later) you can force a transaction to flush to disk before delivering the <code>complete</code> event by creating a transaction using the experimental (non-standard) <code>readwriteflush</code> mode (see <code>IDBDatabase.transaction</code>.</p> </div>  */
public class IDBDatabase extends EventTarget {
    /** 
 A <code>DOMString</code> that contains the name of the connected database.  */
    public String name;
    /** 
 A <code>DOMStringList</code> that contains a list of the names of the object stores currently in the connected database.  */
    public DOMStringList objectStoreNames;
    /** 
 Fires when access of the database is aborted.  */
    public java.util.function.Function<Event,Object> onabort;
    /** 
 Fires when access to the database fails.  */
    public java.util.function.Function<Event,Object> onerror;
    /** 
 A 64-bit integer that contains the version of the connected database. When a database is first created, this attribute is an empty string.  */
    public double version;
    /** 
 Returns immediately and closes the connection to a database in a separate thread.  */
    native public void close();
    /** 
 Creates and returns a new object store or index.  */
    native public IDBObjectStore createObjectStore(String name, IDBObjectStoreParameters optionalParameters);
    /** 
 Destroys the object store with the given name in the connected database, along with any indexes that reference it.  */
    native public void deleteObjectStore(String name);
    /** 
 Immediately returns a transaction object ( <code>IDBTransaction</code>) containing the <code>IDBTransaction.objectStore</code> method, which you can use to access your object store. Runs in a separate thread.  */
    native public IDBTransaction transaction(String storeNames, String mode);
    native public void addEventListener(jsweet.util.StringTypes.abort type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static IDBDatabase prototype;
    public IDBDatabase(){}
    /** 
 Creates and returns a new object store or index.  */
    native public IDBObjectStore createObjectStore(String name);
    /** 
 Immediately returns a transaction object ( <code>IDBTransaction</code>) containing the <code>IDBTransaction.objectStore</code> method, which you can use to access your object store. Runs in a separate thread.  */
    native public IDBTransaction transaction(String storeNames);
    native public void addEventListener(jsweet.util.StringTypes.abort type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    /** 
 Immediately returns a transaction object ( <code>IDBTransaction</code>) containing the <code>IDBTransaction.objectStore</code> method, which you can use to access your object store. Runs in a separate thread.  */
    native public IDBTransaction transaction(String[] storeNames, String mode);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    /** 
 Immediately returns a transaction object ( <code>IDBTransaction</code>) containing the <code>IDBTransaction.objectStore</code> method, which you can use to access your object store. Runs in a separate thread.  */
    native public IDBTransaction transaction(String[] storeNames);
    native public void addEventListener(String type, EventListenerObject listener);
}

