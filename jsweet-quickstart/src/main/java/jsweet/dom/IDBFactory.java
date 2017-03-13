package jsweet.dom;
/**  <div> <p>The <strong><code>IDBFactory</code></strong> interface of the IndexedDB API lets applications asynchronously access the indexed databases. The object that implements the interface is <code>window.indexedDB</code>. You open — that is, create and access — and delete a database with this object, and not directly with <code>IDBFactory</code>.</p>  <div> <strong>Note:</strong>&nbsp;This feature is available in Web Workers. </div>  </div>  */
public class IDBFactory extends jsweet.lang.Object {
    native public double cmp(Object first, Object second);
    native public IDBOpenDBRequest deleteDatabase(String name);
    native public IDBOpenDBRequest open(String name, double version);
    public static IDBFactory prototype;
    public IDBFactory(){}
    native public IDBOpenDBRequest open(String name);
}

