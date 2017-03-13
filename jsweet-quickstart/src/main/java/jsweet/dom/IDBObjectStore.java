package jsweet.dom;
/**  <div> <p>The <strong><code>IDBObjectStore</code></strong> interface of the IndexedDB API represents an object store in a database.&nbsp;Records within an object store are sorted according to their keys. This sorting enables fast insertion, look-up, and ordered retrieval.</p>  <div> <strong>Note:</strong>&nbsp;This feature is available in Web Workers. </div>  </div>  */
public class IDBObjectStore extends jsweet.lang.Object {
    /** 
 A list of the names of indexes on objects in this object store.  */
    public DOMStringList indexNames;
    /** 
 The key path of this object store. If this attribute is null, the application must provide a key for each modification operation.  */
    public jsweet.util.union.Union<String,String[]> keyPath;
    /** 
 The name of this object store.  */
    public String name;
    /** 
 The name of the transaction to which this object store belongs.  */
    public IDBTransaction transaction;
    /** 
 The value of the auto increment flag for this object store.  */
    public Boolean autoIncrement;
    /** 
 Returns an <code>IDBRequest</code> object, and, in a separate thread, creates a structured clone of the <code>value</code>, and stores the cloned value in the object store. This is for adding new records to an object store.  */
    native public IDBRequest add(Object value, Object key);
    /** 
 Creates and immediately returns an <code>IDBRequest</code> object, and clears this object store in a separate thread. This is for deleting all current records out of an object store.  */
    native public IDBRequest clear();
    /** 
 Returns an <code>IDBRequest</code> object, and, in a separate thread, returns the total number of records that match the provided key or <code>IDBKeyRange</code>. If no arguments are provided, it returns the total number of records in the store.  */
    native public IDBRequest count(Object key);
    /** 
 Creates a new index during a version upgrade, returning a new <code>IDBIndex</code> object in the connected database.  */
    native public IDBIndex createIndex(String name, String keyPath, IDBIndexParameters optionalParameters);
    /** 
 returns an <code>IDBRequest</code> object, and, in a separate thread, deletes the current object store. This is for deleting individual records out of an object store.  */
    native public IDBRequest delete(Object key);
    /** 
 Destroys the specified index in the connected database, used during a version upgrade.  */
    native public void deleteIndex(String indexName);
    /** 
 Returns an <code>IDBRequest</code> object, and, in a separate thread, returns the object store selected by the specified key. This is for retrieving specific records from an object store.  */
    native public IDBRequest get(Object key);
    /** 
 Opens an index from this object store after which it can, for example, be used to return a sequence of records sorted by that index using a cursor.  */
    native public IDBIndex index(String name);
    /** 
 Returns an <code>IDBRequest</code> object, and, in a separate thread, returns a new <code>IDBCursorWithValue</code> object. Used for iterating through an object store by primary key with a cursor.  */
    native public IDBRequest openCursor(Object range, String direction);
    /** 
 Returns an <code>IDBRequest</code> object, and, in a separate thread, creates a structured clone of the <code>value</code>, and stores the cloned value in the object store. This is for updating existing records in an object store when the transaction's mode is <code>readwrite</code>.  */
    native public IDBRequest put(Object value, Object key);
    public static IDBObjectStore prototype;
    public IDBObjectStore(){}
    /** 
 Returns an <code>IDBRequest</code> object, and, in a separate thread, creates a structured clone of the <code>value</code>, and stores the cloned value in the object store. This is for adding new records to an object store.  */
    native public IDBRequest add(Object value);
    /** 
 Returns an <code>IDBRequest</code> object, and, in a separate thread, returns the total number of records that match the provided key or <code>IDBKeyRange</code>. If no arguments are provided, it returns the total number of records in the store.  */
    native public IDBRequest count();
    /** 
 Creates a new index during a version upgrade, returning a new <code>IDBIndex</code> object in the connected database.  */
    native public IDBIndex createIndex(String name, String keyPath);
    /** 
 Returns an <code>IDBRequest</code> object, and, in a separate thread, returns a new <code>IDBCursorWithValue</code> object. Used for iterating through an object store by primary key with a cursor.  */
    native public IDBRequest openCursor(Object range);
    /** 
 Returns an <code>IDBRequest</code> object, and, in a separate thread, returns a new <code>IDBCursorWithValue</code> object. Used for iterating through an object store by primary key with a cursor.  */
    native public IDBRequest openCursor();
    /** 
 Returns an <code>IDBRequest</code> object, and, in a separate thread, creates a structured clone of the <code>value</code>, and stores the cloned value in the object store. This is for updating existing records in an object store when the transaction's mode is <code>readwrite</code>.  */
    native public IDBRequest put(Object value);
    /** 
 Creates a new index during a version upgrade, returning a new <code>IDBIndex</code> object in the connected database.  */
    native public IDBIndex createIndex(String name, String[] keyPath, IDBIndexParameters optionalParameters);
    /** 
 Creates a new index during a version upgrade, returning a new <code>IDBIndex</code> object in the connected database.  */
    native public IDBIndex createIndex(String name, String[] keyPath);
}

