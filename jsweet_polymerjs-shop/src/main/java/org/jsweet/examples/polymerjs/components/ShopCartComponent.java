package org.jsweet.examples.polymerjs.components;

import static def.polymer.Globals.Polymer;
import static jsweet.dom.Globals.console;
import static jsweet.util.Globals.function;
import static jsweet.util.Globals.object;
import jsweet.lang.Object;

import java.util.function.Function;

import def.polymer.polymer.Base;
import def.polymer.polymer.PropObjectType;
import jsweet.dom.HTMLElement;
import jsweet.lang.Interface;
import jsweet.lang.Number;
import jsweet.lang.Array;




public class ShopCartComponent extends Base {

	public ShopCartComponent() {
		this.is = "shop-cart";
		console.log("created " + is);
	}

//	class CategoryData {
//		public String name;
//		public String title;
//		public String category;
//		public double price;
//		public String description;
//		public String image;
//		public String largeImage;
//		public String placeholder;
//	};
	
	static {
		Polymer((Base) ShopCartComponent.prototype);
		console.log("registered Shop Cart component");
	}
	public Number total;
	public Array Cart;
	

	public PropObjectType visible = new PropObjectType() {
		{
			type= Boolean.class;
			observer= "_visibleChanged";
		}
	};
	public PropObjectType _hasItems = new PropObjectType() {
		{
			type= Boolean.class;
			computed= "_computeHasItem(cart.length)";
		}
	};
	
	public String _formatTotal(Number total) {
		if(total == null){
			return "";
		}else{
			return "$" + total.toFixed(2);
		}
    }
	
	public Boolean _computeHasItem(int cartLength) {
        return cartLength > 0;
    }
	
	public String _getPluralizedQuantity(int quantity) {
		return quantity + " " + (quantity == 1 ? "item" : "items");
    }
	
	public void _visibleChanged(Boolean visible){
		if (visible) {
			Object obj = new Object();
			obj.$set("title","Your cart");
			this.fire("change-section", obj);
		}
	}
	

}
