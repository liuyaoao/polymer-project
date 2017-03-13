package jsweet.dom;
/** <p>The <code>SVGUseElement</code> interface provides access to the properties of <code>&lt;use&gt;</code> elements, as well as methods to manipulate them.</p>  */
@jsweet.lang.Extends({SVGStylable.class,SVGTransformable.class,SVGTests.class,SVGLangSpace.class,SVGExternalResourcesRequired.class,SVGURIReference.class})
public class SVGUseElement extends SVGElement {
    /** 
If the <code>xlink:href</code> attribute is being animated, contains the current animated root of the instance tree. If the <code>xlink:href</code> attribute is not currently being animated, contains the same value as <code>instanceRoot</code>. See description of <code>SVGElementInstance</code> to learn more about the instance tree. */
    public SVGElementInstance animatedInstanceRoot;
    /** 
Corresponds to attribute <code>height</code> on the given <code>&lt;use&gt;</code> element. */
    public SVGAnimatedLength height;
    /** 
The root of the instance tree. See description of <code>SVGElementInstance</code> to learn more about the instance tree. */
    public SVGElementInstance instanceRoot;
    /** 
Corresponds to attribute <code>width</code> on the given <code>&lt;use&gt;</code> element. */
    public SVGAnimatedLength width;
    /** 
Corresponds to attribute <code>x</code> on the given <code>&lt;use&gt;</code> element. */
    public SVGAnimatedLength x;
    /** 
Corresponds to attribute <code>y</code> on the given <code>&lt;use&gt;</code> element. */
    public SVGAnimatedLength y;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGUseElement prototype;
    public SVGUseElement(){}
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

