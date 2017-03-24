/* Generated from Java with JSweet 1.2.0-SNAPSHOT - http://www.jsweet.org */
namespace org.jsweet.examples.polymerjs.components {
    import Base = polymer.Base;

    import PropObjectType = polymer.PropObjectType;

    export class ShopCartData implements Base {
        static __static_initialized : boolean = false;
        static __static_initialize() { if(!ShopCartData.__static_initialized) { ShopCartData.__static_initialized = true; ShopCartData.__static_initializer_0(); } }

        public constructor() {
            this.is = "shop-cart-data";
            console.log("created " + this.is);
        }

        static __static_initializer_0() {
            Polymer(<Base>ShopCartData.prototype);
            console.log("registered Shop Cart Data");
        }

        public cart : PropObjectType = <any>Object.defineProperty({
            type: Array,
            value: new Array<Object>(),
            notify: true
        }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });

        public numItems : PropObjectType = <any>Object.defineProperty({
            type: Number,
            computed: "_computeNumItems(cart.splices)",
            notify: true
        }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });

        public total : PropObjectType = <any>Object.defineProperty({
            type: Number,
            computed: "_computeTotal(cart.splices)",
            notify: true
        }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });

        public addItem(detail : Object) {
            let itemObj : Object = <Object>detail["item"];
            let i : number = this._indexOfEntry(<string>itemObj["name"], (<number>detail["size"]|0));
            if(i !== -1) {
                let valueArr : Array<Object> = <Array<Object>>this.cart.value;
                let vObj : Object = valueArr[i];
                let num : number = (<number>detail["quantity"]|0) + (<number>vObj["quantity"]|0);
                detail["quantity"] = {quantity: num};
            }
            this.setItem(detail);
        }

        public setItem(detail : Object) {
            let i : number = this._indexOfEntry(<string>(detail["item"])["name"], (<number>detail["size"]|0));
            if((<number>detail["quantity"]|0) === 0) {
                if(i !== -1) {
                    this.splice("cart", i, 1);
                }
            } else {
                let valueArr : Array<Object> = <Array<Object>>this.cart.value;
                if(i !== -1) {
                    valueArr.splice(i, 1, detail);
                    this.fire("cart.splices");
                } else {
                    valueArr.push(detail);
                    this.fire("cart.splices");
                }
            }
        }

        public clearCart() {
            this.cart.value = <any>(new Array<Object>());
        }

        public _computeNumItems() : number {
            let reduceCall : (p1: number, p2: Object) => number = (total, entry) => {
                return total + (<number>entry["quantity"]|0);
            };
            if(this.cart != null) {
                let arr : Array<any> = <Array<any>>this.cart;
                arr.reduce<any>(reduceCall, 0);
            }
            return 0;
        }

        public _computeTotal() : number {
            let reduceCall : (p1: number, p2: Object) => number = (total, entry) => {
                return total + (<number>entry["quantity"]|0) * (<number>(entry["item"])["price"]|0);
            };
            if(this.cart != null) {
                let arr : Array<Object> = <Array<Object>>this.cart.value;
                arr.reduce<any>(reduceCall, 0);
            }
            return 0;
        }

        public _indexOfEntry(name : string, size : number) : number {
            if(this.cart.value != null) {
                let arr : Array<Object> = <Array<Object>>this.cart.value;
                for(let i : number = 0; i < arr.length; ++i) {
                    let entry : Object = <Object>arr[i];
                    if((entry["item"])["name"] === name && (<number>entry["size"]|0) === size) {
                        return i;
                    }
                }
            }
            return -1;
        }
    }
    ShopCartData["__class"] = "org.jsweet.examples.polymerjs.components.ShopCartData";
    ShopCartData["__interfaces"] = ["def.polymer.polymer.Base"];



    export namespace ShopCartData {

        export class CategoryData {
            public __parent: any;
            public name : string;

            public title : string;

            public category : string;

            public price : number;

            public description : string;

            public image : string;

            public largeImage : string;

            public placeholder : string;

            constructor(__parent: any) {
                this.__parent = __parent;
                this.price = 0;
            }
        }
        CategoryData["__class"] = "org.jsweet.examples.polymerjs.components.ShopCartData.CategoryData";

    }

}


org.jsweet.examples.polymerjs.components.ShopCartData.__static_initialize();
