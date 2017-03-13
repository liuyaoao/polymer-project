package jsweet.dom;
/** <p><code>SVGTransform</code> is the interface for one of the component transformations within an <code>SVGTransformList</code>; thus, an <code>SVGTransform</code> object corresponds to a single component (e.g., <code>scale(…)</code> or <code>matrix(…)</code>) within a <code>transform</code> attribute.</p> <p>An <code>SVGTransform</code> object can be designated as read only, which means that attempts to modify the object will result in an exception being thrown.</p>  */
public class SVGTransform extends jsweet.lang.Object {
    /** <p>Sets the transform type to <code>SVG_TRANSFORM_SKEWY</code>, with parameter <code>angle</code> defining the amount of skew.</p> <p><strong>Exceptions:</strong></p> <ul> <li>a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is raised when attempting to modify a read only attribute or when the object itself is read only.</li> </ul>  */
    public double angle;
    /** <p>Sets the transform type to <code>SVG_TRANSFORM_MATRIX</code>, with parameter matrix defining the new transformation. Note that the values from the parameter <code>matrix</code> are copied.</p> <p><strong>Exceptions:</strong></p> <ul> <li>a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is raised when attempting to modify a read only attribute or when the object itself is read only.</li> </ul>  */
    public SVGMatrix matrix;
    /** 
The type of the value as specified by one of the SVG_TRANSFORM_* constants defined on this interface. */
    public double type;
    /** <p>Sets the transform type to <code>SVG_TRANSFORM_MATRIX</code>, with parameter matrix defining the new transformation. Note that the values from the parameter <code>matrix</code> are copied.</p> <p><strong>Exceptions:</strong></p> <ul> <li>a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is raised when attempting to modify a read only attribute or when the object itself is read only.</li> </ul>  */
    native public void setMatrix(SVGMatrix matrix);
    /** <p>Sets the transform type to <code>SVG_TRANSFORM_ROTATE</code>, with parameter <code>angle</code> defining the rotation angle and parameters <code>cx</code> and <code>cy</code> defining the optional center of rotation.</p> <p><strong>Exceptions:</strong></p> <ul> <li>a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is raised when attempting to modify a read only attribute or when the object itself is read only.</li> </ul>  */
    native public void setRotate(double angle, double cx, double cy);
    /** <p>Sets the transform type to <code>SVG_TRANSFORM_SCALE</code>, with parameters <code>sx</code> and <code>sy</code> defining the scale amounts.</p> <p><strong>Exceptions:</strong></p> <ul> <li>a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is raised when attempting to modify a read only attribute or when the object itself is read only.</li> </ul>  */
    native public void setScale(double sx, double sy);
    /** <p>Sets the transform type to <code>SVG_TRANSFORM_SKEWX</code>, with parameter <code>angle</code> defining the amount of skew.</p> <p><strong>Exceptions:</strong></p> <ul> <li>a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is raised when attempting to modify a read only attribute or when the object itself is read only.</li> </ul>  */
    native public void setSkewX(double angle);
    /** <p>Sets the transform type to <code>SVG_TRANSFORM_SKEWY</code>, with parameter <code>angle</code> defining the amount of skew.</p> <p><strong>Exceptions:</strong></p> <ul> <li>a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is raised when attempting to modify a read only attribute or when the object itself is read only.</li> </ul>  */
    native public void setSkewY(double angle);
    /** <p>Sets the transform type to <code>SVG_TRANSFORM_TRANSLATE</code>, with parameters <code>tx</code> and <code>ty</code> defining the translation amounts.</p> <p><strong>Exceptions:</strong></p> <ul> <li>a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is raised when attempting to modify a read only attribute or when the object itself is read only.</li> </ul>  */
    native public void setTranslate(double tx, double ty);
    /** 
A <code>matrix(…)</code> transformation */
    public double SVG_TRANSFORM_MATRIX;
    /** 
A <code>rotate(…)</code> transformation */
    public double SVG_TRANSFORM_ROTATE;
    /** 
A <code>scale(…)</code> transformation */
    public double SVG_TRANSFORM_SCALE;
    /** 
A <code>skewx(…)</code> transformation */
    public double SVG_TRANSFORM_SKEWX;
    /** 
A <code>skewy(…)</code> transformation */
    public double SVG_TRANSFORM_SKEWY;
    /** 
A <code>translate(…)</code> transformation */
    public double SVG_TRANSFORM_TRANSLATE;
    /** 
The unit type is not one of predefined unit types. It is invalid to attempt to define a new value of this type or to attempt to switch an existing value to this type. */
    public double SVG_TRANSFORM_UNKNOWN;
    public static SVGTransform prototype;
    public SVGTransform(){}
}

