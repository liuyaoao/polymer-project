package jsweet.dom;
/**  <div> <p>The <strong><code>IDBIndex</code></strong> interface of the IndexedDB API provides asynchronous access to an index in a database. An index is a kind of object store for looking up records in another object store, called the referenced object store. You use this interface to retrieve data.</p> </div> <p>You can retrieve records in an object store through the primary key or by using an index. An index lets you look up records in an object store using properties of the values in the object stores records other than the primary key</p> <p>The index is a persistent key-value storage where the value part of its records is the key part of a record in the referenced object store. The records in an index are automatically populated whenever records in the referenced object store are inserted, updated, or deleted. Each record in an index can point to only one record in its referenced object store, but several indexes can reference the same object store. When the object store changes, all indexes that refers to the object store are automatically updated.</p> <p><span>You can grab a set of keys within a range. To learn more, see <code>IDBKeyRange</code>.</span></p> <div> <strong>Note:</strong>&nbsp;This feature is available in Web Workers. </div>  */
public class IDBIndex extends jsweet.lang.Object {
    /** 
 The key path of this index. If null, this index is not auto-populated.  */
    public jsweet.util.union.Union<String,String[]> keyPath;
    /** 
 The name of this index.  */
    public String name;
    /** 
 The name of the object store referenced by this index.  */
    public IDBObjectStore objectStore;
    /** 
 If <code>true</code>, this index does not allow duplicate values for a key.  */
    public Boolean unique;
    /** 
 Affects how the index behaves when the result of evaluating the index's key path yields an array. If <code>true</code>, there is one record in the index for each item in an array of keys.&nbsp;If <code>false</code>, then there is one record for each key that is an array.  */
    public Boolean multiEntry;
    native public IDBRequest count(Object key);
    native public IDBRequest get(Object key);
    native public IDBRequest getKey(Object key);
    native public IDBRequest openCursor(IDBKeyRange range, String direction);
    native public IDBRequest openKeyCursor(IDBKeyRange range, String direction);
    public static IDBIndex prototype;
    public IDBIndex(){}
    native public IDBRequest count();
    native public IDBRequest openCursor(IDBKeyRange range);
    native public IDBRequest openCursor();
    native public IDBRequest openKeyCursor(IDBKeyRange range);
    native public IDBRequest openKeyCursor();
}

