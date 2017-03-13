package quickstart;


import static jsweet.dom.Globals.document;

import jsweet.dom.HTMLElement;


public class index {
	
	public static void main(String[] args) {
		new index();
	}
	
	private HTMLElement calculatorScreen;
	
	public index() {
		this.calculatorScreen = (HTMLElement) document.querySelector("#screen");
	}

}
