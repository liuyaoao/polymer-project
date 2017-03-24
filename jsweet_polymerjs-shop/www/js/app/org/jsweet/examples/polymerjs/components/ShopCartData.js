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
                    var ShopCartData = (function () {
                        function ShopCartData() {
                            this.cart = Object.defineProperty({
                                type: Array,
                                value: new Array(),
                                notify: true
                            }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });
                            this.numItems = Object.defineProperty({
                                type: Number,
                                computed: "_computeNumItems(cart.splices)",
                                notify: true
                            }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });
                            this.total = Object.defineProperty({
                                type: Number,
                                computed: "_computeTotal(cart.splices)",
                                notify: true
                            }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });
                            this.is = "shop-cart-data";
                            console.log("created " + this.is);
                        }
                        ShopCartData.__static_initialize = function () { if (!ShopCartData.__static_initialized) {
                            ShopCartData.__static_initialized = true;
                            ShopCartData.__static_initializer_0();
                        } };
                        ShopCartData.__static_initializer_0 = function () {
                            Polymer(ShopCartData.prototype);
                            console.log("registered Shop Cart Data");
                        };
                        ShopCartData.prototype.addItem = function (detail) {
                            var itemObj = detail["item"];
                            var i = this._indexOfEntry(itemObj["name"], (detail["size"] | 0));
                            if (i !== -1) {
                                var valueArr = this.cart.value;
                                var vObj = valueArr[i];
                                var num = (detail["quantity"] | 0) + (vObj["quantity"] | 0);
                                detail["quantity"] = { quantity: num };
                            }
                            this.setItem(detail);
                        };
                        ShopCartData.prototype.setItem = function (detail) {
                            var i = this._indexOfEntry((detail["item"])["name"], (detail["size"] | 0));
                            if ((detail["quantity"] | 0) === 0) {
                                if (i !== -1) {
                                    this.splice("cart", i, 1);
                                }
                            }
                            else {
                                var valueArr = this.cart.value;
                                if (i !== -1) {
                                    valueArr.splice(i, 1, detail);
                                    this.fire("cart.splices");
                                }
                                else {
                                    valueArr.push(detail);
                                    this.fire("cart.splices");
                                }
                            }
                        };
                        ShopCartData.prototype.clearCart = function () {
                            this.cart.value = (new Array());
                        };
                        ShopCartData.prototype._computeNumItems = function () {
                            var reduceCall = function (total, entry) {
                                return total + (entry["quantity"] | 0);
                            };
                            if (this.cart != null) {
                                var arr = this.cart;
                                arr.reduce(reduceCall, 0);
                            }
                            return 0;
                        };
                        ShopCartData.prototype._computeTotal = function () {
                            var reduceCall = function (total, entry) {
                                return total + (entry["quantity"] | 0) * ((entry["item"])["price"] | 0);
                            };
                            if (this.cart != null) {
                                var arr = this.cart.value;
                                arr.reduce(reduceCall, 0);
                            }
                            return 0;
                        };
                        ShopCartData.prototype._indexOfEntry = function (name, size) {
                            if (this.cart.value != null) {
                                var arr = this.cart.value;
                                for (var i = 0; i < arr.length; ++i) {
                                    var entry = arr[i];
                                    if ((entry["item"])["name"] === name && (entry["size"] | 0) === size) {
                                        return i;
                                    }
                                }
                            }
                            return -1;
                        };
                        ShopCartData.__static_initialized = false;
                        return ShopCartData;
                    }());
                    components.ShopCartData = ShopCartData;
                    ShopCartData["__class"] = "org.jsweet.examples.polymerjs.components.ShopCartData";
                    ShopCartData["__interfaces"] = ["def.polymer.polymer.Base"];
                    var ShopCartData;
                    (function (ShopCartData) {
                        var CategoryData = (function () {
                            function CategoryData(__parent) {
                                this.__parent = __parent;
                                this.price = 0;
                            }
                            return CategoryData;
                        }());
                        ShopCartData.CategoryData = CategoryData;
                        CategoryData["__class"] = "org.jsweet.examples.polymerjs.components.ShopCartData.CategoryData";
                    })(ShopCartData = components.ShopCartData || (components.ShopCartData = {}));
                })(components = polymerjs.components || (polymerjs.components = {}));
            })(polymerjs = examples.polymerjs || (examples.polymerjs = {}));
        })(examples = jsweet.examples || (jsweet.examples = {}));
    })(jsweet = org.jsweet || (org.jsweet = {}));
})(org || (org = {}));
org.jsweet.examples.polymerjs.components.ShopCartData.__static_initialize();
