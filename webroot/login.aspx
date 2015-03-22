<%@Page Language="C#"%>

<%@ Assembly Name="MySql.Data" %>
<%@ Assembly Name="HtmlAgilityPack" %>
<%@ Import namespace="MySql.Data.MySqlClient" %>
<%@ Import namespace="System.Net" %>
<%@ Import namespace="HtmlAgilityPack" %>

<script runat="server">
    protected void DoLogin(object sender, EventArgs e)
    {
        string myConnectionString = "server=127.0.0.1;uid=kartershop;pwd=ShQP7U2TrEVLzUFA;database=kartershop;port=3306;";
        MySqlConnection sql = new MySqlConnection(myConnectionString);

	sql.Open();

        string username = nnid.Text;
        string password = pass.Text;

        string query = "SELECT ID FROM  `Users` WHERE  `Password` =  '@Password' AND  `NNID` =  '@Nnid'";

        MySqlCommand cmd = new MySqlCommand(query);

        cmd.Parameters.AddWithValue("Password", password);
        cmd.Parameters.AddWithValue("Nnid", username);

        MySqlDataReader reader = cmd.ExecuteReader();

        if (reader.HasRows)
        {
            Session.Add("UserID", reader["ID"]);
            Session.Add("NNID", nnid);

            Response.Redirect("index.aspx");
        }
        else
        {
            loginButton.Text = "Wrong NNID or password";
        }
    }
</script>

<html>
  <head>
    <meta content="text/html; charset=windows-1252" http-equiv="content-type">
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"

      rel="stylesheet">
          <title>KarterShop - Login</title>
    <!-- Include roboto.css to use the Roboto web font, material.css to include the theme and ripples.css to style the ripple effect -->
    <link href="dist/css/roboto.min.css" rel="stylesheet">
    <link href="dist/css/material.min.css" rel="stylesheet">
    <link href="dist/css/ripples.min.css" rel="stylesheet">
  </head>
  <body>
    <!-- Your site -->
    <div style="display: inline-block; position: fixed; top: 0px; bottom: 0px; left: 0px; right: 0px; width: 1000px; height: 282px; margin: auto;">
      <h1 style="text-align: center;">Welcome to the Mario Kart 8 KarterShop
        league.</h1>
      <br>
      <form runat="server" id="login">
      <table align="center" border="0" width="20%">
        <tbody>
          <tr>
            <td> <asp:Textbox ID="nnid" placeholder="Nintendo Network ID" class="form-control empty floating-label"

                runat="server"></asp:Textbox> <br />
            </td>
          </tr>
          <tr>
            <td> <asp:Textbox ID="pass" placeholder="KarterShop Password" class="form-control empty floating-label"

                type="password" runat="server"></asp:Textbox> <br>
            </td>
          </tr>
          <tr>
            <td style="text-align: center;"> <asp:Button class="btn btn-success" ID="loginButton" Text="Login" style="left:0px;" runat="server" OnClick="DoLogin"></asp:Button> <br>
            </td>
          </tr>
          <tr>
            <td style="text-align: center;"> <a class="btn btn-warning" href="register.aspx" style="left:0px;">
                Register </a> <br>
            </td>
          </tr>
        </tbody>
      </table>
      </form>
    </div>
    <div style="text-align: center; height: 229px;"><!-- Your site ends --> </div>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <script src="js/ripples.min.js"></script>
    <script src="js/material.min.js"></script>

    <script>
        $(document).ready(function () {
            // This command is used to initialize some elements and make them work properly
            $.material.init();
        });
        </script>
    
  </body>
</html>
