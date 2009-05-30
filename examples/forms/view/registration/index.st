<html>
	<head>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8">
		<title>Registration</title>
	</head>
	<body>
		<h3>Registration</h3>
		<div class="form" id="regirationForm">
			<span>$message$</span>
			<form action="/registration/save" method="post" accept-charset="utf-8">
				$form:{
				<input type="hidden" name="key" value="$key$">
				<label for="name">Name</label>
				<input type="text" name="name" value="$name$">
				<label for="name">Address</label>
				<input type="text" name="address" value="$address$">
				<label for="name">Email</label>
				<input type="text" name="email" value="$email$">
				<label for="name">Phone</label>
				<input type="text" name="phone" value="$phone$">
				<input type="submit" name="save" value="Save Me!">
				}$
			</form>
		</div>
	</body>
</html>