var PaperDialog = function() {};
stjs.extend(PaperDialog, null, [], null, {});
var Task = function() {};
stjs.extend(Task, null, [], function(constructor, prototype) {
    prototype.taskName = "";
    prototype.isComplete = false;
}, {});
var TodoListComponent = function() {
    this.is = "tasks-list";
    this.tasks = [];
    this.tasks[0] = {taskName: "aaaaa", isComplete: true};
};
stjs.extend(TodoListComponent, null, [], function(constructor, prototype) {
    prototype.latestTaskName = "";
    prototype.str = "";
    prototype.tasks = null;
    prototype.is = "";
    prototype.showAddTaskDialog = function() {
        console.log("showAddTaskDialog");
    };
    prototype.addTask = function() {
        console.log("add task: " + this.latestTaskName);
    };
    prototype.toggleTask = function(event) {};
    prototype.deleteTask = function(event) {};
}, {tasks: {name: "Array", arguments: ["Task"]}});
(function() {
    var todolist = new TodoListComponent();
    Polymer(todolist);
})();
