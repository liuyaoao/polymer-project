package jsweet.dom;
/**  <p><strong><code>CSSPageRule</code></strong> is an interface representing a single CSS <code>@page</code> rule. It implements the <code>CSSRule</code> interface with a type value of <code>6</code> (<code>CSSRule.PAGE_RULE</code>).</p>  */
public class CSSPageRule extends CSSRule {
    public String pseudoClass;
    public String selector;
    /** 
 Represents the text of the page selector associated with the at-rule.  */
    public String selectorText;
    /** 
 Returns the declaration block associated with the at-rule.  */
    public CSSStyleDeclaration style;
    public static CSSPageRule prototype;
    public CSSPageRule(){}
}

