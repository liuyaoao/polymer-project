package jsweet.dom;
/** <p>The <code>SVGImageElement</code> interface corresponds to the <code>&lt;image&gt;</code> element.</p>  */
@jsweet.lang.Extends({SVGStylable.class,SVGTransformable.class,SVGTests.class,SVGLangSpace.class,SVGExternalResourcesRequired.class,SVGURIReference.class})
public class SVGImageElement extends SVGElement {
    /** 
Corresponds to attribute <code>height</code> on the given <code>&lt;image&gt;</code> element. */
    public SVGAnimatedLength height;
    /** 
Corresponds to attribute <code>preserveAspectRatio</code> on the given <code>&lt;image&gt;</code> element. */
    public SVGAnimatedPreserveAspectRatio preserveAspectRatio;
    /** 
Corresponds to attribute <code>width</code> on the given <code>&lt;image&gt;</code> element. */
    public SVGAnimatedLength width;
    /** 
Corresponds to attribute <code>x</code> on the given <code>&lt;image&gt;</code> element. */
    public SVGAnimatedLength x;
    /** 
Corresponds to attribute <code>y</code> on the given <code>&lt;image&gt;</code> element. */
    public SVGAnimatedLength y;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGImageElement prototype;
    public SVGImageElement(){}
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

