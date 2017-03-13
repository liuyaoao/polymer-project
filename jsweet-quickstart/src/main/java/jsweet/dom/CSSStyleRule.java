package jsweet.dom;
/**  <p><strong><code>CSSStyleRule</code></strong> represents a single CSS style rule. It implements the <code>CSSRule</code> interface with a type value of <code>1</code> (<code>CSSRule.STYLE_RULE</code>).</p>  */
public class CSSStyleRule extends CSSRule {
    public Boolean readOnly;
    /** 
 Gets the textual representation of the selector for this rule, e.g. <code>&quot;h1,h2&quot;</code>.  */
    public String selectorText;
    /** 
 Returns the <code>CSSStyleDeclaration</code> object for the rule. <strong>Read only.</strong>  */
    public CSSStyleDeclaration style;
    public static CSSStyleRule prototype;
    public CSSStyleRule(){}
}

