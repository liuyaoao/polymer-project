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
                    var Task = (function () {
                        function Task() {
                            this.taskName = "";
                            this.isComplete = false;
                        }
                        return Task;
                    }());
                    components.Task = Task;
                    Task["__class"] = "org.jsweet.examples.polymerjs.components.Task";
                    var TasksListComponent = (function () {
                        function TasksListComponent() {
                            this.tasks = [];
                            this.is = "tasks-list";
                        }
                        TasksListComponent.__static_initialize = function () { if (!TasksListComponent.__static_initialized) {
                            TasksListComponent.__static_initialized = true;
                            TasksListComponent.__static_initializer_0();
                        } };
                        TasksListComponent.__static_initializer_0 = function () {
                            Polymer(TasksListComponent.prototype);
                            console.log("registered task list component");
                        };
                        TasksListComponent.prototype.showAddTaskDialog = function () {
                            var dialog = this.findInnerElement("addTaskDialog");
                            dialog.open();
                        };
                        TasksListComponent.prototype.ready = function () {
                            var tt = [];
                            this.tasks = tt;
                            this.updateTasks();
                        };
                        TasksListComponent.prototype.addTask = function () {
                            console.log("add task: " + this.latestTaskName);
                            localStorage.setItem(this.latestTaskName, "no");
                            this.latestTaskName = "";
                            var dialog = this.findInnerElement("addTaskDialog");
                            dialog.close();
                            this.updateTasks();
                        };
                        TasksListComponent.prototype.toggleTask = function (event) {
                            var taskName = event.model.item.taskName;
                            console.log("toggle task: " + taskName);
                            if (event.model.item.isComplete) {
                                localStorage.setItem(taskName, "yes");
                            }
                            else {
                                localStorage.setItem(taskName, "no");
                            }
                        };
                        TasksListComponent.prototype.deleteTask = function (event) {
                            var taskName = event.model.item.taskName;
                            console.log("remove task: " + taskName);
                            localStorage.removeItem(taskName);
                            this.updateTasks();
                        };
                        TasksListComponent.prototype.updateTasks = function () {
                            console.log("refresh tasks");
                            (this.tasks).splice(0, this.tasks.length);
                            var taskKeys = Object.keys(localStorage);
                            var _loop_1 = function(i) {
                                var savedTaskName = taskKeys[i];
                                console.log("restore task: " + savedTaskName);
                                var task = (function (target) {
                                    target['taskName'] = savedTaskName;
                                    target['isComplete'] = localStorage.getItem(savedTaskName) === "yes";
                                    return target;
                                })(new Task());
                                (this_1.tasks).push(task);
                            };
                            var this_1 = this;
                            for (var i = 0; i < taskKeys.length; i++) {
                                _loop_1(i);
                            }
                        };
                        TasksListComponent.prototype.findInnerElement = function (id) {
                            return (this.$)[id];
                        };
                        TasksListComponent.__static_initialized = false;
                        return TasksListComponent;
                    }());
                    components.TasksListComponent = TasksListComponent;
                    TasksListComponent["__class"] = "org.jsweet.examples.polymerjs.components.TasksListComponent";
                    TasksListComponent["__interfaces"] = ["def.polymer.polymer.Base"];
                })(components = polymerjs.components || (polymerjs.components = {}));
            })(polymerjs = examples.polymerjs || (examples.polymerjs = {}));
        })(examples = jsweet.examples || (jsweet.examples = {}));
    })(jsweet = org.jsweet || (org.jsweet = {}));
})(org || (org = {}));
org.jsweet.examples.polymerjs.components.TasksListComponent.__static_initialize();
