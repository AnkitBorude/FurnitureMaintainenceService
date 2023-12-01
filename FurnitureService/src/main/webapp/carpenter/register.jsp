<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 500px;
            margin-top: 50px;
        }
    </style>
</head>
<body>
<div class="row">
<div class="col">
<div class="container">
    <h2 class="mb-4"> Carpenter Registration</h2>
    <form id="registrationForm" method="post" action="register">
        <div class="form-group">
            <label for="name">Name</label>
            <input type="text" class="form-control" id="name" name="name" placeholder="Enter name" required>
        </div>
        <div class="form-group">
            <label for="address">Address</label>
            <input type="text" class="form-control" id="address" name="address" placeholder="Enter address" required>
        </div>
        <div class="form-group">
            <label for="contact">Contact</label>
            <input type="tel" class="form-control" id="contact" name="contact" placeholder="Enter contact number" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter a password" required>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
        <button type="button" class="btn btn-secondary ml-2" onclick="clearForm()">Clear</button>
    </form>
</div>
</div>
<div class="col">
<img class="img-fluid img-thumbnail" src="https://cdn.vectorstock.com/i/1000x1000/82/42/furniture-icon-supermarket-and-shopping-mall-vector-37528242.webp"/>
</div>
</div>
<!-- Bootstrap JS and dependencies (jQuery and Popper.js) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    // JavaScript function to clear the form
    function clearForm() {
        document.getElementById("registrationForm").reset();
    }
</script>

</body>
</html>
