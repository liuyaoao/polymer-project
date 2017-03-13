package jsweet.dom;
/** <p>The <code>SVGCircleElement</code> interface provides access to the properties of <code>&lt;circle&gt;</code> elements, as well as methods to manipulate them.</p>  */
@jsweet.lang.Extends({SVGStylable.class,SVGTransformable.class,SVGTests.class,SVGLangSpace.class,SVGExternalResourcesRequired.class})
public class SVGCircleElement extends SVGElement {
    /** 
Corresponds to attribute <code>cx</code> on the given <code>&lt;circle&gt;</code> element. */
    public SVGAnimatedLength cx;
    /** 
Corresponds to attribute <code>cy</code> on the given <code>&lt;circle&gt;</code> element. */
    public SVGAnimatedLength cy;
    /** 
Corresponds to attribute <code>r</code> on the given <code>&lt;circle&gt;</code> element. */
    public SVGAnimatedLength r;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGCircleElement prototype;
    public SVGCircleElement(){}
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
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

