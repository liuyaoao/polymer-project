package jsweet.dom;
/** <p>The <strong><code>ValidityState</code></strong> interface represents the <em>validity states</em> that an element can be in, with respect to constraint validation. Together, they help explain why an element's value fails to validate, if it's not valid.</p>  */
public class ValidityState extends jsweet.lang.Object {
    /** 
 Is a <code>Boolean</code> indicating the user has provided input that the browser is unable to convert.  */
    public Boolean badInput;
    /** 
 Is a <code>Boolean</code> indicating the element's custom validity message has been set to a non-empty string by calling the element's <code>setCustomValidity()</code> method.  */
    public Boolean customError;
    /** 
 Is a <code>Boolean</code> indicating the value does not match the specified <code>pattern</code>.  */
    public Boolean patternMismatch;
    /** 
 Is a <code>Boolean</code> indicating the value is greater than the maximum specified by the <code>max</code> attribute.  */
    public Boolean rangeOverflow;
    /** 
 Is a <code>Boolean</code> indicating the value is less than the minimum specified by the <code>min</code> attribute.  */
    public Boolean rangeUnderflow;
    /** 
 Is a <code>Boolean</code> indicating the value does not fit the rules determined by the <code>step</code> attribute (that is, it's not evenly divisible by the step value).  */
    public Boolean stepMismatch;
    /** 
 Is a <code>Boolean</code> indicating the value exceeds the specified <code>maxlength</code> for <code>HTMLInputElement</code> or <code>HTMLTextAreaElement</code> objects. <em><strong>Note:</strong> This will never be <code>true</code> in Gecko, because elements' values are prevented from being longer than <code>maxlength</code>.</em>  */
    public Boolean tooLong;
    /** 
 Is a <code>Boolean</code> indicating the value is not in the required syntax (when <code>type</code> is <code>email</code> or <code>url</code>).  */
    public Boolean typeMismatch;
    /** 
 Is a <code>Boolean</code> indicating the element meets all constraint validations, and is therefore considered to be valid.  */
    public Boolean valid;
    /** 
 Is a <code>Boolean</code> indicating the element has a <code>required</code> attribute, but no value.  */
    public Boolean valueMissing;
    public static ValidityState prototype;
    public ValidityState(){}
}

