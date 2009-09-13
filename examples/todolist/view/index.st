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
<h1>$heading$</h1>
<a href="/new">New Task</a>
<table>
    $tasks:tasks()$
</table>
</body>
</html>