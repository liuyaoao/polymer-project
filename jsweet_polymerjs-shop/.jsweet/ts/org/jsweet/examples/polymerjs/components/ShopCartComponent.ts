/* Generated from Java with JSweet 1.2.0-SNAPSHOT - http://www.jsweet.org */
namespace org.jsweet.examples.polymerjs.components {
    import Base = polymer.Base;

    import PropObjectType = polymer.PropObjectType;

    export class ShopCartComponent implements Base {
        static __static_initialized : boolean = false;
        static __static_initialize() { if(!ShopCartComponent.__static_initialized) { ShopCartComponent.__static_initialized = true; ShopCartComponent.__static_initializer_0(); } }

        public constructor() {
            this.is = "shop-cart";
            console.log("created " + this.is);
        }

        static __static_initializer_0() {
            Polymer(<Base>ShopCartComponent.prototype);
            console.log("registered Shop Cart component");
        }

        public total : number;

        public Cart : Array<any>;

        public visible : PropObjectType = <any>Object.defineProperty({
            type: Boolean,
            observer: "_visibleChanged"
        }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });

        public _hasItems : PropObjectType = <any>Object.defineProperty({
            type: Boolean,
            computed: "_computeHasItem(cart.length)"
        }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });

        public _formatTotal(total : number) : string {
            if(total == null) {
                return "";
            } else {
                return "$" + total.toFixed(2);
            }
        }

        public _computeHasItem(cartLength : number) : boolean {
            return cartLength > 0;
        }

        public _getPluralizedQuantity(quantity : number) : string {
            return quantity + " " + (quantity === 1?"item":"items");
        }

        public _visibleChanged(visible : boolean) {
            if(visible) {
                let obj : Object = <Object>new Object();
                obj["title"] = "Your cart";
                this.fire("change-section", obj);
            }
        }
    }
    ShopCartComponent["__class"] = "org.jsweet.examples.polymerjs.components.ShopCartComponent";
    ShopCartComponent["__interfaces"] = ["def.polymer.polymer.Base"];


}


org.jsweet.examples.polymerjs.components.ShopCartComponent.__static_initialize();
