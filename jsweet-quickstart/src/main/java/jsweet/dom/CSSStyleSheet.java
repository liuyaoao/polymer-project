package jsweet.dom;
/**  <p>An object implementing the <code>CSSStyleSheet</code> interface represents a single CSS style sheet.</p> <p>A CSS style sheet consists of CSS rules, each of which can be manipulated through an object that corresponds to that rule and that implements the <code>CSSStyleRule</code> interface, which in turn implements <code>CSSRule</code>. The <code>CSSStyleSheet</code> itself lets you examine and modify its corresponding style sheet, including its list of rules.</p> <p>In practice, every <code>CSSStyleSheet</code> also implements the more generic <code>StyleSheet</code> interface. A list of <code>CSSStyleSheet</code>-implementing objects corresponding to the style sheets for a given document can be reached by the <code>document.styleSheets</code> property, if the document is styled by an external CSS style sheet or an inline <code>style</code> element.</p>  */
public class CSSStyleSheet extends StyleSheet {
    /** 
 Returns a <code>CSSRuleList</code> of the CSS rules in the style sheet.  */
    public CSSRuleList cssRules;
    public String cssText;
    public String href;
    public String id;
    public StyleSheetList imports;
    public Boolean isAlternate;
    public Boolean isPrefAlternate;
    /** 
 If this style sheet is imported into the document using an <code>@import</code> rule, the <code>ownerRule</code> property will return that <code>CSSImportRule</code>, otherwise it returns <code>null</code>.  */
    public CSSRule ownerRule;
    public Element owningElement;
    public StyleSheetPageList pages;
    public Boolean readOnly;
    public CSSRuleList rules;
    native public double addImport(String bstrURL, double lIndex);
    native public double addPageRule(String bstrSelector, String bstrStyle, double lIndex);
    native public double addRule(String bstrSelector, String bstrStyle, double lIndex);
    native public void deleteRule(double index);
    native public double insertRule(String rule, double index);
    native public void removeImport(double lIndex);
    native public void removeRule(double lIndex);
    public static CSSStyleSheet prototype;
    public CSSStyleSheet(){}
    native public double addImport(String bstrURL);
    native public double addPageRule(String bstrSelector, String bstrStyle);
    native public double addRule(String bstrSelector, String bstrStyle);
    native public double addRule(String bstrSelector);
    native public void deleteRule();
    native public double insertRule(String rule);
}

