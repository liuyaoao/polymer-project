package jsweet.dom;
/** <p>The <code>SVGAElement</code> interface provides access to the properties of <code>&lt;a&gt;</code> elements, as well as methods to manipulate them.</p>  */
@jsweet.lang.Extends({SVGStylable.class,SVGTransformable.class,SVGTests.class,SVGLangSpace.class,SVGExternalResourcesRequired.class,SVGURIReference.class})
public class SVGAElement extends SVGElement {
    /** 
Corresponds to attribute <code>target</code> on the given <code>&lt;a&gt;</code> element. */
    public SVGAnimatedString target;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGAElement prototype;
    public SVGAElement(){}
    public Object className;
    public CSSStyleDeclaration style;
    public SVGAnimatedTransformList transform;
    public SVGStringList requiredExtensions;
    public SVGStringList requiredFeatures;
    public SVGStringList systemLanguage;
    native public Boolean hasExtension(String extension);
    public String xmllang;
    public String xmlspace;
    public SVGAnimatedBoolean externalResourcesRequired;
    public SVGAnimatedString href;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

