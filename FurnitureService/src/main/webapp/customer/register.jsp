<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration Form</title>
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
 


    <h2 class="mb-4">Customer Registration</h2>
    <form id="registrationForm" action="register" method="post">
        <div class="form-group">
            <label for="customerName">Customer Name</label>
            <input type="text" class="form-control" id="customerName" name="customerName" placeholder="Enter your name" required>
        </div>
        <div class="form-group">
            <label for="customerAddress">Customer Address</label>
            <input type="text" class="form-control" id="customerAddress" name="customerAddress" placeholder="Enter your address" required>
        </div>
        <div class="form-group">
            <label for="customerContact">Customer Contact</label>
            <input type="tel" class="form-control" id="customerContact" name="customerContact" placeholder="Enter your contact number" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
        <button type="button" class="btn btn-secondary ml-2" onclick="clearForm()">Clear</button>
    </form>
</div>
</div>
<div class="col">
<img class="img-fluid img-thumbnail" src="https://img.freepik.com/premium-vector/customer-service-icon-vector-full-customer-care-service-hand-with-persons-vector-illustration_399089-2810.jpg?w=740"/>
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
