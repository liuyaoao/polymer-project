package jsweet.dom;
/** <p>The <code>SVGLineElement</code> interface provides access to the properties of <code>&lt;line&gt;</code> elements, as well as methods to manipulate them.</p>  */
@jsweet.lang.Extends({SVGStylable.class,SVGTransformable.class,SVGTests.class,SVGLangSpace.class,SVGExternalResourcesRequired.class})
public class SVGLineElement extends SVGElement {
    /** 
Corresponds to attribute <code>x1</code> on the given <code>&lt;line&gt;</code> element. */
    public SVGAnimatedLength x1;
    /** 
Corresponds to attribute <code>x2</code> on the given <code>&lt;line&gt;</code> element. */
    public SVGAnimatedLength x2;
    /** 
Corresponds to attribute <code>y1</code> on the given <code>&lt;line&gt;</code> element. */
    public SVGAnimatedLength y1;
    /** 
Corresponds to attribute <code>y2</code> on the given <code>&lt;line&gt;</code> element. */
    public SVGAnimatedLength y2;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGLineElement prototype;
    public SVGLineElement(){}
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

