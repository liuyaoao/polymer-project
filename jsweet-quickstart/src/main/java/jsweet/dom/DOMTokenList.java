package jsweet.dom;
/**  <p>The <code><strong>DOMTokenList</strong></code> interface represents a set of space-separated tokens. Such a set is returned by <code>Element.classList</code>, <code>HTMLLinkElement.relList</code>, <code>HTMLAnchorElement.relList</code> or <code>HTMLAreaElement.relList</code>. It is indexed beginning with <code>0</code> as with JavaScript <code>Array</code> objects. <code>DOMTokenList</code> is always case-sensitive.</p>  */
public class DOMTokenList extends jsweet.lang.Object implements Iterable<java.lang.String> {
    /** 
 Is an <code>integer</code> representing the number of objects stored in the object.  */
    public double length;
    /** 
 Adds <em>token</em> to the underlying string  */
    native public void add(String... token);
    /** 
 Returns <code>true</code> if the underlying string contains <em>token</em>, otherwise <code>false</code>  */
    native public Boolean contains(String token);
    /** 
 Returns an item in the list by its index (or undefined if the number is greater than or equal to the length of the list, prior to <span>Gecko&nbsp;7.0</span> returned null)  */
    native public String item(double index);
    /** 
 Removes <em>token</em> from the underlying string  */
    native public void remove(String... token);
    native public String toString();
    /** 
 Removes <em>token</em> from string and returns false. If <em>token</em> doesn't exist it's added and the function returns true  */
    native public Boolean toggle(String token, Boolean force);
    native public java.lang.String $get(double index);
    public static DOMTokenList prototype;
    public DOMTokenList(){}
    /** 
 Removes <em>token</em> from string and returns false. If <em>token</em> doesn't exist it's added and the function returns true  */
    native public Boolean toggle(String token);
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<java.lang.String> iterator();
}

