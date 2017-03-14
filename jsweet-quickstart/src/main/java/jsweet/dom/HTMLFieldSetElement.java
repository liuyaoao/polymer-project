package jsweet.dom;
/** <div>
 &nbsp; </div> <p>The <code>HTMLFieldSetElement</code> interface has special properties and methods (beyond the regular <code>HTMLelement</code> interface it also has available to it by inheritance) for manipulating the layout and presentation of field-set elements.</p>  */
public class HTMLFieldSetElement extends HTMLElement {
    /**
      * Sets or retrieves how the object is aligned with adjacent text.
      */
    public String align;
    /** 
Reflects the <code>disabled</code> HTML attribute, indicating whether the user can interact with the control. */
    public Boolean disabled;
    /**
      * Retrieves a reference to the form that the object is embedded in.
      */
    public HTMLFormElement form;
    /**
      * Returns the error message that would be displayed if the user submits the form, or an empty string if no error message. It also triggers the standard error message, such as "this is a required field". The result is that the user sees validation messages without actually submitting.
      */
    public String validationMessage;
    /**
      * Returns a  ValidityState object that represents the validity states of an element.
      */
    public ValidityState validity;
    /**
      * Returns whether an element will successfully validate based on forms validation rules and constraints.
      */
    public Boolean willValidate;
    /**
      * Returns whether a form will validate when it is submitted, without having to submit it.
      */
    native public Boolean checkValidity();
    /**
      * Sets a custom error message that is displayed when a form is submitted.
      * @param error Sets a custom error message that is displayed when a form is submitted.
      */
    native public void setCustomValidity(String error);
    public static HTMLFieldSetElement prototype;
    public HTMLFieldSetElement(){}
}
