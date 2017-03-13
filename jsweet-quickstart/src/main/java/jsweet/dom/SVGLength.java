package jsweet.dom;
/** <p>The <code>SVGLength</code> interface correspond to the &lt;length&gt; basic data type.</p> <p>An <code>SVGLength</code> object can be designated as read only, which means that attempts to modify the object will result in an exception being thrown.</p>  */
public class SVGLength extends jsweet.lang.Object {
    /** 
Preserve the same underlying stored value, but reset the stored unit identifier to the given <code><em>unitType</em></code>. Object attributes <code>unitType</code>, <code>valueInSpecifiedUnits</code> and <code>valueAsString</code> might be modified as a result of this method. For example, if the original value were &quot;<em>0.5cm</em>&quot; and the method was invoked to convert to millimeters, then the <code>unitType</code> would be changed to <code>SVG_LENGTHTYPE_MM</code>, <code>valueInSpecifiedUnits</code> would be changed to the numeric value 5 and <code>valueAsString</code> would be changed to &quot;<em>5mm</em>&quot;. */
    public double unitType;
    /** <p>The value as a floating point value, in user units. Setting this attribute will cause <code>valueInSpecifiedUnits</code> and <code>valueAsString</code> to be updated automatically to reflect this setting.</p> <p><strong>Exceptions on setting:</strong> a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is raised when the length corresponds to a read only attribute or when the object itself is read only.</p>  */
    public double value;
    /** <p>The value as a string value, in the units expressed by <code>unitType</code>. Setting this attribute will cause <code>value</code>, <code>valueInSpecifiedUnits</code> and <code>unitType</code> to be updated automatically to reflect this setting.</p> <p><strong>Exceptions on setting:</strong></p> <ul> <li>a <code>DOMException</code> with code <code>SYNTAX_ERR</code> is raised if the assigned string cannot be parsed as a valid &lt;length&gt;.</li> <li>a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is raised when the length corresponds to a read only attribute or when the object itself is read only.</li> </ul>  */
    public String valueAsString;
    /** <p>Reset the value as a number with an associated unitType, thereby replacing the values for all of the attributes on the object.</p> <p><strong>Exceptions:</strong></p> <ul> <li>a <code>DOMException</code> with code <code>NOT_SUPPORTED_ERR</code> is raised if <code>unitType</code> is <code>SVG_LENGTHTYPE_UNKNOWN</code> or not a valid unit type constant (one of the other <code>SVG_LENGTHTYPE_*</code> constants defined on this interface).</li> <li>a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is raised when the length corresponds to a read only attribute or when the object itself is read only.</li> </ul>  */
    public double valueInSpecifiedUnits;
    /** 
Preserve the same underlying stored value, but reset the stored unit identifier to the given <code><em>unitType</em></code>. Object attributes <code>unitType</code>, <code>valueInSpecifiedUnits</code> and <code>valueAsString</code> might be modified as a result of this method. For example, if the original value were &quot;<em>0.5cm</em>&quot; and the method was invoked to convert to millimeters, then the <code>unitType</code> would be changed to <code>SVG_LENGTHTYPE_MM</code>, <code>valueInSpecifiedUnits</code> would be changed to the numeric value 5 and <code>valueAsString</code> would be changed to &quot;<em>5mm</em>&quot;. */
    native public void convertToSpecifiedUnits(double unitType);
    /** <p>Reset the value as a number with an associated unitType, thereby replacing the values for all of the attributes on the object.</p> <p><strong>Exceptions:</strong></p> <ul> <li>a <code>DOMException</code> with code <code>NOT_SUPPORTED_ERR</code> is raised if <code>unitType</code> is <code>SVG_LENGTHTYPE_UNKNOWN</code> or not a valid unit type constant (one of the other <code>SVG_LENGTHTYPE_*</code> constants defined on this interface).</li> <li>a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is raised when the length corresponds to a read only attribute or when the object itself is read only.</li> </ul>  */
    native public void newValueSpecifiedUnits(double unitType, double valueInSpecifiedUnits);
    public double SVG_LENGTHTYPE_CM;
    public double SVG_LENGTHTYPE_EMS;
    public double SVG_LENGTHTYPE_EXS;
    public double SVG_LENGTHTYPE_IN;
    public double SVG_LENGTHTYPE_MM;
    public double SVG_LENGTHTYPE_NUMBER;
    public double SVG_LENGTHTYPE_PC;
    public double SVG_LENGTHTYPE_PERCENTAGE;
    public double SVG_LENGTHTYPE_PT;
    public double SVG_LENGTHTYPE_PX;
    /** 
The unit type is not one of predefined unit types. It is invalid to attempt to define a new value of this type or to attempt to switch an existing value to this type. */
    public double SVG_LENGTHTYPE_UNKNOWN;
    public static SVGLength prototype;
    public SVGLength(){}
}

