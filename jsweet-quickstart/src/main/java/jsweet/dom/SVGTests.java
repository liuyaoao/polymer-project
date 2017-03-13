package jsweet.dom;
/** <p>Interface <code>SVGTests</code> defines an interface which applies to all elements which have attributes <code>requiredFeatures</code>, <code>requiredExtensions</code> and <code>systemLanguage</code>.</p>  */
@jsweet.lang.Interface
public abstract class SVGTests extends jsweet.lang.Object {
    /** 
Corresponds to attribute <code>requiredExtensions</code> on the given element. */
    public SVGStringList requiredExtensions;
    /** 
Corresponds to attribute <code>requiredFeatures</code> on the given element. */
    public SVGStringList requiredFeatures;
    /** 
Corresponds to attribute <code>systemLanguage</code> on the given element. */
    public SVGStringList systemLanguage;
    /** 
Returns true if the browser supports the given extension, specified by a URI. */
    native public Boolean hasExtension(String extension);
}

