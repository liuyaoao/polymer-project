package jsweet.lang;
import jsweet.util.function.Function4;
/** <p>The JavaScript <strong><code>Array</code></strong>&nbsp;object is a global object that&nbsp;is used in the&nbsp;construction&nbsp;of&nbsp;arrays; which are high-level, list-like objects.</p> <p><strong>Create an Array</strong></p> <pre>var fruits = [&quot;Apple&quot;, &quot;Banana&quot;];

console.log(fruits.length);
// 2
</pre> <p><strong>Access (index into) an Array item</strong></p> <pre>var first = fruits[0];
// Apple

var last = fruits[fruits.length - 1];
// Banana
</pre> <p><strong>Loop over an Array</strong></p> <pre>fruits.forEach(function (item, index, array) {
&nbsp; console.log(item, index);
});
// Apple 0
// Banana 1
</pre> <p><strong>Add to the end of an Array</strong></p> <pre>var newLength = fruits.push(&quot;Orange&quot;);
// [&quot;Apple&quot;, &quot;Banana&quot;, &quot;Orange&quot;]
</pre> <p><strong>Remove from the end of an Array</strong></p> <pre>var last = fruits.pop(); // remove Orange (from the end)
// [&quot;Apple&quot;, &quot;Banana&quot;];
</pre> <p><strong>Remove from the front of an Array</strong></p> <pre>var first = fruits.shift(); // remove Apple from the front
// [&quot;Banana&quot;];
</pre> <p><strong>Add to the front of an Array</strong></p> <pre>var newLength = fruits.unshift(&quot;Strawberry&quot;) // add to the front
// [&quot;Strawberry&quot;, &quot;Banana&quot;];
</pre> <p><strong>Find the index of an item in the Array</strong></p> <pre>fruits.push(&quot;Mango&quot;);
// [&quot;Strawberry&quot;, &quot;Banana&quot;, &quot;Mango&quot;]

var pos = fruits.indexOf(&quot;Banana&quot;);
// 1
</pre> <p><strong>Remove an item by Index Position</strong></p> <pre>var removedItem = fruits.splice(pos, 1); // this is how to remove an item
// [&quot;Strawberry&quot;, &quot;Mango&quot;]
</pre> <p><strong>Copy an Array</strong></p> <pre>var shallowCopy = fruits.slice(); // this is how to make a copy
// [&quot;Strawberry&quot;, &quot;Mango&quot;]
</pre>  */
public class Array<T> extends jsweet.lang.Object implements Iterable<T> {
    /**
      * Gets or sets the length of the array. This is a number one higher than the highest element defined in an array.
      */
    public double length;
    /**
      * Returns a string representation of an array.
      */
    native public java.lang.String toString();
    native public java.lang.String toLocaleString();
    /**
      * Appends new elements to an array, and returns the new length of the array.
      * @param items New elements of the Array.
      */
    native public double push(@SuppressWarnings("unchecked") T... items);
    /**
      * Removes the last element from an array and returns it.
      */
    native public T pop();
    /**
      * Combines two or more arrays.
      * @param items Additional items to add to the end of array1.
      */
    native public T[] concat(@SuppressWarnings("unchecked") T... items);
    /**
      * Adds all the elements of an array separated by the specified separator string.
      * @param separator A string used to separate one element of an array from the next in the resulting String. If omitted, the array elements are separated with a comma.
      */
    native public java.lang.String join(java.lang.String separator);
    /**
      * Reverses the elements in an Array. 
      */
    native public T[] reverse();
    /**
      * Removes the first element from an array and returns it.
      */
    native public T shift();
    /** 
      * Returns a section of an array.
      * @param start The beginning of the specified portion of the array.
      * @param end The end of the specified portion of the array.
      */
    native public T[] slice(double start, double end);
    /**
      * Sorts an array.
      * @param compareFn The name of the function used to determine the order of the elements. If omitted, the elements are sorted in ascending, ASCII character order.
      */
    native public T[] sort(java.util.function.BiFunction<T,T,Double> compareFn);
    /**
      * Removes elements from an array and, if necessary, inserts new elements in their place, returning the deleted elements.
      * @param start The zero-based location in the array from which to start removing elements.
      */
    native public T[] splice(double start);
    /**
      * Removes elements from an array and, if necessary, inserts new elements in their place, returning the deleted elements.
      * @param start The zero-based location in the array from which to start removing elements.
      * @param deleteCount The number of elements to remove.
      * @param items Elements to insert into the array in place of the deleted elements.
      */
    native public T[] splice(double start, double deleteCount, @SuppressWarnings("unchecked") T... items);
    /**
      * Inserts new elements at the start of an array.
      * @param items  Elements to insert at the start of the Array.
      */
    native public double unshift(@SuppressWarnings("unchecked") T... items);
    /**
      * Returns the index of the first occurrence of a value in an array.
      * @param searchElement The value to locate in the array.
      * @param fromIndex The array index at which to begin the search. If fromIndex is omitted, the search starts at index 0.
      */
    native public double indexOf(T searchElement, double fromIndex);
    /**
      * Returns the index of the last occurrence of a specified value in an array.
      * @param searchElement The value to locate in the array.
      * @param fromIndex The array index at which to begin the search. If fromIndex is omitted, the search starts at the last index in the array.
      */
    native public double lastIndexOf(T searchElement, double fromIndex);
    /**
      * Determines whether all the members of an array satisfy the specified test.
      * @param callbackfn A function that accepts up to three arguments. The every method calls the callbackfn function for each element in array1 until the callbackfn returns false, or until the end of the array.
      * @param thisArg An object to which the this keyword can refer in the callbackfn function. If thisArg is omitted, undefined is used as the this value.
      */
    native public java.lang.Boolean every(jsweet.util.function.TriFunction<T,Double,T[],java.lang.Boolean> callbackfn, java.lang.Object thisArg);
    /**
      * Determines whether the specified callback function returns true for any element of an array.
      * @param callbackfn A function that accepts up to three arguments. The some method calls the callbackfn function for each element in array1 until the callbackfn returns true, or until the end of the array.
      * @param thisArg An object to which the this keyword can refer in the callbackfn function. If thisArg is omitted, undefined is used as the this value.
      */
    native public java.lang.Boolean some(jsweet.util.function.TriFunction<T,Double,T[],java.lang.Boolean> callbackfn, java.lang.Object thisArg);
    /**
      * Performs the specified action for each element in an array.
      * @param callbackfn  A function that accepts up to three arguments. forEach calls the callbackfn function one time for each element in the array. 
      * @param thisArg  An object to which the this keyword can refer in the callbackfn function. If thisArg is omitted, undefined is used as the this value.
      */
    native public void forEach(jsweet.util.function.TriConsumer<T,Double,T[]> callbackfn, java.lang.Object thisArg);
    /**
      * Calls a defined callback function on each element of an array, and returns an array that contains the results.
      * @param callbackfn A function that accepts up to three arguments. The map method calls the callbackfn function one time for each element in the array. 
      * @param thisArg An object to which the this keyword can refer in the callbackfn function. If thisArg is omitted, undefined is used as the this value.
      */
    native public <U> U[] map(jsweet.util.function.TriFunction<T,Double,T[],U> callbackfn, java.lang.Object thisArg);
    /**
      * Returns the elements of an array that meet the condition specified in a callback function. 
      * @param callbackfn A function that accepts up to three arguments. The filter method calls the callbackfn function one time for each element in the array. 
      * @param thisArg An object to which the this keyword can refer in the callbackfn function. If thisArg is omitted, undefined is used as the this value.
      */
    native public T[] filter(jsweet.util.function.TriFunction<T,Double,T[],java.lang.Boolean> callbackfn, java.lang.Object thisArg);
    /**
      * Calls the specified callback function for all the elements in an array. The return value of the callback function is the accumulated result, and is provided as an argument in the next call to the callback function.
      * @param callbackfn A function that accepts up to four arguments. The reduce method calls the callbackfn function one time for each element in the array.
      * @param initialValue If initialValue is specified, it is used as the initial value to start the accumulation. The first call to the callbackfn function provides this value as an argument instead of an array value.
      */
    @jsweet.lang.Name("reduce")
    native public T reduceCallbackfnFunction4(Function4<T,T,Double,T[],T> callbackfn, InitialValueT<T> initialValue);
    /**
      * Calls the specified callback function for all the elements in an array. The return value of the callback function is the accumulated result, and is provided as an argument in the next call to the callback function.
      * @param callbackfn A function that accepts up to four arguments. The reduce method calls the callbackfn function one time for each element in the array.
      * @param initialValue If initialValue is specified, it is used as the initial value to start the accumulation. The first call to the callbackfn function provides this value as an argument instead of an array value.
      */
    @jsweet.lang.Name("reduce")
    native public <U> U reduceCallbackfnUUFunction4(Function4<U,T,Double,T[],U> callbackfn, InitialValueU<U> initialValue);
    /** 
      * Calls the specified callback function for all the elements in an array, in descending order. The return value of the callback function is the accumulated result, and is provided as an argument in the next call to the callback function.
      * @param callbackfn A function that accepts up to four arguments. The reduceRight method calls the callbackfn function one time for each element in the array. 
      * @param initialValue If initialValue is specified, it is used as the initial value to start the accumulation. The first call to the callbackfn function provides this value as an argument instead of an array value.
      */
    @jsweet.lang.Name("reduceRight")
    native public T reduceRightCallbackfnFunction4(Function4<T,T,Double,T[],T> callbackfn, InitialValueT<T> initialValue);
    /** 
      * Calls the specified callback function for all the elements in an array, in descending order. The return value of the callback function is the accumulated result, and is provided as an argument in the next call to the callback function.
      * @param callbackfn A function that accepts up to four arguments. The reduceRight method calls the callbackfn function one time for each element in the array. 
      * @param initialValue If initialValue is specified, it is used as the initial value to start the accumulation. The first call to the callbackfn function provides this value as an argument instead of an array value.
      */
    @jsweet.lang.Name("reduceRight")
    native public <U> U reduceRightCallbackfnUUFunction4(Function4<U,T,Double,T[],U> callbackfn, InitialValueU<U> initialValue);
    native public T $get(double n);
    public Array(double arrayLength){}
    public Array(@SuppressWarnings("unchecked") T... items){}
    native public static java.lang.Object[] applyStatic(double arrayLength);
    native public static <T> T[] applyStatic(@SuppressWarnings("unchecked") T... items);
    /** 
 Returns true if a variable is an array, if not false.  */
    native public static java.lang.Boolean isArray(java.lang.Object arg);
    /** 
 Allows the addition of properties to all array objects.  */
    public static final Array<?> prototype=null;
    native public <R> R reduce(java.util.function.BiFunction<R,T,R> callbackfn, R initialValue);
    /**
      * Adds all the elements of an array separated by the specified separator string.
      * @param separator A string used to separate one element of an array from the next in the resulting String. If omitted, the array elements are separated with a comma.
      */
    native public java.lang.String join();
    /** 
      * Returns a section of an array.
      * @param start The beginning of the specified portion of the array.
      * @param end The end of the specified portion of the array.
      */
    native public T[] slice(double start);
    /** 
      * Returns a section of an array.
      * @param start The beginning of the specified portion of the array.
      * @param end The end of the specified portion of the array.
      */
    native public T[] slice();
    /**
      * Sorts an array.
      * @param compareFn The name of the function used to determine the order of the elements. If omitted, the elements are sorted in ascending, ASCII character order.
      */
    native public T[] sort();
    /**
      * Returns the index of the first occurrence of a value in an array.
      * @param searchElement The value to locate in the array.
      * @param fromIndex The array index at which to begin the search. If fromIndex is omitted, the search starts at index 0.
      */
    native public double indexOf(T searchElement);
    /**
      * Returns the index of the last occurrence of a specified value in an array.
      * @param searchElement The value to locate in the array.
      * @param fromIndex The array index at which to begin the search. If fromIndex is omitted, the search starts at the last index in the array.
      */
    native public double lastIndexOf(T searchElement);
    /**
      * Determines whether all the members of an array satisfy the specified test.
      * @param callbackfn A function that accepts up to three arguments. The every method calls the callbackfn function for each element in array1 until the callbackfn returns false, or until the end of the array.
      * @param thisArg An object to which the this keyword can refer in the callbackfn function. If thisArg is omitted, undefined is used as the this value.
      */
    native public java.lang.Boolean every(jsweet.util.function.TriFunction<T,Double,T[],java.lang.Boolean> callbackfn);
    /**
      * Determines whether the specified callback function returns true for any element of an array.
      * @param callbackfn A function that accepts up to three arguments. The some method calls the callbackfn function for each element in array1 until the callbackfn returns true, or until the end of the array.
      * @param thisArg An object to which the this keyword can refer in the callbackfn function. If thisArg is omitted, undefined is used as the this value.
      */
    native public java.lang.Boolean some(jsweet.util.function.TriFunction<T,Double,T[],java.lang.Boolean> callbackfn);
    /**
      * Performs the specified action for each element in an array.
      * @param callbackfn  A function that accepts up to three arguments. forEach calls the callbackfn function one time for each element in the array. 
      * @param thisArg  An object to which the this keyword can refer in the callbackfn function. If thisArg is omitted, undefined is used as the this value.
      */
    native public void forEach(jsweet.util.function.TriConsumer<T,Double,T[]> callbackfn);
    /**
      * Calls a defined callback function on each element of an array, and returns an array that contains the results.
      * @param callbackfn A function that accepts up to three arguments. The map method calls the callbackfn function one time for each element in the array. 
      * @param thisArg An object to which the this keyword can refer in the callbackfn function. If thisArg is omitted, undefined is used as the this value.
      */
    native public <U> U[] map(jsweet.util.function.TriFunction<T,Double,T[],U> callbackfn);
    /**
      * Returns the elements of an array that meet the condition specified in a callback function. 
      * @param callbackfn A function that accepts up to three arguments. The filter method calls the callbackfn function one time for each element in the array. 
      * @param thisArg An object to which the this keyword can refer in the callbackfn function. If thisArg is omitted, undefined is used as the this value.
      */
    native public T[] filter(jsweet.util.function.TriFunction<T,Double,T[],java.lang.Boolean> callbackfn);
    /**
      * Calls the specified callback function for all the elements in an array. The return value of the callback function is the accumulated result, and is provided as an argument in the next call to the callback function.
      * @param callbackfn A function that accepts up to four arguments. The reduce method calls the callbackfn function one time for each element in the array.
      * @param initialValue If initialValue is specified, it is used as the initial value to start the accumulation. The first call to the callbackfn function provides this value as an argument instead of an array value.
      */
    native public T reduce(Function4<T,T,Double,T[],T> callbackfn);
    /** 
      * Calls the specified callback function for all the elements in an array, in descending order. The return value of the callback function is the accumulated result, and is provided as an argument in the next call to the callback function.
      * @param callbackfn A function that accepts up to four arguments. The reduceRight method calls the callbackfn function one time for each element in the array. 
      * @param initialValue If initialValue is specified, it is used as the initial value to start the accumulation. The first call to the callbackfn function provides this value as an argument instead of an array value.
      */
    native public T reduceRight(Function4<T,T,Double,T[],T> callbackfn);
    public Array(){}
    native public static java.lang.Object[] applyStatic();
    native public <R> R reduce(java.util.function.BiFunction<R,T,R> callbackfn);
    /**
      * Combines two or more arrays.
      * @param items Additional items to add to the end of array1.
      */
    native public T[] concat(@SuppressWarnings("unchecked") T[]... items);
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<T> iterator();
    /** This class was automatically generated for disambiguating erased method signatures. */
    @jsweet.lang.Erased
    public static class InitialValueT<T> extends jsweet.lang.Object {
        public InitialValueT(T initialValue){}
    }
    /** This class was automatically generated for disambiguating erased method signatures. */
    @jsweet.lang.Erased
    public static class InitialValueU<U> extends jsweet.lang.Object {
        public InitialValueU(U initialValue){}
    }
}

