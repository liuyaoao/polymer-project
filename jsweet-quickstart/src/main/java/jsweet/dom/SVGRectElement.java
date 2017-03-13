package jsweet.dom;
/** <p>The <code>SVGRectElement</code> interface provides access to the properties of <code>&lt;rect&gt;</code> elements, as well as methods to manipulate them.</p>  */
@jsweet.lang.Extends({SVGStylable.class,SVGTransformable.class,SVGTests.class,SVGLangSpace.class,SVGExternalResourcesRequired.class})
public class SVGRectElement extends SVGElement {
    /** 
Corresponds to attribute <code>height</code> on the given <code>&lt;rect&gt;</code> element. */
    public SVGAnimatedLength height;
    /** 
Corresponds to attribute <code>rx</code> on the given <code>&lt;rect&gt;</code> element. */
    public SVGAnimatedLength rx;
    /** 
Corresponds to attribute <code>ry</code> on the given <code>&lt;rect&gt;</code> element. */
    public SVGAnimatedLength ry;
    /** 
Corresponds to attribute <code>width</code> on the given <code>&lt;rect&gt;</code> element. */
    public SVGAnimatedLength width;
    /** 
Corresponds to attribute <code>x</code> on the given <code>&lt;rect&gt;</code> element. */
    public SVGAnimatedLength x;
    /** 
Corresponds to attribute <code>y</code> on the given <code>&lt;rect&gt;</code> element. */
    public SVGAnimatedLength y;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGRectElement prototype;
    public SVGRectElement(){}
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

