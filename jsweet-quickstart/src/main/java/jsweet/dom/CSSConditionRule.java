package jsweet.dom;
/**  <p>An object implementing the <strong><code>CSSConditionRule</code></strong> interface represents a single condition CSS at-rule, which consists of a condition and a statement block. It is a child of <code>CSSGroupingRule</code>.</p> <p>Two objects derive from it : <code>CSSMediaRule</code> and <code>CSSSupportsRule</code>.</p>  */
public class CSSConditionRule extends CSSGroupingRule {
    /** 
 Represents the text of the condition of the rule.  */
    public String conditionText;
    public static CSSConditionRule prototype;
    public CSSConditionRule(){}
}

