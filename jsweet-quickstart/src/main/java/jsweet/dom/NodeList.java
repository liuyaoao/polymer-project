package jsweet.dom;
/** <p><code>NodeList</code> objects are collections of nodes such as those returned by <code>Node.childNodes</code> and the <code>document.querySelectorAll</code> method.</p>  */
public class NodeList extends jsweet.lang.Object implements Iterable<Node> {
    public double length;
    native public Node item(double index);
    native public Node $get(double index);
    public static NodeList prototype;
    public NodeList(){}
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<Node> iterator();
}

