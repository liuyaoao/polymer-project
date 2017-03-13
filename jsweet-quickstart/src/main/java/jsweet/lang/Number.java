package jsweet.lang;
/** <p>The <strong><code>Number</code></strong> JavaScript object is a wrapper object allowing you to work with numerical values. A <code>Number</code> object is created using the <code>Number()</code> constructor.</p>  */
public class Number extends jsweet.lang.Object {
    /**
      * Returns a string representation of an object.
      * @param radix Specifies a radix for converting numeric values to strings. This value is only used for numbers.
      */
    native public java.lang.String toString(double radix);
    /** 
      * Returns a string representing a number in fixed-point notation.
      * @param fractionDigits Number of digits after the decimal point. Must be in the range 0 - 20, inclusive.
      */
    native public java.lang.String toFixed(double fractionDigits);
    /**
      * Returns a string containing a number represented in exponential notation.
      * @param fractionDigits Number of digits after the decimal point. Must be in the range 0 - 20, inclusive.
      */
    native public java.lang.String toExponential(double fractionDigits);
    /**
      * Returns a string containing a number represented either in exponential or fixed-point notation with a specified number of digits.
      * @param precision Number of significant digits. Must be in the range 1 - 21, inclusive.
      */
    native public java.lang.String toPrecision(double precision);
    /** Returns the primitive value of the specified object. */
    native public Number valueOf();
    public Number(java.lang.Object value){}
    native public static Number applyStatic(java.lang.Object value);
    /** 
 Allows the addition of properties to a <code>Number</code> object.  */
    public static final Number prototype=null;
    /** The largest number that can be represented in JavaScript. Equal to approximately 1.79E+308. */
    public static final double MAX_VALUE=0;
    /** The closest number to zero that can be represented in JavaScript. Equal to approximately 5.00E-324. */
    public static final double MIN_VALUE=0;
    /** 
      * A value that is not a number.
      * In equality comparisons, NaN does not equal any value, including itself. To test whether a value is equivalent to NaN, use the isNaN function.
      */
    public static final double NaN=0;
    /** 
      * A value that is less than the largest negative number that can be represented in JavaScript.
      * JavaScript displays NEGATIVE_INFINITY values as -infinity. 
      */
    public static final double NEGATIVE_INFINITY=0;
    /**
      * A value greater than the largest number that can be represented in JavaScript. 
      * JavaScript displays POSITIVE_INFINITY values as infinity. 
      */
    public static final double POSITIVE_INFINITY=0;
    /**
      * Converts a number to a string by using the current or specified locale. 
      * @param locales An array of locale strings that contain one or more language or locale tags. If you include more than one locale string, list them in descending order of priority so that the first entry is the preferred locale. If you omit this parameter, the default locale of the JavaScript runtime is used.
      * @param options An object that contains one or more properties that specify comparison options.
      */
    native public java.lang.String toLocaleString(java.lang.String[] locales, jsweet.dom.intl.NumberFormatOptions options);
    /**
      * Converts a number to a string by using the current or specified locale. 
      * @param locale Locale tag. If you omit this parameter, the default locale of the JavaScript runtime is used.
      * @param options An object that contains one or more properties that specify comparison options.
      */
    native public java.lang.String toLocaleString(java.lang.String locale, jsweet.dom.intl.NumberFormatOptions options);
    /**
      * Returns a string representation of an object.
      * @param radix Specifies a radix for converting numeric values to strings. This value is only used for numbers.
      */
    native public java.lang.String toString();
    /** 
      * Returns a string representing a number in fixed-point notation.
      * @param fractionDigits Number of digits after the decimal point. Must be in the range 0 - 20, inclusive.
      */
    native public java.lang.String toFixed();
    /**
      * Returns a string containing a number represented in exponential notation.
      * @param fractionDigits Number of digits after the decimal point. Must be in the range 0 - 20, inclusive.
      */
    native public java.lang.String toExponential();
    /**
      * Returns a string containing a number represented either in exponential or fixed-point notation with a specified number of digits.
      * @param precision Number of significant digits. Must be in the range 1 - 21, inclusive.
      */
    native public java.lang.String toPrecision();
    public Number(){}
    native public static Number applyStatic();
    /**
      * Converts a number to a string by using the current or specified locale. 
      * @param locales An array of locale strings that contain one or more language or locale tags. If you include more than one locale string, list them in descending order of priority so that the first entry is the preferred locale. If you omit this parameter, the default locale of the JavaScript runtime is used.
      * @param options An object that contains one or more properties that specify comparison options.
      */
    native public java.lang.String toLocaleString(java.lang.String[] locales);
    /**
      * Converts a number to a string by using the current or specified locale. 
      * @param locales An array of locale strings that contain one or more language or locale tags. If you include more than one locale string, list them in descending order of priority so that the first entry is the preferred locale. If you omit this parameter, the default locale of the JavaScript runtime is used.
      * @param options An object that contains one or more properties that specify comparison options.
      */
    native public java.lang.String toLocaleString();
    /**
      * Converts a number to a string by using the current or specified locale. 
      * @param locale Locale tag. If you omit this parameter, the default locale of the JavaScript runtime is used.
      * @param options An object that contains one or more properties that specify comparison options.
      */
    native public java.lang.String toLocaleString(java.lang.String locale);
}

