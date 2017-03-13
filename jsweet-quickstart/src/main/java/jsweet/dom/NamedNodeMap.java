package jsweet.dom;
/** <p>The <code><strong>NamedNodeMap</strong></code> interface represents a collection of <code>Attr</code> objects. Objects inside a <code>NamedNodeMap</code> are not in any particular order, unlike <code>NodeList</code>, although they may be accessed by an index as in an array.</p> <p>A <code>NamedNodeMap</code> object is&nbsp;<em>live</em> and will thus be auto-updated if changes are made to its contents internally or elsewhere.</p> <div> <p>Although called <code>NamedNodeMap</code>, this interface doesn't deal with <code>Node</code> objects but with <code>Attr</code> objects, which were originally a specialized class of <code>Node</code>, and still are in some implementations.</p> </div>  */
public class NamedNodeMap extends jsweet.lang.Object implements Iterable<Attr> {
    /** 
 Returns the amount of objects in the map.  */
    public double length;
    /** 
 Returns a <code>Attr</code>, corresponding to the given name.  */
    native public Attr getNamedItem(String name);
    /** 
 Returns a <code>Attr</code> identifyied by a namespace and related local name.  */
    native public Attr getNamedItemNS(String namespaceURI, String localName);
    /** 
 Returns the <code>Attr</code> at the given index, or <code>null</code> if the index is higher or equal to the number of nodes.  */
    native public Attr item(double index);
    /** 
 Removes the <code>Attr</code> identified by the given map.  */
    native public Attr removeNamedItem(String name);
    /** 
 Removes the <code>Attr</code> identified by the given namespace and related local name.  */
    native public Attr removeNamedItemNS(String namespaceURI, String localName);
    /** 
 Replaces, or adds, the <code>Attr</code> identified in the map by the given name.  */
    native public Attr setNamedItem(Attr arg);
    /** 
 Replaces, or adds, the <code>Attr</code> identified in the map by the given namespace and related local name.  */
    native public Attr setNamedItemNS(Attr arg);
    native public Attr $get(double index);
    public static NamedNodeMap prototype;
    public NamedNodeMap(){}
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<Attr> iterator();
}

