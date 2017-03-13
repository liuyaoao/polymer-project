package jsweet.dom;
/**  <p>An object implementing the <strong><code>CSSGroupingRule</code></strong> interface represents any CSS at-rule that contains other rules nested within it.</p> <p>Objects deriving from it :</p> <ul> <li><code>CSSConditionRule</code> and its children: <code>CSSMediaRule</code>, <code>CSSSupportsRule</code>, and <code>CSSDocumentRule</code>.</li> <li><code>CSSPageRule</code></li> </ul>  */
public class CSSGroupingRule extends CSSRule {
    /** 
 Returns a <code>CSSRuleList</code> of the CSS rules in the media rule.  */
    public CSSRuleList cssRules;
    native public void deleteRule(double index);
    native public double insertRule(String rule, double index);
    public static CSSGroupingRule prototype;
    public CSSGroupingRule(){}
    native public void deleteRule();
    native public double insertRule(String rule);
}

