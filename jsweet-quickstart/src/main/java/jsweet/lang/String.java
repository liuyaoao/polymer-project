package jsweet.lang;
/** <p>The <strong><code>String</code></strong> global object is a constructor for strings, or a sequence of characters.</p>  */
public class String extends jsweet.lang.Object implements Iterable<java.lang.String> {
    /** Returns a string representation of a string. */
    native public java.lang.String toString();
    /**
      * Returns the character at the specified index.
      * @param pos The zero-based index of the desired character.
      */
    native public java.lang.String charAt(double pos);
    /** 
      * Returns the Unicode value of the character at the specified location.
      * @param index The zero-based index of the desired character. If there is no character at the specified index, NaN is returned.
      */
    native public double charCodeAt(double index);
    /**
      * Returns a string that contains the concatenation of two or more strings.
      * @param strings The strings to append to the end of the string.  
      */
    native public java.lang.String concat(java.lang.String... strings);
    /**
      * Returns the position of the first occurrence of a substring. 
      * @param searchString The substring to search for in the string
      * @param position The index at which to begin searching the String object. If omitted, search starts at the beginning of the string.
      */
    native public double indexOf(java.lang.String searchString, double position);
    /**
      * Returns the last occurrence of a substring in the string.
      * @param searchString The substring to search for.
      * @param position The index at which to begin searching. If omitted, the search begins at the end of the string.
      */
    native public double lastIndexOf(java.lang.String searchString, double position);
    /**
      * Determines whether two strings are equivalent in the current locale.
      * @param that String to compare to target string
      */
    native public double localeCompare(java.lang.String that);
    /** 
      * Matches a string with a regular expression, and returns an array containing the results of that search.
      * @param regexp A variable name or string literal containing the regular expression pattern and flags.
      */
    native public RegExpMatchArray match(java.lang.String regexp);
    /** 
      * Matches a string with a regular expression, and returns an array containing the results of that search.
      * @param regexp A regular expression object that contains the regular expression pattern and applicable flags. 
      */
    native public RegExpMatchArray match(RegExp regexp);
    /**
      * Replaces text in a string, using a regular expression or search string.
      * @param searchValue A string that represents the regular expression.
      * @param replaceValue A string containing the text to replace for every successful match of searchValue in this string.
      */
    native public java.lang.String replace(java.lang.String searchValue, java.lang.String replaceValue);
    /**
      * Replaces text in a string, using a regular expression or search string.
      * @param searchValue A string that represents the regular expression.
      * @param replacer A function that returns the replacement text.
      */
    native public java.lang.String replace(java.lang.String searchValue, java.util.function.BiFunction<java.lang.String,java.lang.Object,java.lang.String> replacer);
    /**
      * Replaces text in a string, using a regular expression or search string.
      * @param searchValue A Regular Expression object containing the regular expression pattern and applicable flags.
      * @param replaceValue A string containing the text to replace for every successful match of searchValue in this string.
      */
    native public java.lang.String replace(RegExp searchValue, java.lang.String replaceValue);
    /**
      * Replaces text in a string, using a regular expression or search string.
      * @param searchValue A Regular Expression object containing the regular expression pattern and applicable flags
      * @param replacer A function that returns the replacement text.
      */
    native public java.lang.String replace(RegExp searchValue, java.util.function.BiFunction<java.lang.String,java.lang.Object,java.lang.String> replacer);
    /**
      * Finds the first substring match in a regular expression search.
      * @param regexp The regular expression pattern and applicable flags. 
      */
    native public double search(java.lang.String regexp);
    /**
      * Finds the first substring match in a regular expression search.
      * @param regexp The regular expression pattern and applicable flags. 
      */
    native public double search(RegExp regexp);
    /**
      * Returns a section of a string.
      * @param start The index to the beginning of the specified portion of stringObj. 
      * @param end The index to the end of the specified portion of stringObj. The substring includes the characters up to, but not including, the character indicated by end. 
      * If this value is not specified, the substring continues to the end of stringObj.
      */
    native public java.lang.String slice(double start, double end);
    /**
      * Split a string into substrings using the specified separator and return them as an array.
      * @param separator A string that identifies character or characters to use in separating the string. If omitted, a single-element array containing the entire string is returned. 
      * @param limit A value used to limit the number of elements returned in the array.
      */
    native public java.lang.String[] split(java.lang.String separator, double limit);
    /**
      * Split a string into substrings using the specified separator and return them as an array.
      * @param separator A Regular Express that identifies character or characters to use in separating the string. If omitted, a single-element array containing the entire string is returned. 
      * @param limit A value used to limit the number of elements returned in the array.
      */
    native public java.lang.String[] split(RegExp separator, double limit);
    /**
      * Returns the substring at the specified location within a String object. 
      * @param start The zero-based index number indicating the beginning of the substring.
      * @param end Zero-based index number indicating the end of the substring. The substring includes the characters up to, but not including, the character indicated by end.
      * If end is omitted, the characters from start through the end of the original string are returned.
      */
    native public java.lang.String substring(double start, double end);
    /** Converts all the alphabetic characters in a string to lowercase. */
    native public java.lang.String toLowerCase();
    /** Converts all alphabetic characters to lowercase, taking into account the host environment's current locale. */
    native public java.lang.String toLocaleLowerCase();
    /** Converts all the alphabetic characters in a string to uppercase. */
    native public java.lang.String toUpperCase();
    /** Returns a string where all alphabetic characters have been converted to uppercase, taking into account the host environment's current locale. */
    native public java.lang.String toLocaleUpperCase();
    /** Removes the leading and trailing white space and line terminator characters from a string. */
    native public java.lang.String trim();
    /** Returns the length of a String object. */
    public final double length=0;
    /**
      * Gets a substring beginning at the specified location and having the specified length.
      * @param from The starting position of the desired substring. The index of the first character in the string is zero.
      * @param length The number of characters to include in the returned substring.
      */
    native public java.lang.String substr(double from, double length);
    /** Returns the primitive value of the specified object. */
    native public java.lang.String valueOf();
    native public java.lang.String $get(double index);
    public String(java.lang.Object value){}
    native public static java.lang.String applyStatic(java.lang.Object value);
    /** 
 Allows the addition of properties to a <code>String</code> object.  */
    public static final java.lang.String prototype=null;
    /** 
 Returns a string created by using the specified sequence of Unicode values.  */
    native public static java.lang.String fromCharCode(double... codes);
    /**
      * Determines whether two strings are equivalent in the current locale.
      * @param that String to compare to target string
      * @param locales An array of locale strings that contain one or more language or locale tags. If you include more than one locale string, list them in descending order of priority so that the first entry is the preferred locale. If you omit this parameter, the default locale of the JavaScript runtime is used. This parameter must conform to BCP 47 standards; see the Intl.Collator object for details.
      * @param options An object that contains one or more properties that specify comparison options. see the Intl.Collator object for details.
      */
    native public double localeCompare(java.lang.String that, java.lang.String[] locales, jsweet.dom.intl.CollatorOptions options);
    /**
      * Determines whether two strings are equivalent in the current locale.
      * @param that String to compare to target string
      * @param locale Locale tag. If you omit this parameter, the default locale of the JavaScript runtime is used. This parameter must conform to BCP 47 standards; see the Intl.Collator object for details.
      * @param options An object that contains one or more properties that specify comparison options. see the Intl.Collator object for details.
      */
    native public double localeCompare(java.lang.String that, java.lang.String locale, jsweet.dom.intl.CollatorOptions options);
    /**
      * Returns the position of the first occurrence of a substring. 
      * @param searchString The substring to search for in the string
      * @param position The index at which to begin searching the String object. If omitted, search starts at the beginning of the string.
      */
    native public double indexOf(java.lang.String searchString);
    /**
      * Returns the last occurrence of a substring in the string.
      * @param searchString The substring to search for.
      * @param position The index at which to begin searching. If omitted, the search begins at the end of the string.
      */
    native public double lastIndexOf(java.lang.String searchString);
    /**
      * Returns a section of a string.
      * @param start The index to the beginning of the specified portion of stringObj. 
      * @param end The index to the end of the specified portion of stringObj. The substring includes the characters up to, but not including, the character indicated by end. 
      * If this value is not specified, the substring continues to the end of stringObj.
      */
    native public java.lang.String slice(double start);
    /**
      * Returns a section of a string.
      * @param start The index to the beginning of the specified portion of stringObj. 
      * @param end The index to the end of the specified portion of stringObj. The substring includes the characters up to, but not including, the character indicated by end. 
      * If this value is not specified, the substring continues to the end of stringObj.
      */
    native public java.lang.String slice();
    /**
      * Split a string into substrings using the specified separator and return them as an array.
      * @param separator A string that identifies character or characters to use in separating the string. If omitted, a single-element array containing the entire string is returned. 
      * @param limit A value used to limit the number of elements returned in the array.
      */
    native public java.lang.String[] split(java.lang.String separator);
    /**
      * Split a string into substrings using the specified separator and return them as an array.
      * @param separator A Regular Express that identifies character or characters to use in separating the string. If omitted, a single-element array containing the entire string is returned. 
      * @param limit A value used to limit the number of elements returned in the array.
      */
    native public java.lang.String[] split(RegExp separator);
    /**
      * Returns the substring at the specified location within a String object. 
      * @param start The zero-based index number indicating the beginning of the substring.
      * @param end Zero-based index number indicating the end of the substring. The substring includes the characters up to, but not including, the character indicated by end.
      * If end is omitted, the characters from start through the end of the original string are returned.
      */
    native public java.lang.String substring(double start);
    /**
      * Gets a substring beginning at the specified location and having the specified length.
      * @param from The starting position of the desired substring. The index of the first character in the string is zero.
      * @param length The number of characters to include in the returned substring.
      */
    native public java.lang.String substr(double from);
    public String(){}
    native public static java.lang.String applyStatic();
    /**
      * Determines whether two strings are equivalent in the current locale.
      * @param that String to compare to target string
      * @param locales An array of locale strings that contain one or more language or locale tags. If you include more than one locale string, list them in descending order of priority so that the first entry is the preferred locale. If you omit this parameter, the default locale of the JavaScript runtime is used. This parameter must conform to BCP 47 standards; see the Intl.Collator object for details.
      * @param options An object that contains one or more properties that specify comparison options. see the Intl.Collator object for details.
      */
    native public double localeCompare(java.lang.String that, java.lang.String[] locales);
    /**
      * Determines whether two strings are equivalent in the current locale.
      * @param that String to compare to target string
      * @param locale Locale tag. If you omit this parameter, the default locale of the JavaScript runtime is used. This parameter must conform to BCP 47 standards; see the Intl.Collator object for details.
      * @param options An object that contains one or more properties that specify comparison options. see the Intl.Collator object for details.
      */
    native public double localeCompare(java.lang.String that, java.lang.String locale);
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<java.lang.String> iterator();
}

