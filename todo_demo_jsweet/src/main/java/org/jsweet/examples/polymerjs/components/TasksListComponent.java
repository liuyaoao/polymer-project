package org.jsweet.examples.polymerjs.components;

import static jsweet.dom.Globals.console;
import static def.polymer.Globals.Polymer;
import static jsweet.dom.Globals.localStorage;
import static jsweet.util.Globals.object;
import static jsweet.util.Globals.array;


import def.polymer.polymer.Base;
import jsweet.lang.Array;
import jsweet.lang.Interface;


interface PaperDialog {
	void open();
	void close();
}

@Interface
abstract class PaperItemModel<TItem> {
	TItem item;
}

@Interface
abstract class PaperItemEvent<TItem> {
	PaperItemModel<TItem> model;
}

class Task {
	public String taskName="";
	public boolean isComplete;
}

public class TasksListComponent extends Base {

	public TasksListComponent() {
//		super();
		this.is = "tasks-list";
	}

	static {
		Polymer((Base)TasksListComponent.prototype);
		console.log("registered task list component");
	}

	public String latestTaskName;
	public Task[] tasks = {};

	public void showAddTaskDialog() {
		PaperDialog dialog = this.findInnerElement("addTaskDialog");
		dialog.open();
	}
	@Override
	public void ready() {
		Task[] tt = {};
		this.tasks = tt;
		updateTasks();
	}
//	@Override
//	public void attached() {
//		Task[] tt = {};
//		this.tasks = tt;
//		updateTasks();
//	}

	public void addTask() {
		console.log("add task: " + latestTaskName);

		// Store the new task as not completed
		localStorage.setItem(this.latestTaskName, "no");

		// Reset latestTaskName
		this.latestTaskName = "";

		// Close the dialog
		PaperDialog dialog = this.findInnerElement("addTaskDialog");
		dialog.close();

		// Update the list of tasks
		this.updateTasks();
	}

	public void toggleTask(PaperItemEvent<Task> event) {
		// Get the name of the task
		String taskName = event.model.item.taskName;
		console.log("toggle task: " + taskName);

		// Convert true/false to yes/no
		if (event.model.item.isComplete) {
			localStorage.setItem(taskName, "yes");
		} else {
			localStorage.setItem(taskName, "no");
		}
	}

	public void deleteTask(PaperItemEvent<Task> event) {
		String taskName = event.model.item.taskName;
		console.log("remove task: " + taskName);

		localStorage.removeItem(taskName);

		// Update the list of tasks
		this.updateTasks();
	}

	public void updateTasks() {
		console.log("refresh tasks");

		// Empty the array
		array(tasks).splice(0, tasks.length);

		// Add items from localStorage
		String[] taskKeys = jsweet.lang.Object.keys(localStorage);
		for (int i=0;i<taskKeys.length;i++) {
			String savedTaskName = taskKeys[i];
			console.log("restore task: " + savedTaskName);
			Task task = new Task() {
				{
					taskName = savedTaskName;
					isComplete = localStorage.getItem(savedTaskName) == "yes";
				}
			};
			array(tasks).push(task);
		}
	}

	protected <T> T findInnerElement(String id) {
		return (T) object(this.$).$get(id);
	}
}
