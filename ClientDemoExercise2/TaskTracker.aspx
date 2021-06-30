﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TaskTracker.aspx.cs" Inherits="ClientDemoExercise2.TaskTracker" %>

<!DOCTYPE html>
  <html>

  <head>
      <title>Todo list App</title>
      <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700' rel='stylesheet' type='text/css'>

      <style type="text/css">
      /* Basic Style */
      html body {
        background: #ffffff;
        color: #333;
        font-family: Lato, sans-serif;
      }

      html body .container {
        display: flex;
        flex-direction: column;
        width: 70%;
        margin: 100px auto 0;
      }

      html body ul {
        margin: 0px;
        padding: 0;
      }

      html body li * {
        float: left;
      }

      html body li, html body h3 {
        clear :both;
        list-style :none;
      }

      html body input, html body button {
        outline: none;
      }

      html body button {
        background: none;
        border: 0px;
        color: #888888;
        font-size: 15px;
        width: 15%;
        margin: 10px 0 0;
        font-family: Lato, sans-serif;
        cursor: pointer;
      }




      html body button :hover {
        color: #333;
      }

      /* Heading */
      html body h3,
      html body label[for='new-task'] {
        color: #333333;
        font-weight: 700;
        font-size: 15px;
        border-bottom: 2px solid #333;
        padding: 30px 0 10px;
        margin: 0px;
        text-transform: uppercase;
      }

      html body input[type="text"]  {
        margin: 0;
        font-size: 18px;
        line-height: 18px;
        height: 18px;
        padding: 10px;
        border: 1px solid #ddd;
        background: #fff;
        border-radius: 6px;
        font-family: Lato, sans-serif;
        color: #888;
      }

      html body input[type="text"] :focus {
        color: #333;
      }

      /* New Task */
      html body input#new-task   {
        float: left;
        width: 318px;
      }

      html body p > button :hover {
        color: #0FC57C;
      }

      /* Task list */
      html body li {
        overflow: hidden;
        padding: 20px 0px;
        border-bottom: 1px solid #eee;
      }

      html body li > input[type="checkbox"] {
        margin: 0 10px;
        position: relative;
        top: 15px;
      }

      html body li > label {
        font-size:18px;
        line-height: 40px;
        width: 237px;
        padding:0 0 0 11px;
      }
  
      html body li >  input[type="text"] {
        width: 226px;
      }

      html body li > .delete :hover {
        color: #CF2323;
      }

      /* Completed */
      html body #completed-tasks label {
        text-decoration: line-through;
        color: #888;
      }

      /* Edit Task */
      html body ul li input[type=text] {
        display :none;
      }

      html body ul li.editMode input[type=text] {
        display :block;
      }

      html body ul li.editMode label {
        display :none;
      }

      .col-25 {
          float: left;
          width: 25%;
          margin-top: 6px;
        }

        /* Floating column for inputs: 75% width */
        .col-75 {
          float: left;
          width: 75%;
          margin-top: 6px;
        }

      @media screen and (max-width: 600px) {
        .col-25, .col-75, input[type=submit] {
            width: 100%;
            margin-top: 0;
        }
      }
    </style>

  </head>

  <body>
      <div class="container">
          <div class="col-25">
              <label id="new-task-label" for="new-task" style="display: block; margin: 0 0 20px">
                  <b>Add Item</b>
              </label>
              <input id="new-task" type="text">
              <button id="btnAdd"><u>A</u>dd</button>
          </div>

          <h3>
            <b>Todo</b>
          </h3>
          <ul id="incomplete-tasks">
              <li>
                  <input type="checkbox">
                  <label>Pay Bills</label>
                  <input type="text">
                  <button class="edit">Edit</button>
                  <button class="delete">Delete</button>
              <li>
                  <input type="checkbox">
                  <label>Go Shopping</label>
                  <input type="text" value="Go Shopping">
                  <button class="edit">Edit</button>
                  <button class="delete">Delete</button>
              </li>
          </ul>

          <h3>
            <b>Completed</b>
          </h3>
          <ul id="completed-tasks">
              <li>
                  <input type="checkbox" checked>
                  <label>See the Doctor</label>
                  <input type="text">
                  <button class="edit">Edit</button>
                  <button class="delete">Delete</button>
              </li>
          </ul>
      </div>

      <script>
          window.addEventListener('keyup', function (e) {
              var result = e.which;
              if (result == 65)
              {
                  document.getElementById('btnAdd').click(); return false;
              }
          });

        var taskInput = document.getElementById("new-task");
        var addButton = document.getElementsByTagName("button")[0];
        var incompleteTasksHolder = document.getElementById("incomplete-tasks");
        var completedTasksHolder = document.getElementById("completed-tasks");

        var createNewTaskElement = function(taskString, arr) {
          listItem = document.createElement("li");
          checkBox = document.createElement("input");
          label = document.createElement("label");
          editInput = document.createElement("input");
          editButton = document.createElement("button");
          deleteButton = document.createElement("button");

          checkBox.type = "checkbox";
          editInput.type = "text";
          editButton.innerText = "Edit";
          editButton.className = "edit";
          deleteButton.innerText = "Delete";
          deleteButton.className = "delete";
          label.innerText = taskString;

          listItem.appendChild(checkBox);
          listItem.appendChild(label);
          listItem.appendChild(editInput);
          listItem.appendChild(editButton);
          listItem.appendChild(deleteButton);

          return listItem;
        };

          var addTask = function () {
              if (taskInput.value != "") {
                  var listItemName = taskInput.value || "New Item"
                  listItem = createNewTaskElement(listItemName)
                  incompleteTasksHolder.appendChild(listItem)
                  localStorage.setItem(taskInput.value, taskInput.value);
                  bindTaskEvents(listItem, taskCompleted)
                  taskInput.value = "";
              }
              else
              {
                  alert("Please enter a value before continue");
              }
        };

        var editTask = function () {
          var listItem = this.parentNode;
          var editInput = listItem.querySelectorAll("input[type=text")[0];
          var label = listItem.querySelector("label");
          var button = listItem.getElementsByTagName("button")[0];

          var containsClass = listItem.classList.contains("editMode");
          if (containsClass) {
              label.innerText = editInput.value
              button.innerText = "Edit";
          } else {
             editInput.value = label.innerText
             button.innerText = "Save";
          }
          
          listItem.classList.toggle("editMode");
        };

        var deleteTask = function (el) {
          var listItem = this.parentNode;
          var ul = listItem.parentNode;
          ul.removeChild(listItem);
        };

        var taskCompleted = function (el) {
          var listItem = this.parentNode;
          completedTasksHolder.appendChild(listItem);
          bindTaskEvents(listItem, taskIncomplete);
        };

        var taskIncomplete = function() {
          var listItem = this.parentNode;
          incompleteTasksHolder.appendChild(listItem);
          bindTaskEvents(listItem, taskCompleted);
        };

        var bindTaskEvents = function(taskListItem, checkBoxEventHandler, cb) {
          var checkBox = taskListItem.querySelectorAll("input[type=checkbox]")[0];
          var editButton = taskListItem.querySelectorAll("button.edit")[0];
          var deleteButton = taskListItem.querySelectorAll("button.delete")[0];
          editButton.onclick = editTask;
          deleteButton.onclick = deleteTask;
          checkBox.onchange = checkBoxEventHandler;
        };

        addButton.addEventListener("click", addTask);

        for (var i = 0; i < incompleteTasksHolder.children.length; i++) {
          bindTaskEvents(incompleteTasksHolder.children[i], taskCompleted);
        }

        for (var i = 0; i < completedTasksHolder.children.length; i++) {
          bindTaskEvents(completedTasksHolder.children[i], taskIncomplete);
        }



      </script>

  </body>

</html>


