package jsweet.dom;
/**  <p>The <code>Storage</code> interface of the Web Storage API provides access to the session storage or local storage for a particular domain, allowing you to for example add, modify or delete stored data items.</p> <p>If you want to manipulate the session storage for a domain, you call <code>Window.sessionStorage</code> method; If you want to manipulate the local storage for a domain, you call <code>Window.localStorage</code>.</p>  */
public class Storage extends jsweet.lang.Object implements Iterable<java.lang.String> {
    /** 
 Returns an integer representing the number of data items stored in the <code>Storage</code> object.  */
    public double length;
    /** 
 When invoked, will empty all keys out of the storage.  */
    native public void clear();
    /** 
 When passed a key name, will return that key's value.  */
    native public Object getItem(String key);
    /** 
 When passed a number n, this method will return the name of the nth key in the storage.  */
    native public String key(double index);
    /** 
 When passed a key name, will remove that key from the storage.  */
    native public void removeItem(String key);
    /** 
 When passed a key name and value, will add that key to the storage, or update that key's value if it already exists.  */
    native public void setItem(String key, String data);
    native public java.lang.Object $get(String key);
    native public java.lang.String $get(double index);
    public static Storage prototype;
    public Storage(){}
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<java.lang.String> iterator();
}

