package jsweet.dom;
/**  <div> <p><span><i> </i></span> <strong>This is an experimental technology</strong><br></br>Because this technology's specification has not stabilized, check the compatibility table for the proper prefixes to use in various browsers. Also note that the syntax and behavior of an experimental technology is subject to change in future versions of browsers as the spec changes.</p> </div> <p>The <strong><code>CSSKeyframesRule</code></strong> interface describes an object representing a complete set of keyframes for a CSS animation. It corresponds to the contains of a whole <code>@keyframes</code> at-rule. It implements the <code>CSSRule</code> interface with a type value of <code>7</code> (<code>CSSRule.KEYFRAMES_RULE</code>).</p>  */
public class CSSKeyframesRule extends CSSRule {
    public CSSRuleList cssRules;
    public String name;
    native public void appendRule(String rule);
    native public void deleteRule(String rule);
    native public CSSKeyframeRule findRule(String rule);
    public static CSSKeyframesRule prototype;
    public CSSKeyframesRule(){}
}

