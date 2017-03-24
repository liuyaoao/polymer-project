/* Generated from Java with JSweet 1.2.0-SNAPSHOT - http://www.jsweet.org */
var org;
(function (org) {
    var jsweet;
    (function (jsweet) {
        var examples;
        (function (examples) {
            var polymerjs;
            (function (polymerjs) {
                var components;
                (function (components) {
                    var ShopCartComponent = (function () {
                        function ShopCartComponent() {
                            this.visible = Object.defineProperty({
                                type: Boolean,
                                observer: "_visibleChanged"
                            }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });
                            this._hasItems = Object.defineProperty({
                                type: Boolean,
                                computed: "_computeHasItem(cart.length)"
                            }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });
                            this.is = "shop-cart";
                            console.log("created " + this.is);
                        }
                        ShopCartComponent.__static_initialize = function () { if (!ShopCartComponent.__static_initialized) {
                            ShopCartComponent.__static_initialized = true;
                            ShopCartComponent.__static_initializer_0();
                        } };
                        ShopCartComponent.__static_initializer_0 = function () {
                            Polymer(ShopCartComponent.prototype);
                            console.log("registered Shop Cart component");
                        };
                        ShopCartComponent.prototype._formatTotal = function (total) {
                            if (total == null) {
                                return "";
                            }
                            else {
                                return "$" + total.toFixed(2);
                            }
                        };
                        ShopCartComponent.prototype._computeHasItem = function (cartLength) {
                            return cartLength > 0;
                        };
                        ShopCartComponent.prototype._getPluralizedQuantity = function (quantity) {
                            return quantity + " " + (quantity === 1 ? "item" : "items");
                        };
                        ShopCartComponent.prototype._visibleChanged = function (visible) {
                            if (visible) {
                                var obj = new Object();
                                obj["title"] = "Your cart";
                                this.fire("change-section", obj);
                            }
                        };
                        ShopCartComponent.__static_initialized = false;
                        return ShopCartComponent;
                    }());
                    components.ShopCartComponent = ShopCartComponent;
                    ShopCartComponent["__class"] = "org.jsweet.examples.polymerjs.components.ShopCartComponent";
                    ShopCartComponent["__interfaces"] = ["def.polymer.polymer.Base"];
                })(components = polymerjs.components || (polymerjs.components = {}));
            })(polymerjs = examples.polymerjs || (examples.polymerjs = {}));
        })(examples = jsweet.examples || (jsweet.examples = {}));
    })(jsweet = org.jsweet || (org.jsweet = {}));
})(org || (org = {}));
org.jsweet.examples.polymerjs.components.ShopCartComponent.__static_initialize();
