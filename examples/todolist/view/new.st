<html>
<head>
    <title>TodoList</title>
    <style>
        table {
            width: 100%;
        }

        tr {
            background: #efe;
            width: 100%;
        }

        tr:hover {
            background: #dfd;
        }

        td.title {
            font-weight: bold;
            width: 60%;
        }

        td.status {
            margin: 1em;
        }

        a {
            color: #3a3;
        }
    </style>
</head>
<body>
<h1>New Task</h1>
<a href="/">Back to TodoList</a>
<form method="POST" action="create">
  Task: <input type="text" name="title" /><br />
  <input type="submit" />
</form>

</body>
</html>