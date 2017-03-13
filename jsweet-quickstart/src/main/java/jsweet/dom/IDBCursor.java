package jsweet.dom;
/**  <p>The <strong><code>IDBCursor</code></strong> interface of the IndexedDB API represents a cursor for traversing or iterating over multiple records in a database.</p> <p>The cursor has a source that indicates which index or object store it is iterating over. It has a position within the range, and moves in a direction that is increasing or decreasing in the order of record keys. The cursor enables an application to asynchronously process all the records in the cursor's range.</p> <p>You can have an unlimited number of cursors at the same time. You always get the same <code>IDBCursor</code> object representing a given cursor. Operations are performed on the underlying index or object store.</p> <div> <strong>Note:</strong>&nbsp;This feature is available in Web Workers. </div>  */
public class IDBCursor extends jsweet.lang.Object {
    /** 
 Returns the direction of traversal of the cursor. See Constants for possible values.  */
    public String direction;
    /** 
 Returns the key for the record at the cursor's position. If the cursor is outside its range, this is set to <code>undefined</code>. The cursor's key can be any data type.  */
    public Object key;
    /** 
 Returns the cursor's current effective primary key. If the cursor is currently being iterated or has iterated outside its range, this is set to <code>undefined</code>. The cursor's primary key can be any data type.  */
    public Object primaryKey;
    /** 
 Returns the <code>IDBObjectStore</code> or <code>IDBIndex</code> that the cursor is iterating. This function never returns null or throws an exception, even if the cursor is currently being iterated, has iterated past its end, or its transaction is not active.  */
    public jsweet.util.union.Union<IDBObjectStore,IDBIndex> source;
    /** 
 Sets the number times a cursor should move its position forward.  */
    native public void advance(double count);
    @jsweet.lang.Name("continue")
    native public void Continue(Object key);
    /** 
 Returns an <code>IDBRequest</code> object, and, in a separate thread, deletes the record at the cursor's position, without changing the cursor's position. This can be used to delete specific records.  */
    native public IDBRequest delete();
    /** 
 Returns an <code>IDBRequest</code> object, and, in a separate thread, updates the value at the current position of the cursor in the object store. This can be used to update specific records.  */
    native public IDBRequest update(Object value);
    public String NEXT;
    public String NEXT_NO_DUPLICATE;
    public String PREV;
    public String PREV_NO_DUPLICATE;
    public static IDBCursor prototype;
    public IDBCursor(){}
    @jsweet.lang.Name("continue")
    native public void Continue();
}

