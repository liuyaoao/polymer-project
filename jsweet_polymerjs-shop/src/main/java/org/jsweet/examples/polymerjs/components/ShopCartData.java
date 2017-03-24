package org.jsweet.examples.polymerjs.components;

import static def.polymer.Globals.Polymer;
import static jsweet.dom.Globals.console;
import static jsweet.dom.Globals.localStorage;
import static jsweet.util.Globals.function;
import static jsweet.util.Globals.object;

import java.util.function.BiFunction;

import static jsweet.util.Globals.array;
import static jsweet.util.Globals.$map;
import static jsweet.util.Globals.$set;
import jsweet.lang.Object;
import jsweet.util.function.Function4;
import def.polymer.polymer.Base;
import def.polymer.polymer.PropObjectType;
import jsweet.dom.HTMLElement;
import jsweet.lang.Interface;
import jsweet.lang.Function;
import jsweet.lang.Number;
import jsweet.lang.Array;

public class ShopCartData extends Base {

	public ShopCartData() {
		this.is = "shop-cart-data";
		console.log("created " + is);
	}

	class CategoryData {
		public String name;
		public String title;
		public String category;
		public double price;
		public String description;
		public String image;
		public String largeImage;
		public String placeholder;
	};
	
//	native public void push(String str, Object obj);
//	native public void splice(String str,double i,double j, Object obj);
	
	static {
		Polymer((Base)ShopCartData.prototype);
		console.log("registered Shop Cart Data");
	}

	public PropObjectType cart = new PropObjectType() {
		{
			type= Array.class;
			value = new Array<Object>();
			notify= true;
		}
	};
	public PropObjectType numItems = new PropObjectType() {
		{
			type= Number.class;
			computed= "_computeNumItems(cart.splices)";
	        notify = true;
		}
	};
	public PropObjectType total = new PropObjectType() {
		{
			type= Number.class;
			computed= "_computeTotal(cart.splices)";
	        notify = true;
		}
	};

	public void addItem(Object detail){
		Object itemObj = (Object)detail.$get("item");
		int i = this._indexOfEntry((String)itemObj.$get("name"), (int)detail.$get("size"));
        if (i != -1) {
        	Array<Object> valueArr = (Array<Object>)this.cart.value;
        	Object vObj = array(valueArr)[i];
          int num = (int)detail.$get("quantity") + (int)vObj.$get("quantity");
          
          detail.$set("quantity",$map("quantity",num));
        }
        this.setItem(detail);
	}
	public void setItem(Object detail){
		int i = this._indexOfEntry((String)object(detail.$get("item")).$get("name"), (int)detail.$get("size"));
        if ((int)detail.$get("quantity") == 0) {
          // Remove item from cart when the new quantity is 0.
          if (i != -1) {
            this.splice("cart", i, 1);
          }
        } else {
          // Use Polymer's array mutation methods (`splice`, `push`) so that observers
          // on `cart.splices` are triggered.
        	Array<Object> valueArr = (Array<Object>)this.cart.value;
          if (i != -1) {
        	valueArr.splice(i,1,detail);
        	this.fire("cart.splices");
          } else {
        	 valueArr.push(detail);
        	 this.fire("cart.splices"); 
          }
        }
	}
	public void clearCart() {
        this.cart.value = new Array<Object>();
    }
	public int _computeNumItems() {
		BiFunction<Integer, Object, Integer> reduceCall = (total, entry) -> {
			return total + (int)entry.$get("quantity");
		};
		if (this.cart !=null) {
			Array arr = (Array)object(this.cart);
			arr.reduce(reduceCall,0);
        }

        return 0;
    }
	public int _computeTotal() {
		BiFunction<Integer, Object, Integer> reduceCall = (total, entry) -> {
			return total + (int)entry.$get("quantity") * (int)object(entry.$get("item")).$get("price");
		};
		if (this.cart != null) {
			Array<Object> arr = (Array<Object>)this.cart.value;
			arr.reduce(reduceCall,0);
        }
        return 0;
    }
	
	public int _indexOfEntry(String name, int size) {
		if (this.cart.value != null) {
			Array<Object> arr = (Array<Object>)this.cart.value;
          for (int i = 0; i < arr.length; ++i) {
            Object entry = (Object)array(arr)[i];
            if (object(entry.$get("item")).$get("name")== name && (int)entry.$get("size") == size) {
              return i;
            }
          }
        }

        return -1;
    }
	

}
