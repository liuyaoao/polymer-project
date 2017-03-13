package jsweet.dom;
/** <div> <p><span><i> </i></span> <strong>This is an experimental technology</strong><br></br>Because this technology's specification has not stabilized, check the compatibility table for the proper prefixes to use in various browsers. Also note that the syntax and behavior of an experimental technology is subject to change in future versions of browsers as the spec changes.</p> </div> <p>The <strong><code>CSSNamespaceRule</code></strong> interface describes an object representing a single CSS <code>@namespace</code> at-rule. It implements the <code>CSSRule</code> interface, with a type value of <code>10</code> (<code>CSSRule.NAMESPACE_RULE</code>).</p>  */
public class CSSNamespaceRule extends CSSRule {
    /** 
 Returns a <code>DOMString</code> containing the text of the URI of the given namespace.  */
    public String namespaceURI;
    /** 
 Returns a <code>DOMString</code> with the name of the prefix associated to this namespace. If there is no such prefix, returns&nbsp; <code>null</code>.  */
    public String prefix;
    public static CSSNamespaceRule prototype;
    public CSSNamespaceRule(){}
}

