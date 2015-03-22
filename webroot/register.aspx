<html>
  <head>
    <meta content="text/html; charset=windows-1252" http-equiv="content-type">
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"
      rel="stylesheet">
    <!-- Include roboto.css to use the Roboto web font, material.css to include the theme and ripples.css to style the ripple effect -->
    <link href="dist/css/roboto.min.css" rel="stylesheet">
    <link href="dist/css/material.min.css" rel="stylesheet">
    <link href="dist/css/ripples.min.css" rel="stylesheet">
  </head>
  <body>
    <!-- Your site -->
    <div style="display: inline-block; position: fixed; top: 0px; bottom: 0px; left: 0px; right: 0px; width: 1000px; height: 282px; margin: auto;">
      <h1 style="text-align: center;">Register for the Mario Kart 8 KarterShop
        league:</h1>
      <br>
      <table style="text-align:center; width:20%; margin-left:auto; margin-right:auto;" border="0">
        <tbody>
          <tr>
            <td> <input name="nnid" id="nnid" placeholder="Nintendo Network ID" class="form-control empty floating-label"
                type="text" onkeyup="checkPass(); return false;"> <br>
            </td>
          </tr>
          <tr>
            <td> <input name="password" placeholder="KarterShop Password" id="pass1"
                class="form-control empty floating-label" onkeyup="checkPass(); return false;"
                type="password"> <br>
            </td>
          </tr>
          <tr>
            <td> <input name="confirmpassword" placeholder="Confirm Password" id="pass2"
                class="form-control empty floating-label" onkeyup="checkPass(); return false;"
                type="password"> <br>
            </td>
          </tr>
          <tr>
            <td style="text-align: center;"> <button class="btn btn-success" style="left:0px;" id="confirmMessage">
                Register </button> <br>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div style="text-align: center; height: 229px;"><!-- Your site ends --> </div>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <script src="js/ripples.min.js"></script>
    <script src="js/material.min.js"></script>
    <script>
            $(document).ready(function() {
                // This command is used to initialize some elements and make them work properly
                $.material.init();
                checkPass();
            });
        </script>
    <script>
    function checkPass()
{
        var nnid = document.getElementById('nnid');
    var pass1 = document.getElementById('pass1');
    var pass2 = document.getElementById('pass2');
    var button = document.getElementById('confirmMessage');
  

        button.disabled = false;
        button.className = "btn btn-success";
        button.innerHTML = "Register";

    if(pass1.value != pass2.value){
        button.disabled = true;
        button.className = "btn btn-warning";
        button.innerHTML = "Passwords do not match";
    }

    if (pass1.value.length < 5) {
        button.disabled = true;
        button.className = "btn btn-danger";
        button.innerHTML = "Your password is too short";
    }
    if (nnid.value.trim() == "") {
        button.disabled = true;
        button.className = "btn btn-danger";
        button.innerHTML = "Please enter your NNID";
    }
}  </script>
  </body>
</html>
