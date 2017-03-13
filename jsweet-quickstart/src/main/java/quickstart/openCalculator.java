package quickstart;

import static jsweet.dom.Globals.document;
//import static jsweet.dom.Globals.object;


import jsweet.dom.HTMLElement;
import jsweet.dom.CustomEvent;
import jsweet.dom.Document;
import jsweet.dom.Element;
import jsweet.lang.Function;
import jsweet.lang.Object;
import jsweet.lang.JSON;
import jsweet.dom.HTMLTemplateElement;
import jsweet.dom.Node;
import jsweet.dom.NodeListOf;

public class openCalculator {

//	public static void main(String[] args) {
//		// TODO Auto-generated method stub
////		new openCalculator();
//	}

	public openCalculator(){
		
		CustomElement cusele = new CustomElement();
		Object obj = new Object(); 
		obj.$set("prototype", cusele);
		document.registerElement("open-calculator",obj);

	}
}
//
class CustomElement extends HTMLElement{
	private HTMLElement shadowRoot;
	private Boolean decimalAdded=false;
	private jsweet.dom.Document thisDoc;
	private Function createShadowRoot = (Function)this.$get("createShadowRoot");
	public void createdCallback(){
		shadowRoot = (HTMLElement)this.createShadowRoot.apply(null);
		this.thisDoc = (jsweet.dom.Document)document.currentScript.ownerDocument;
		HTMLTemplateElement tmpl = (HTMLTemplateElement)thisDoc.querySelector("template");
	     Node clone = thisDoc.importNode(tmpl.content, true);
	     shadowRoot.appendChild(clone);
	     
	     if((Boolean)JSON.parse(this.getAttribute("hide-top"))){
	    	 HTMLElement ele = (HTMLElement)shadowRoot.querySelector("#calculator .top");
	    	 ele.style.display = "none";
//	    	 ele.$set("style.display", "none"); //style.display = "none";
	     }

	     //Get all this keys from shadowRoot
	     NodeListOf<Element> keys = shadowRoot.querySelectorAll("#calculator span");
	     Element calculatorScreen = shadowRoot.querySelector("#calculator .top");
	     String operators = "+-x/";


	     //add onclick event to all this keys and perform operations
	     for(int i=0;i<keys.length;i++){
	    	 Element tempEle = (Element) keys.$get(i);
	    	 tempEle.addEventListener("click", (event) -> {
	    		 Element input = shadowRoot.querySelector(".screen");
		         String inputVal = input.innerHTML;
		         String btnVal = this.innerHTML;
		         //new,just append the key values (btnValue) to
		         //if clear key is pressed,erase everything
		         if(btnVal == "C"){
		           input.innerHTML ="";
		           decimalAdded = false;
		         }else if(operators.indexOf(btnVal) > -1){
		            String lastchar = inputVal.substring(inputVal.length()-1);
		            if(inputVal != "" && operators.indexOf(lastchar) == -1){
		              input.innerHTML += btnVal;
		            }else if(inputVal == "" && btnVal == "-"){
		              input.innerHTML += btnVal;
		            }
		            if(operators.indexOf(lastchar) > -1 && inputVal.length() > 1){
		              input.innerHTML = inputVal.replaceAll("/.$/", btnVal);
		            }
		            decimalAdded=false;
		         }else if(btnVal == "."){
		           if(!decimalAdded){
		             input.innerHTML += btnVal;
		             decimalAdded=true;
		           }
		         }else if(btnVal == "="){
		           String equation = inputVal;
		           String lastchar = inputVal.substring(inputVal.length()-1);

		           equation = equation.replaceAll("/x/g","*").replaceAll("///g","%");
		           if(operators.indexOf(lastchar) > -1 || lastchar == "."){
		             equation = equation.replaceAll("/.$/","");
		           }
		           if(operators != ""){
//		             input.innerHTML = eval(equation);
		           }
		         }else{
		           input.innerHTML += btnVal;
		         }
		         CustomEvent eventtemp = new CustomEvent("open-calculator-screen-update");
		 		 Object obj = new Object();
		 		 obj.$set("detail", input.innerHTML);
		 		 eventtemp.detail = (java.lang.Object)obj;
		 	     document.dispatchEvent(eventtemp);
		         event.preventDefault();
	 		});

	     }
	
	}
	
	public void clearScreen(){
		Element input = shadowRoot.querySelector(".screen");
		input.innerHTML = "";
		decimalAdded=false;
		CustomEvent event = new CustomEvent("open-calculator-screen-update");
		Object obj = new Object();
		obj.$set("detail", input.innerHTML);
		event.detail = (java.lang.Object)obj;
	    document.dispatchEvent(event);
	}
}
