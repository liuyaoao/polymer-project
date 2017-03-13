package jsweet.dom;
/** <p>An object implementing the <strong><code>CSSRule</code></strong> DOM interface represents a single CSS at-rule. References to a <code>CSSRule</code>-implementing object may be obtained by looking at a CSS style sheet's <code>cssRules</code> list.</p> <p>There are several kinds of rules. The <code>CSSRule</code> interface specifies the properties common to all rules, while properties unique to specific rule types are specified in the more specialized interfaces for those rules' respective types.</p>  */
public class CSSRule extends jsweet.lang.Object {
    /** 
 Represents the textual representation of the rule, e.g. <code>&quot;h1,h2 { font-size: 16pt }&quot;</code>  */
    public String cssText;
    /** 
 Returns the containing rule, otherwise <code>null</code>. E.g. if this rule is a style rule inside an <code>@media</code> block, the parent rule would be that <code>CSSMediaRule</code>.  */
    public CSSRule parentRule;
    /** 
 Returns the <code>CSSStyleSheet</code> object for the style sheet that contains this rule  */
    public CSSStyleSheet parentStyleSheet;
    /** 
 One of the Type constants indicating the type of CSS rule.  */
    public double type;
    public double CHARSET_RULE;
    public double FONT_FACE_RULE;
    public double IMPORT_RULE;
    public double KEYFRAMES_RULE;
    public double KEYFRAME_RULE;
    public double MEDIA_RULE;
    public double NAMESPACE_RULE;
    public double PAGE_RULE;
    public double STYLE_RULE;
    public double SUPPORTS_RULE;
    public double UNKNOWN_RULE;
    public double VIEWPORT_RULE;
    public static CSSRule prototype;
    public CSSRule(){}
}

