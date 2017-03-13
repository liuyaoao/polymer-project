package jsweet.dom;
/** <p>The <code>SVGAngle</code> interface correspond to the &lt;angle&gt; basic data type.</p> <p>An <code>SVGAngle</code> object can be designated as read only, which means that attempts to modify the object will result in an exception being thrown.</p>  */
public class SVGAngle extends jsweet.lang.Object {
    /** 
Preserve the same underlying stored value, but reset the stored unit identifier to the given <code><em>unitType</em></code>. Object attributes <code>unitType</code>, <code>valueInSpecifiedUnits</code> and <code>valueAsString</code> might be modified as a result of this method. */
    public double unitType;
    /** <p>The value as a floating point value, in user units. Setting this attribute will cause <code>valueInSpecifiedUnits</code> and <code>valueAsString</code> to be updated automatically to reflect this setting.</p> <p><strong>Exceptions on setting:</strong> a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is raised when the length corresponds to a read only attribute or when the object itself is read only.</p>  */
    public double value;
    /** <p>The value as a string value, in the units expressed by <code>unitType</code>. Setting this attribute will cause <code>value</code>, <code>valueInSpecifiedUnits</code> and <code>unitType</code> to be updated automatically to reflect this setting.</p> <p><strong>Exceptions on setting:</strong></p> <ul> <li>a <code>DOMException</code> with code <code>SYNTAX_ERR</code> is raised if the assigned string cannot be parsed as a valid &lt;angle&gt;.</li> <li>a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is raised when the length corresponds to a read only attribute or when the object itself is read only.</li> </ul>  */
    public String valueAsString;
    /** <p>Reset the value as a number with an associated unitType, thereby replacing the values for all of the attributes on the object.</p> <p><strong>Exceptions:</strong></p> <ul> <li>a <code>DOMException</code> with code <code>NOT_SUPPORTED_ERR</code> is raised if <code>unitType</code> is <code>SVG_ANGLETYPE_UNKNOWN</code> or not a valid unit type constant (one of the other <code>SVG_ANGLETYPE_*</code> constants defined on this interface).</li> <li>a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is raised when the length corresponds to a read only attribute or when the object itself is read only.</li> </ul>  */
    public double valueInSpecifiedUnits;
    /** 
Preserve the same underlying stored value, but reset the stored unit identifier to the given <code><em>unitType</em></code>. Object attributes <code>unitType</code>, <code>valueInSpecifiedUnits</code> and <code>valueAsString</code> might be modified as a result of this method. */
    native public void convertToSpecifiedUnits(double unitType);
    /** <p>Reset the value as a number with an associated unitType, thereby replacing the values for all of the attributes on the object.</p> <p><strong>Exceptions:</strong></p> <ul> <li>a <code>DOMException</code> with code <code>NOT_SUPPORTED_ERR</code> is raised if <code>unitType</code> is <code>SVG_ANGLETYPE_UNKNOWN</code> or not a valid unit type constant (one of the other <code>SVG_ANGLETYPE_*</code> constants defined on this interface).</li> <li>a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is raised when the length corresponds to a read only attribute or when the object itself is read only.</li> </ul>  */
    native public void newValueSpecifiedUnits(double unitType, double valueInSpecifiedUnits);
    /** 
The unit type was explicitly set to degrees. */
    public double SVG_ANGLETYPE_DEG;
    /** 
The unit type is gradians. */
    public double SVG_ANGLETYPE_GRAD;
    /** 
The unit type is radians. */
    public double SVG_ANGLETYPE_RAD;
    /** 
The unit type is not one of predefined unit types. It is invalid to attempt to define a new value of this type or to attempt to switch an existing value to this type. */
    public double SVG_ANGLETYPE_UNKNOWN;
    public double SVG_ANGLETYPE_UNSPECIFIED;
    public static SVGAngle prototype;
    public SVGAngle(){}
}

