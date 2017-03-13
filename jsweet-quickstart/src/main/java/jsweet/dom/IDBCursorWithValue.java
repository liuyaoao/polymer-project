package jsweet.dom;
/**  <p>The <strong><code>IDBCursorWithValue</code></strong> interface of the&nbsp;IndexedDB API represents a cursor for traversing or iterating over multiple records in a database. It is the same as the <code>IDBCursor</code>, except that it includes the <code>value</code> property.</p> <p>The cursor has a source that indicates which index or object store it is iterating over. It has a position within the range, and moves in a direction that is increasing or decreasing in the order of record keys. The cursor enables an application to asynchronously process all the records in the cursor's range.</p> <p>You can have an unlimited number of cursors at the same time. You always get the same&nbsp;<code>IDBCursorWithValue</code>&nbsp;object representing a given cursor. Operations are performed on the underlying index or object store.</p> <div> <strong>Note:</strong>&nbsp;This feature is available in Web Workers. </div>  */
public class IDBCursorWithValue extends IDBCursor {
    /** 
 Returns the value of the current cursor.  */
    public Object value;
    public static IDBCursorWithValue prototype;
    public IDBCursorWithValue(){}
}

