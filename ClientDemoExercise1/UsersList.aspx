<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsersList.aspx.cs" Inherits="ClientDemo1.UserList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Users List</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
    <script src="UsersList.js"></script>
</head>
<body onload="callUsersList();">
    <form id="form1" runat="server">
        <div id="divContainer">
            
        </div>
        <script id="first-template" type="text/x-handlebars-template">
            <div id="usersList">
                <p>{{nameVal}}</p>
                <img src="{{avatarVal}}" />
                <p>{{createdVal}}</p>
                <p>{{idVal}}</p>
            </div>
        </script>
    </form>
</body>
</html>
