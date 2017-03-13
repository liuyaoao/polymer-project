package jsweet.dom;
/**  <p>An <code>XPathExpression</code> is a compiled XPath query returned from <code>document.createExpression()</code>. It has a method <code>evaluate()</code> which can be used to execute the compiled XPath.</p>  */
public class XPathExpression extends jsweet.lang.Object {
    native public XPathExpression evaluate(Node contextNode, double type, XPathResult result);
    public static XPathExpression prototype;
    public XPathExpression(){}
}

