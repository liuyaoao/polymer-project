package jsweet.dom;
/**  <p>The <strong><code>HTMLCollection</code></strong> interface represents a generic collection (array-like object) of elements (in document order) and offers methods and properties for selecting from the list.</p> <div> <strong>Note:</strong> This interface is called <code>HTMLCollection</code> for historical reasons (before DOM4, collections implementing this interface could only have HTML elements as their items). </div> <p>An <code>HTMLCollection</code> in the HTML DOM is live; it is automatically updated when the underlying document is changed.</p>  */
public class HTMLCollection extends jsweet.lang.Object implements Iterable<Element> {
    /**
      * Sets or retrieves the number of objects in a collection.
      */
    public double length;
    /**
      * Retrieves an object from various collections.
      */
    native public Element item(Object nameOrIndex, Object optionalIndex);
    /**
      * Retrieves a select object or an object from an options collection.
      */
    native public Element namedItem(String name);
    native public Element $get(double index);
    public static HTMLCollection prototype;
    public HTMLCollection(){}
    /**
      * Retrieves an object from various collections.
      */
    native public Element item(Object nameOrIndex);
    /**
      * Retrieves an object from various collections.
      */
    native public Element item();
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<Element> iterator();
}

