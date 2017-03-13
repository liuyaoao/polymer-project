package jsweet.dom;
/** <p>Many of SVG's graphics operations utilize 2x3 matrices of the form:</p> <pre>[a c e]
[b d f]</pre> <p>which, when expanded into a 3x3 matrix for the purposes of matrix arithmetic, become:</p> <pre>[a c e]
[b d f]
[0 0 1]
</pre> <p>An <code>SVGMatrix</code> object can be designated as read only, which means that attempts to modify the object will result in an exception being thrown.</p>  */
public class SVGMatrix extends jsweet.lang.Object {
    /** 
The <em>a</em> component of the matrix. */
    public double a;
    /** 
The <em>b</em> component of the matrix. */
    public double b;
    /** 
The <em>c</em> component of the matrix. */
    public double c;
    /** 
The <em>d</em> component of the matrix. */
    public double d;
    /** 
The <em>e</em> component of the matrix. */
    public double e;
    /** 
The <em>f</em> component of the matrix. */
    public double f;
    /** <div>
 Post-multiplies the transformation [-1&nbsp;0&nbsp;0&nbsp;1&nbsp;0&nbsp;0] and returns the resulting matrix. </div>  */
    native public SVGMatrix flipX();
    /** <div>
 Post-multiplies the transformation [1&nbsp;0&nbsp;0&nbsp;-1&nbsp;0&nbsp;0] and returns the resulting matrix. </div>  */
    native public SVGMatrix flipY();
    /** <p>Return the inverse matrix</p> <p><strong>Exceptions:</strong></p> <ul> <li>a <code>DOMException</code> with code <code>SVG_MATRIX_NOT_INVERTABLE</code> is raised if the matrix is not invertable.</li> </ul>  */
    native public SVGMatrix inverse();
    /** 
Performs matrix multiplication. This matrix is post-multiplied by another matrix, returning the resulting new matrix. */
    native public SVGMatrix multiply(SVGMatrix secondMatrix);
    /** <div>
 Post-multiplies a rotation transformation on the current matrix and returns the resulting matrix. ( <em>angle</em>&nbsp;is measures in degrees.) </div>  */
    native public SVGMatrix rotate(double angle);
    /** <p>Post-multiplies a rotation transformation on the current matrix and returns the resulting matrix. The rotation angle is determined by taking (+/-) atan(y/x). The direction of the vector (x,&nbsp;y) determines whether the positive or negative angle value is used.</p> <p><strong>Exceptions:</strong></p> <ul> <li>a <code>DOMException</code> with code <code>SVG_INVALID_VALUE_ERR</code> is raised if one of the parameters has an invalid value.</li> </ul>  */
    native public SVGMatrix rotateFromVector(double x, double y);
    /** <div>
 Post-multiplies a uniform scale transformation on the current matrix and returns the resulting matrix. </div>  */
    native public SVGMatrix scale(double scaleFactor);
    /** <div>
 Post-multiplies a non-uniform scale transformation on the current matrix and returns the resulting matrix. </div>  */
    native public SVGMatrix scaleNonUniform(double scaleFactorX, double scaleFactorY);
    /** <div>
 Post-multiplies a skewX transformation on the current matrix and returns the resulting matrix. </div>  */
    native public SVGMatrix skewX(double angle);
    /** <div>
 Post-multiplies a skewY transformation on the current matrix and returns the resulting matrix. </div>  */
    native public SVGMatrix skewY(double angle);
    /** <div>
 Post-multiplies a translation transformation on the current matrix and returns the resulting matrix. </div>  */
    native public SVGMatrix translate(double x, double y);
    public static SVGMatrix prototype;
    public SVGMatrix(){}
}

