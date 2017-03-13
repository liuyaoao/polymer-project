package jsweet.dom;
/** <p>The <code>SVGPreserveAspectRatio</code> interface corresponds to the <code>preserveAspectRatio</code> attribute, which is available for some of SVG's elements.</p> <p>An <code>SVGPreserveAspectRatio</code> object can be designated as read only, which means that attempts to modify the object will result in an exception being thrown.</p>  */
public class SVGPreserveAspectRatio extends jsweet.lang.Object {
    /** 
The type of the alignment value as specified by one of the SVG_PRESERVEASPECTRATIO_* constants defined on this interface. */
    public double align;
    /** 
The type of the meet-or-slice value as specified by one of the SVG_MEETORSLICE_* constants defined on this interface. */
    public double meetOrSlice;
    /** 
Corresponds to value <code>meet</code> for attribute <code>preserveAspectRatio</code>. */
    public double SVG_MEETORSLICE_MEET;
    /** 
Corresponds to value <code>slice</code> for attribute <code>preserveAspectRatio</code>. */
    public double SVG_MEETORSLICE_SLICE;
    /** 
The enumeration was set to a value that is not one of predefined types. It is invalid to attempt to define a new value of this type or to attempt to switch an existing value to this type. */
    public double SVG_MEETORSLICE_UNKNOWN;
    public double SVG_PRESERVEASPECTRATIO_NONE;
    public double SVG_PRESERVEASPECTRATIO_UNKNOWN;
    public double SVG_PRESERVEASPECTRATIO_XMAXYMAX;
    public double SVG_PRESERVEASPECTRATIO_XMAXYMID;
    public double SVG_PRESERVEASPECTRATIO_XMAXYMIN;
    public double SVG_PRESERVEASPECTRATIO_XMIDYMAX;
    public double SVG_PRESERVEASPECTRATIO_XMIDYMID;
    public double SVG_PRESERVEASPECTRATIO_XMIDYMIN;
    public double SVG_PRESERVEASPECTRATIO_XMINYMAX;
    public double SVG_PRESERVEASPECTRATIO_XMINYMID;
    public double SVG_PRESERVEASPECTRATIO_XMINYMIN;
    public static SVGPreserveAspectRatio prototype;
    public SVGPreserveAspectRatio(){}
}

