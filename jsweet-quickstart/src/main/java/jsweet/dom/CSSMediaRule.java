package jsweet.dom;
/**  <p>The <strong><code>CSSMediaRule</code></strong> is an interface representing a single CSS <code>@media</code> rule. It implements the <code>CSSConditionRule</code> interface, and therefore the <code>CSSGroupingRule</code> and the <code>CSSRule</code> interface with a type value of <code>4</code> (<code>CSSRule.MEDIA_RULE</code>).</p>  */
public class CSSMediaRule extends CSSConditionRule {
    /** 
 Specifies a <code>MediaList</code> representing the intended destination medium for style information.  */
    public MediaList media;
    public static CSSMediaRule prototype;
    public CSSMediaRule(){}
}

