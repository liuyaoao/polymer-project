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
                    var ShopCategoryData = (function () {
                        function ShopCategoryData() {
                            this.categoriesList = [];
                            this.categories = Object.defineProperty({
                                type: Array,
                                value: this.categoriesList,
                                readOnly: true,
                                notify: true
                            }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });
                            this.category = Object.defineProperty({
                                type: Object,
                                computed: "_computeCategory(categoryName)",
                                notify: true
                            }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });
                            this.item = Object.defineProperty({
                                type: Object,
                                computed: "_computeItem(category.items, itemName)",
                                notify: true
                            }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });
                            this.failure = Object.defineProperty({
                                type: Boolean,
                                readOnly: true,
                                notify: true
                            }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });
                            this.attempts = 0;
                            this.dataUrl = "";
                            this.is = "shop-category-data";
                            console.log("created " + this.is);
                        }
                        ShopCategoryData.__static_initialize = function () { if (!ShopCategoryData.__static_initialized) {
                            ShopCategoryData.__static_initialized = true;
                            ShopCategoryData.__static_initializer_0();
                        } };
                        ShopCategoryData.__static_initializer_0 = function () {
                            Polymer(ShopCategoryData.prototype);
                            console.log("registered Shop Category Data component");
                        };
                        ShopCategoryData.prototype.ready = function () {
                            var cate = [];
                            this.categoriesList = cate;
                        };
                        ShopCategoryData.prototype.attached = function () {
                            this.iniCategoryData();
                        };
                        ShopCategoryData.prototype.iniCategoryData = function () {
                            this.splice("categoriesList", 0, this.categoriesList.length);
                            var categoryData = (function (target) {
                                target['name'] = "mens_outerwear";
                                target['title'] = "Men\'s Outerwear";
                                target['image'] = "/jsweetpolymershop/images/mens_outerwear.jpg";
                                target['placeholder'] = "data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAAeAAD/7gAOQWRvYmUAZMAAAAAB/9sAhAAQCwsLDAsQDAwQFw8NDxcbFBAQFBsfFxcXFxcfHhcaGhoaFx4eIyUnJSMeLy8zMy8vQEBAQEBAQEBAQEBAQEBAAREPDxETERUSEhUUERQRFBoUFhYUGiYaGhwaGiYwIx4eHh4jMCsuJycnLis1NTAwNTVAQD9AQEBAQEBAQEBAQED/wAARCAADAA4DASIAAhEBAxEB/8QAXAABAQEAAAAAAAAAAAAAAAAAAAIEAQEAAAAAAAAAAAAAAAAAAAACEAAAAwYHAQAAAAAAAAAAAAAAERMBAhIyYhQhkaEDIwUVNREBAAAAAAAAAAAAAAAAAAAAAP/aAAwDAQACEQMRAD8A3dkr5e8tfpwuneJITOzIcmQpit037Bw4mnCVNOpAAQv/2Q==";
                                return target;
                            })(new ShopCategoryData.CategoryData());
                            this.categoriesList[0] = categoryData;
                            this.categoriesList[1] = (function (target) {
                                target['name'] = "ladies_outerwear";
                                target['title'] = "Ladies Outerwear";
                                target['image'] = "/jsweetpolymershop/images/ladies_outerwear.jpg";
                                target['placeholder'] = "data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAAeAAD/7gAOQWRvYmUAZMAAAAAB/9sAhAAQCwsLDAsQDAwQFw8NDxcbFBAQFBsfFxcXFxcfHhcaGhoaFx4eIyUnJSMeLy8zMy8vQEBAQEBAQEBAQEBAQEBAAREPDxETERUSEhUUERQRFBoUFhYUGiYaGhwaGiYwIx4eHh4jMCsuJycnLis1NTAwNTVAQD9AQEBAQEBAQEBAQED/wAARCAADAA4DASIAAhEBAxEB/8QAWQABAQAAAAAAAAAAAAAAAAAAAAEBAQEAAAAAAAAAAAAAAAAAAAIDEAABAwMFAQAAAAAAAAAAAAARAAEygRIDIlITMwUVEQEBAAAAAAAAAAAAAAAAAAAAQf/aAAwDAQACEQMRAD8Avqn5meQ0kwk1UyclmLtNj7L4PQoioFf/2Q==";
                                return target;
                            })(new ShopCategoryData.CategoryData());
                            this.categoriesList[2] = (function (target) {
                                target['name'] = "mens_tshirts";
                                target['title'] = "Men\"s T-Shirts";
                                target['image'] = "/jsweetpolymershop/images/mens_tshirts.jpg";
                                target['placeholder'] = "data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAAeAAD/7gAOQWRvYmUAZMAAAAAB/9sAhAAQCwsLDAsQDAwQFw8NDxcbFBAQFBsfFxcXFxcfHhcaGhoaFx4eIyUnJSMeLy8zMy8vQEBAQEBAQEBAQEBAQEBAAREPDxETERUSEhUUERQRFBoUFhYUGiYaGhwaGiYwIx4eHh4jMCsuJycnLis1NTAwNTVAQD9AQEBAQEBAQEBAQED/wAARCAADAA4DASIAAhEBAxEB/8QAWwABAQEAAAAAAAAAAAAAAAAAAAMEAQEAAAAAAAAAAAAAAAAAAAAAEAABAwEJAAAAAAAAAAAAAAARAAESEyFhodEygjMUBREAAwAAAAAAAAAAAAAAAAAAAEFC/9oADAMBAAIRAxEAPwDb7kupZU1MTGnvOCgxpvzEXTyRElCmf//Z";
                                return target;
                            })(new ShopCategoryData.CategoryData());
                            this.categoriesList[3] = (function (target) {
                                target['name'] = "ladies_tshirts";
                                target['title'] = "Ladies T-Shirts";
                                target['image'] = "/jsweetpolymershop/images/ladies_tshirts.jpg";
                                target['placeholder'] = "data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAAeAAD/7gAOQWRvYmUAZMAAAAAB/9sAhAAQCwsLDAsQDAwQFw8NDxcbFBAQFBsfFxcXFxcfHhcaGhoaFx4eIyUnJSMeLy8zMy8vQEBAQEBAQEBAQEBAQEBAAREPDxETERUSEhUUERQRFBoUFhYUGiYaGhwaGiYwIx4eHh4jMCsuJycnLis1NTAwNTVAQD9AQEBAQEBAQEBAQED/wAARCAADAA4DASIAAhEBAxEB/8QAXwABAQEAAAAAAAAAAAAAAAAAAAMFAQEBAAAAAAAAAAAAAAAAAAABAhAAAQIDCQAAAAAAAAAAAAAAEQABITETYZECEjJCAzMVEQACAwAAAAAAAAAAAAAAAAAAATFBgf/aAAwDAQACEQMRAD8AzeADAZiFc5J7BC9Scek3VrtooilSNaf/2Q==";
                                return target;
                            })(new ShopCategoryData.CategoryData());
                        };
                        ShopCategoryData.prototype._getCategoryObject = function (categoryName) {
                            var tempDt = null;
                            for (var i = 0; i < this.categoriesList.length; ++i) {
                                if (this.categoriesList[i].name === categoryName) {
                                    tempDt = this.categoriesList[i];
                                    break;
                                }
                            }
                            return tempDt;
                        };
                        ShopCategoryData.prototype._computeCategory = function (categoryName) {
                            var categoryObj = this._getCategoryObject(categoryName);
                            this._fetchItems(categoryObj, 1);
                            return categoryObj;
                        };
                        ShopCategoryData.prototype._computeItem = function (items, itemName) {
                            var item = null;
                            for (var i = 0; i < items.length; ++i) {
                                item = items[i];
                                if (item.name === itemName) {
                                    return item;
                                }
                            }
                            return item;
                        };
                        ShopCategoryData.prototype._fetchItems = function (category, attempts) {
                            this.failure.value = false;
                            if (category == null || category["items"] == null) {
                                return;
                            }
                            var url = "/jsweetpolymershop/data/" + category.name + ".json";
                            this.dataUrl = url;
                            this._getResource(url, attempts);
                        };
                        ShopCategoryData.prototype._getResource = function (url, attempts) {
                            var _this = this;
                            this.attempts = attempts;
                            var xhr = new XMLHttpRequest();
                            xhr.onload = function (event) { return _this.onLoad(event); };
                            xhr.addEventListener("load", xhr.onload);
                            xhr.addEventListener("error", function (event) {
                                _this.onErrorcall(event);
                            });
                            xhr.open("GET", url);
                            xhr.send();
                        };
                        ShopCategoryData.prototype.onLoad = function (event) {
                            this["category.items"] = JSON.parse(event.target["responseText"]);
                            return true;
                        };
                        ShopCategoryData.prototype.onErrorcall = function (event) {
                            if (this.attempts > 1) {
                                var parems = ["url", "attempts"];
                                var func = new Function(parems);
                                this.debounce("_getResource", func, 200);
                            }
                            else {
                                this.failure.value = true;
                            }
                            return true;
                        };
                        ShopCategoryData.prototype.refresh = function (b) {
                            if (this.categoryName !== "") {
                                this._fetchItems(this._getCategoryObject(this.categoryName), 3);
                            }
                        };
                        ShopCategoryData.__static_initialized = false;
                        return ShopCategoryData;
                    }());
                    components.ShopCategoryData = ShopCategoryData;
                    ShopCategoryData["__class"] = "org.jsweet.examples.polymerjs.components.ShopCategoryData";
                    ShopCategoryData["__interfaces"] = ["def.polymer.polymer.Base"];
                    var ShopCategoryData;
                    (function (ShopCategoryData) {
                        var CategoryData = (function () {
                            function CategoryData(__parent) {
                                this.__parent = __parent;
                                this.price = 0;
                            }
                            return CategoryData;
                        }());
                        ShopCategoryData.CategoryData = CategoryData;
                        CategoryData["__class"] = "org.jsweet.examples.polymerjs.components.ShopCategoryData.CategoryData";
                    })(ShopCategoryData = components.ShopCategoryData || (components.ShopCategoryData = {}));
                })(components = polymerjs.components || (polymerjs.components = {}));
            })(polymerjs = examples.polymerjs || (examples.polymerjs = {}));
        })(examples = jsweet.examples || (jsweet.examples = {}));
    })(jsweet = org.jsweet || (org.jsweet = {}));
})(org || (org = {}));
org.jsweet.examples.polymerjs.components.ShopCategoryData.__static_initialize();
