package jsweet.dom;
/**  <p><span>The <strong><code>Element</code></strong> interface represents an object of a <code>Document</code>. This interface describes methods and properties common to all kinds of elements. Specific behaviors are described in interfaces which inherit from <code>Element</code> but add additional functionality.</span> For example, the <code>HTMLElement</code> interface is the base interface for HTML elements, while the <code>SVGElement</code> interface is the basis for all SVG elements.</p> <p>Languages outside the realm of the Web platform, like XUL through the <code>XULElement</code> interface, also implement it.</p>  */
@jsweet.lang.Extends({GlobalEventHandlers.class,ElementTraversal.class,NodeSelector.class,ChildNode.class})
public class Element extends Node {
    /** 
 Returns a <code>DOMTokenList</code> containing the list of class attributes.  */
    public DOMTokenList classList;
    /** 
 Returns a <code>Number</code> representing the inner height of the element.  */
    public double clientHeight;
    /** 
 Returns a <code>Number</code> representing the width of the left border of the element.  */
    public double clientLeft;
    /** 
 Returns a <code>Number</code> representing the width of the top border of the element.  */
    public double clientTop;
    /** 
 Returns a <code>Number</code> representing the inner width of the element.  */
    public double clientWidth;
    public double msContentZoomFactor;
    public String msRegionOverflow;
    public java.util.function.Function<AriaRequestEvent,Object> onariarequest;
    public java.util.function.Function<CommandEvent,Object> oncommand;
    /** 
 Returns the event handler for the <code>gotpointercapture</code> event type.  */
    public java.util.function.Function<PointerEvent,Object> ongotpointercapture;
    /** 
 Returns the event handler for the <code>lostpointercapture</code> event type.  */
    public java.util.function.Function<PointerEvent,Object> onlostpointercapture;
    public java.util.function.Function<MSGestureEvent,Object> onmsgesturechange;
    public java.util.function.Function<MSGestureEvent,Object> onmsgesturedoubletap;
    public java.util.function.Function<MSGestureEvent,Object> onmsgestureend;
    public java.util.function.Function<MSGestureEvent,Object> onmsgesturehold;
    public java.util.function.Function<MSGestureEvent,Object> onmsgesturestart;
    public java.util.function.Function<MSGestureEvent,Object> onmsgesturetap;
    public java.util.function.Function<MSPointerEvent,Object> onmsgotpointercapture;
    public java.util.function.Function<MSGestureEvent,Object> onmsinertiastart;
    public java.util.function.Function<MSPointerEvent,Object> onmslostpointercapture;
    public java.util.function.Function<MSPointerEvent,Object> onmspointercancel;
    public java.util.function.Function<MSPointerEvent,Object> onmspointerdown;
    public java.util.function.Function<MSPointerEvent,Object> onmspointerenter;
    public java.util.function.Function<MSPointerEvent,Object> onmspointerleave;
    public java.util.function.Function<MSPointerEvent,Object> onmspointermove;
    public java.util.function.Function<MSPointerEvent,Object> onmspointerout;
    public java.util.function.Function<MSPointerEvent,Object> onmspointerover;
    public java.util.function.Function<MSPointerEvent,Object> onmspointerup;
    public java.util.function.Function<TouchEvent,Object> ontouchcancel;
    public java.util.function.Function<TouchEvent,Object> ontouchend;
    public java.util.function.Function<TouchEvent,Object> ontouchmove;
    public java.util.function.Function<TouchEvent,Object> ontouchstart;
    public java.util.function.Function<Event,Object> onwebkitfullscreenchange;
    public java.util.function.Function<Event,Object> onwebkitfullscreenerror;
    /** 
 Returns a <code>Number</code> representing the scroll view height of an element.  */
    public double scrollHeight;
    /** 
 Is a <code>Number</code> representing the left scroll offset of the element.  */
    public double scrollLeft;
    /** 
 Is a <code>Number</code> representing the top scroll offset the an element.  */
    public double scrollTop;
    /** 
 Returns a <code>Number</code> representing the scroll view width of the element.  */
    public double scrollWidth;
    /** 
 Returns a <code>String</code> with the name of the tag for the given element.  */
    public String tagName;
    /** 
 Is a <code>DOMString</code> representing the id of the element.  */
    public String id;
    /** 
 Is a <code>DOMString</code> representing the class of the element.  */
    public String className;
    /** 
 Is a <code>DOMString</code> representing the markup of the element's content.  */
    public String innerHTML;
    /** 
 Retrieves the value of the named attribute from the current node and returns it as an <code>Object</code>.  */
    native public String getAttribute(String name);
    /** 
 Retrieves the value of the attribute with the specified name and namespace, from the current node and returns it as an <code>Object</code>.  */
    native public String getAttributeNS(String namespaceURI, String localName);
    /** 
 Retrieves the node representation of the named attribute from the current node and returns it as an <code>Attr</code>.  */
    native public Attr getAttributeNode(String name);
    /** 
 Retrieves the node representation of the attribute with the specified name and namespace, from the current node and returns it as an <code>Attr</code>.  */
    native public Attr getAttributeNodeNS(String namespaceURI, String localName);
    /** 
 ...  */
    native public ClientRect getBoundingClientRect();
    /** 
 Returns a collection of rectangles that indicate the bounding rectangles for each line of text in a client.  */
    native public ClientRectList getClientRects();
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLAnchorElement> getElementsByTagName(jsweet.util.StringTypes.a name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.abbr name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.acronym name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLBlockElement> getElementsByTagName(jsweet.util.StringTypes.address name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLAppletElement> getElementsByTagName(jsweet.util.StringTypes.applet name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLAreaElement> getElementsByTagName(jsweet.util.StringTypes.area name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLElement> getElementsByTagName(jsweet.util.StringTypes.article name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLElement> getElementsByTagName(jsweet.util.StringTypes.aside name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLAudioElement> getElementsByTagName(jsweet.util.StringTypes.audio name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.b name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLBaseElement> getElementsByTagName(jsweet.util.StringTypes.base name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLBaseFontElement> getElementsByTagName(jsweet.util.StringTypes.basefont name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.bdo name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.big name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLBlockElement> getElementsByTagName(jsweet.util.StringTypes.blockquote name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLBodyElement> getElementsByTagName(jsweet.util.StringTypes.body name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLBRElement> getElementsByTagName(jsweet.util.StringTypes.br name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLButtonElement> getElementsByTagName(jsweet.util.StringTypes.button name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLCanvasElement> getElementsByTagName(jsweet.util.StringTypes.canvas name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLTableCaptionElement> getElementsByTagName(jsweet.util.StringTypes.caption name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLBlockElement> getElementsByTagName(jsweet.util.StringTypes.center name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGCircleElement> getElementsByTagName(jsweet.util.StringTypes.circle name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.cite name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGClipPathElement> getElementsByTagName(jsweet.util.StringTypes.clipPath name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.code name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLTableColElement> getElementsByTagName(jsweet.util.StringTypes.col name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLTableColElement> getElementsByTagName(jsweet.util.StringTypes.colgroup name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLDataListElement> getElementsByTagName(jsweet.util.StringTypes.datalist name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLDDElement> getElementsByTagName(jsweet.util.StringTypes.dd name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGDefsElement> getElementsByTagName(jsweet.util.StringTypes.defs name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLModElement> getElementsByTagName(jsweet.util.StringTypes.del name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGDescElement> getElementsByTagName(jsweet.util.StringTypes.desc name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.dfn name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLDirectoryElement> getElementsByTagName(jsweet.util.StringTypes.dir name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLDivElement> getElementsByTagName(jsweet.util.StringTypes.div name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLDListElement> getElementsByTagName(jsweet.util.StringTypes.dl name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLDTElement> getElementsByTagName(jsweet.util.StringTypes.dt name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGEllipseElement> getElementsByTagName(jsweet.util.StringTypes.ellipse name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.em name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLEmbedElement> getElementsByTagName(jsweet.util.StringTypes.embed name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEBlendElement> getElementsByTagName(jsweet.util.StringTypes.feBlend name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEColorMatrixElement> getElementsByTagName(jsweet.util.StringTypes.feColorMatrix name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEComponentTransferElement> getElementsByTagName(jsweet.util.StringTypes.feComponentTransfer name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFECompositeElement> getElementsByTagName(jsweet.util.StringTypes.feComposite name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEConvolveMatrixElement> getElementsByTagName(jsweet.util.StringTypes.feConvolveMatrix name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEDiffuseLightingElement> getElementsByTagName(jsweet.util.StringTypes.feDiffuseLighting name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEDisplacementMapElement> getElementsByTagName(jsweet.util.StringTypes.feDisplacementMap name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEDistantLightElement> getElementsByTagName(jsweet.util.StringTypes.feDistantLight name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEFloodElement> getElementsByTagName(jsweet.util.StringTypes.feFlood name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEFuncAElement> getElementsByTagName(jsweet.util.StringTypes.feFuncA name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEFuncBElement> getElementsByTagName(jsweet.util.StringTypes.feFuncB name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEFuncGElement> getElementsByTagName(jsweet.util.StringTypes.feFuncG name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEFuncRElement> getElementsByTagName(jsweet.util.StringTypes.feFuncR name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEGaussianBlurElement> getElementsByTagName(jsweet.util.StringTypes.feGaussianBlur name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEImageElement> getElementsByTagName(jsweet.util.StringTypes.feImage name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEMergeElement> getElementsByTagName(jsweet.util.StringTypes.feMerge name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEMergeNodeElement> getElementsByTagName(jsweet.util.StringTypes.feMergeNode name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEMorphologyElement> getElementsByTagName(jsweet.util.StringTypes.feMorphology name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEOffsetElement> getElementsByTagName(jsweet.util.StringTypes.feOffset name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFEPointLightElement> getElementsByTagName(jsweet.util.StringTypes.fePointLight name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFESpecularLightingElement> getElementsByTagName(jsweet.util.StringTypes.feSpecularLighting name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFESpotLightElement> getElementsByTagName(jsweet.util.StringTypes.feSpotLight name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFETileElement> getElementsByTagName(jsweet.util.StringTypes.feTile name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFETurbulenceElement> getElementsByTagName(jsweet.util.StringTypes.feTurbulence name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLFieldSetElement> getElementsByTagName(jsweet.util.StringTypes.fieldset name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLElement> getElementsByTagName(jsweet.util.StringTypes.figcaption name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLElement> getElementsByTagName(jsweet.util.StringTypes.figure name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGFilterElement> getElementsByTagName(jsweet.util.StringTypes.filter name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLFontElement> getElementsByTagName(jsweet.util.StringTypes.font name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLElement> getElementsByTagName(jsweet.util.StringTypes.footer name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGForeignObjectElement> getElementsByTagName(jsweet.util.StringTypes.foreignObject name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLFormElement> getElementsByTagName(jsweet.util.StringTypes.form name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLFrameElement> getElementsByTagName(jsweet.util.StringTypes.frame name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLFrameSetElement> getElementsByTagName(jsweet.util.StringTypes.frameset name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGGElement> getElementsByTagName(jsweet.util.StringTypes.g name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLHeadingElement> getElementsByTagName(jsweet.util.StringTypes.h1 name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLHeadingElement> getElementsByTagName(jsweet.util.StringTypes.h2 name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLHeadingElement> getElementsByTagName(jsweet.util.StringTypes.h3 name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLHeadingElement> getElementsByTagName(jsweet.util.StringTypes.h4 name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLHeadingElement> getElementsByTagName(jsweet.util.StringTypes.h5 name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLHeadingElement> getElementsByTagName(jsweet.util.StringTypes.h6 name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLHeadElement> getElementsByTagName(jsweet.util.StringTypes.head name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLElement> getElementsByTagName(jsweet.util.StringTypes.header name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLElement> getElementsByTagName(jsweet.util.StringTypes.hgroup name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLHRElement> getElementsByTagName(jsweet.util.StringTypes.hr name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLHtmlElement> getElementsByTagName(jsweet.util.StringTypes.html name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.i name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLIFrameElement> getElementsByTagName(jsweet.util.StringTypes.iframe name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGImageElement> getElementsByTagName(jsweet.util.StringTypes.image name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLImageElement> getElementsByTagName(jsweet.util.StringTypes.img name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLInputElement> getElementsByTagName(jsweet.util.StringTypes.input name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLModElement> getElementsByTagName(jsweet.util.StringTypes.ins name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLIsIndexElement> getElementsByTagName(jsweet.util.StringTypes.isindex name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.kbd name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLBlockElement> getElementsByTagName(jsweet.util.StringTypes.keygen name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLLabelElement> getElementsByTagName(jsweet.util.StringTypes.label name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLLegendElement> getElementsByTagName(jsweet.util.StringTypes.legend name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLLIElement> getElementsByTagName(jsweet.util.StringTypes.li name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGLineElement> getElementsByTagName(jsweet.util.StringTypes.line name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGLinearGradientElement> getElementsByTagName(jsweet.util.StringTypes.linearGradient name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLLinkElement> getElementsByTagName(jsweet.util.StringTypes.link name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLBlockElement> getElementsByTagName(jsweet.util.StringTypes.listing name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLMapElement> getElementsByTagName(jsweet.util.StringTypes.map name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLElement> getElementsByTagName(jsweet.util.StringTypes.mark name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGMarkerElement> getElementsByTagName(jsweet.util.StringTypes.marker name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLMarqueeElement> getElementsByTagName(jsweet.util.StringTypes.marquee name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGMaskElement> getElementsByTagName(jsweet.util.StringTypes.mask name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLMenuElement> getElementsByTagName(jsweet.util.StringTypes.menu name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLMetaElement> getElementsByTagName(jsweet.util.StringTypes.meta name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGMetadataElement> getElementsByTagName(jsweet.util.StringTypes.metadata name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLElement> getElementsByTagName(jsweet.util.StringTypes.nav name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLNextIdElement> getElementsByTagName(jsweet.util.StringTypes.nextid name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.nobr name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLElement> getElementsByTagName(jsweet.util.StringTypes.noframes name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLElement> getElementsByTagName(jsweet.util.StringTypes.noscript name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLObjectElement> getElementsByTagName(jsweet.util.StringTypes.object name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLOListElement> getElementsByTagName(jsweet.util.StringTypes.ol name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLOptGroupElement> getElementsByTagName(jsweet.util.StringTypes.optgroup name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLOptionElement> getElementsByTagName(jsweet.util.StringTypes.option name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLParagraphElement> getElementsByTagName(jsweet.util.StringTypes.p name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLParamElement> getElementsByTagName(jsweet.util.StringTypes.param name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGPathElement> getElementsByTagName(jsweet.util.StringTypes.path name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGPatternElement> getElementsByTagName(jsweet.util.StringTypes.pattern name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLBlockElement> getElementsByTagName(jsweet.util.StringTypes.plaintext name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGPolygonElement> getElementsByTagName(jsweet.util.StringTypes.polygon name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGPolylineElement> getElementsByTagName(jsweet.util.StringTypes.polyline name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPreElement> getElementsByTagName(jsweet.util.StringTypes.pre name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLProgressElement> getElementsByTagName(jsweet.util.StringTypes.progress name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLQuoteElement> getElementsByTagName(jsweet.util.StringTypes.q name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGRadialGradientElement> getElementsByTagName(jsweet.util.StringTypes.radialGradient name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGRectElement> getElementsByTagName(jsweet.util.StringTypes.rect name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.rt name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.ruby name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.s name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.samp name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLScriptElement> getElementsByTagName(jsweet.util.StringTypes.script name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLElement> getElementsByTagName(jsweet.util.StringTypes.section name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLSelectElement> getElementsByTagName(jsweet.util.StringTypes.select name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.small name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLSourceElement> getElementsByTagName(jsweet.util.StringTypes.source name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLSpanElement> getElementsByTagName(jsweet.util.StringTypes.span name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGStopElement> getElementsByTagName(jsweet.util.StringTypes.stop name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.strike name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.strong name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLStyleElement> getElementsByTagName(jsweet.util.StringTypes.style name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.sub name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.sup name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGSVGElement> getElementsByTagName(jsweet.util.StringTypes.svg name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGSwitchElement> getElementsByTagName(jsweet.util.StringTypes.Switch name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGSymbolElement> getElementsByTagName(jsweet.util.StringTypes.symbol name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLTableElement> getElementsByTagName(jsweet.util.StringTypes.table name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLTableSectionElement> getElementsByTagName(jsweet.util.StringTypes.tbody name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLTableDataCellElement> getElementsByTagName(jsweet.util.StringTypes.td name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGTextElement> getElementsByTagName(jsweet.util.StringTypes.text name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGTextPathElement> getElementsByTagName(jsweet.util.StringTypes.textPath name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLTextAreaElement> getElementsByTagName(jsweet.util.StringTypes.textarea name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLTableSectionElement> getElementsByTagName(jsweet.util.StringTypes.tfoot name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLTableHeaderCellElement> getElementsByTagName(jsweet.util.StringTypes.th name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLTableSectionElement> getElementsByTagName(jsweet.util.StringTypes.thead name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLTitleElement> getElementsByTagName(jsweet.util.StringTypes.title name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLTableRowElement> getElementsByTagName(jsweet.util.StringTypes.tr name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLTrackElement> getElementsByTagName(jsweet.util.StringTypes.track name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGTSpanElement> getElementsByTagName(jsweet.util.StringTypes.tspan name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.tt name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.u name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLUListElement> getElementsByTagName(jsweet.util.StringTypes.ul name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGUseElement> getElementsByTagName(jsweet.util.StringTypes.use name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPhraseElement> getElementsByTagName(jsweet.util.StringTypes.var name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLVideoElement> getElementsByTagName(jsweet.util.StringTypes.video name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<SVGViewElement> getElementsByTagName(jsweet.util.StringTypes.view name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLElement> getElementsByTagName(jsweet.util.StringTypes.wbr name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<MSHTMLWebViewElement> getElementsByTagName(jsweet.util.StringTypes.x_ms_webview name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLBlockElement> getElementsByTagName(jsweet.util.StringTypes.xmp name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<Element> getElementsByTagName(String name);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name and namespace, from the current element.  */
    native public NodeListOf<Element> getElementsByTagNameNS(String namespaceURI, String localName);
    /** 
 Returns a <code>Boolean</code> indicating if the element has the specified attribute or not.  */
    native public Boolean hasAttribute(String name);
    /** 
 Returns a <code>Boolean</code> indicating if the element has the specified attribute, in the specified namespace, or not.  */
    native public Boolean hasAttributeNS(String namespaceURI, String localName);
    native public MSRangeCollection msGetRegionContent();
    native public ClientRect msGetUntransformedBounds();
    native public Boolean msMatchesSelector(String selectors);
    native public void msReleasePointerCapture(double pointerId);
    native public void msSetPointerCapture(double pointerId);
    native public void msZoomTo(MsZoomToOptions args);
    native public void releasePointerCapture(double pointerId);
    /** 
 Removes the named attribute from the current node.  */
    native public void removeAttribute(String name);
    /** 
 Removes the attribute with the specified name and namespace, from the current node.  */
    native public void removeAttributeNS(String namespaceURI, String localName);
    /** 
 Removes the node representation of the named attribute from the current node.  */
    native public Attr removeAttributeNode(Attr oldAttr);
    /** 
 Asynchronously asks the browser to make the element full-screen.  */
    native public void requestFullscreen();
    /** 
 Allows to asynchronously ask for the pointer to be locked on the given element.  */
    native public void requestPointerLock();
    /** 
 Sets the value of a named attribute of the current node.  */
    native public void setAttribute(String name, String value);
    /** 
 Sets the value of the attribute with the specified name and namespace, from the current node.  */
    native public void setAttributeNS(String namespaceURI, String qualifiedName, String value);
    /** 
 Sets the node representation of the named attribute from the current node.  */
    native public Attr setAttributeNode(Attr newAttr);
    /** 
 Setw the node representation of the attribute with the specified name and namespace, from the current node.  */
    native public Attr setAttributeNodeNS(Attr newAttr);
    /** 
 Designates a specific element as the capture target of future <code>pointer events</code>.  */
    native public void setPointerCapture(double pointerId);
    native public Boolean webkitMatchesSelector(String selectors);
    native public void webkitRequestFullScreen();
    native public void webkitRequestFullscreen();
    /** 
 Returns a live <code>HTMLCollection</code> that contains all descendant of the current element that posses the list of classes given in parameter.  */
    native public NodeListOf<Element> getElementsByClassName(String classNames);
    /** 
 Returns a <code>Boolean</code> indicating whether or not the element would be selected by the specified selector string.  */
    native public Boolean matches(String selector);
    /** 
 Returns a live <code>HTMLCollection</code> containing all descendant elements, of a particular tag name, from the current element.  */
    native public NodeListOf<HTMLPictureElement> getElementsByTagName(jsweet.util.StringTypes.picture tagname);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureChange type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureDoubleTap type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureEnd type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureHold type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureStart type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureTap type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSGotPointerCapture type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSInertiaStart type, java.util.function.Function<MSGestureEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSLostPointerCapture type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerCancel type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerDown type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerEnter type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerLeave type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerMove type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerOut type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerOver type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerUp type, java.util.function.Function<MSPointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.ariarequest type, java.util.function.Function<AriaRequestEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.command type, java.util.function.Function<CommandEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.gotpointercapture type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.lostpointercapture type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.touchcancel type, java.util.function.Function<TouchEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.touchend type, java.util.function.Function<TouchEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.touchmove type, java.util.function.Function<TouchEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.touchstart type, java.util.function.Function<TouchEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.webkitfullscreenchange type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.webkitfullscreenerror type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    public static Element prototype;
    public Element(){}
    public java.util.function.Function<PointerEvent,Object> onpointercancel;
    public java.util.function.Function<PointerEvent,Object> onpointerdown;
    public java.util.function.Function<PointerEvent,Object> onpointerenter;
    public java.util.function.Function<PointerEvent,Object> onpointerleave;
    public java.util.function.Function<PointerEvent,Object> onpointermove;
    public java.util.function.Function<PointerEvent,Object> onpointerout;
    public java.util.function.Function<PointerEvent,Object> onpointerover;
    public java.util.function.Function<PointerEvent,Object> onpointerup;
    /** 
 Returns the event handling code for the <code>wheel</code> event.  */
    public java.util.function.Function<WheelEvent,Object> onwheel;
    native public void addEventListener(jsweet.util.StringTypes.pointercancel type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerdown type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerenter type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerleave type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointermove type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerout type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerover type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.pointerup type, java.util.function.Function<PointerEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.wheel type, java.util.function.Function<WheelEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public double childElementCount;
    public Element firstElementChild;
    public Element lastElementChild;
    public Element nextElementSibling;
    public Element previousElementSibling;
    /** 
 Returns <code>Node</code>...  */
    native public Element querySelector(String selectors);
    native public NodeListOf<Element> querySelectorAll(String selectors);
    native public void remove();
    /** 
 Retrieves the value of the named attribute from the current node and returns it as an <code>Object</code>.  */
    native public String getAttribute();
    /** 
 Removes the named attribute from the current node.  */
    native public void removeAttribute();
    native public void addEventListener(jsweet.util.StringTypes.MSGestureChange type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureDoubleTap type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureEnd type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureHold type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureStart type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGestureTap type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSGotPointerCapture type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSInertiaStart type, java.util.function.Function<MSGestureEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSLostPointerCapture type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerCancel type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerDown type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerEnter type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerLeave type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerMove type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerOut type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerOver type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.MSPointerUp type, java.util.function.Function<MSPointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.ariarequest type, java.util.function.Function<AriaRequestEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.command type, java.util.function.Function<CommandEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.gotpointercapture type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.lostpointercapture type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointercancel type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerdown type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerenter type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerleave type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointermove type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerout type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerover type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.pointerup type, java.util.function.Function<PointerEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.touchcancel type, java.util.function.Function<TouchEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.touchend type, java.util.function.Function<TouchEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.touchmove type, java.util.function.Function<TouchEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.touchstart type, java.util.function.Function<TouchEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.webkitfullscreenchange type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.webkitfullscreenerror type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.wheel type, java.util.function.Function<WheelEvent,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

