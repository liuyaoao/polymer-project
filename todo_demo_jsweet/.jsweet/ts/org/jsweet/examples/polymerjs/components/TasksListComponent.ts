/* Generated from Java with JSweet 1.2.0-SNAPSHOT - http://www.jsweet.org */
namespace org.jsweet.examples.polymerjs.components {
    import Base = polymer.Base;

    export interface PaperDialog {
        open();

        close();
    }

    export interface PaperItemModel<TItem> {
        item : TItem;
    }

    export interface PaperItemEvent<TItem> {
        model : PaperItemModel<TItem>;
    }

    export class TasksListComponent implements Base {
        static __static_initialized : boolean = false;
        static __static_initialize() { if(!TasksListComponent.__static_initialized) { TasksListComponent.__static_initialized = true; TasksListComponent.__static_initializer_0(); } }

        public constructor() {
            this.is = "tasks-list";
        }

        static __static_initializer_0() {
            Polymer(<Base>TasksListComponent.prototype);
            console.log("registered task list component");
        }

        public latestTaskName : string;

        public tasks : Object[] = [];

        public showAddTaskDialog() {
            let dialog : PaperDialog = this.findInnerElement<any>("addTaskDialog");
            dialog.open();
        }

        public ready() {
            let tt : Object[] = [];
            this.tasks = tt;
            let task : Object = <Object>new Object();
            task["taskName"] = "first default task!";
            task["isComplete"] = "no";
            (this.tasks).push(task);
        }

        public attached() {
            this.updateTasks();
        }

        public addTask() {
            console.log("add task: " + this.latestTaskName);
            localStorage.setItem(this.latestTaskName, "no");
            this.latestTaskName = "";
            let dialog : PaperDialog = this.findInnerElement<any>("addTaskDialog");
            dialog.close();
            this.updateTasks();
        }

        public toggleTask(event : PaperItemEvent<Object>) {
            let taskName : string = <string>(event.model.item)["taskName"];
            console.log("toggle task: " + taskName);
            if(<boolean>(event.model.item)["isComplete"]) {
                localStorage.setItem(taskName, "yes");
            } else {
                localStorage.setItem(taskName, "no");
            }
        }

        public deleteTask(event : PaperItemEvent<Object>) {
            let taskName : string = <string>(event.model.item)["taskName"];
            console.log("remove task: " + taskName);
            localStorage.removeItem(taskName);
            this.updateTasks();
        }

        public updateTasks() {
            console.log("refresh tasks");
            (this.tasks).splice(0, this.tasks.length);
            let taskKeys : string[] = Object.keys(localStorage);
            for(let i : number = 0; i < taskKeys.length; i++) {
                let savedTaskName : string = taskKeys[i];
                console.log("restore task: " + savedTaskName);
                let task : Object = <Object>new Object();
                task["taskName"] = savedTaskName;
                task["isComplete"] = localStorage.getItem(savedTaskName) === "yes";
                (this.tasks).push(task);
            }
            this.notifyPath("tasks", this.tasks, null);
        }

        findInnerElement<T>(id : string) : T {
            return <T>(this.$)[id];
        }
    }
    TasksListComponent["__class"] = "org.jsweet.examples.polymerjs.components.TasksListComponent";
    TasksListComponent["__interfaces"] = ["def.polymer.polymer.Base"];


}


org.jsweet.examples.polymerjs.components.TasksListComponent.__static_initialize();
