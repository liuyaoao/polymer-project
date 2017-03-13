package jsweet.dom;
/**  <p>The <strong><code>IDBEnvironment</code></strong> interface of the IndexedDB API contains the <code>indexedDB</code> property, which provides access to IndexedDB functionality. It is the top level IndexedDB interface implemented by the <code>window</code> and <code>Worker</code> objects.</p> <div> <strong>Note:</strong>&nbsp;This feature is available in Web Workers. </div>  */
@jsweet.lang.Interface
public abstract class IDBEnvironment extends jsweet.lang.Object {
    /** 
 Provides a mechanism for applications to asynchronously access capabilities of indexed databases; contains an <code>IDBFactory</code> object.  */
    public IDBFactory indexedDB;
    public IDBFactory msIndexedDB;
}

