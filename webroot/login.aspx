<%@Page Language="C#" Debug="true"%>

<%@ Assembly Name="MySql.Data" %>
<%@ Assembly Name="HtmlAgilityPack" %>
<%@ Import namespace="MySql.Data.MySqlClient" %>
<%@ Import namespace="System.Net" %>
<%@ Import namespace="HtmlAgilityPack" %>


<script runat="server">

    public static bool Validator(object sender, System.Security.Cryptography.X509Certificates.X509Certificate certificate, System.Security.Cryptography.X509Certificates.X509Chain chain,
                                      System.Net.Security.SslPolicyErrors sslPolicyErrors)
    {
        return true;
    }

    protected void DoLogin(object sender, EventArgs e)
    {

        //Because mono is fucking stupid
        ServicePointManager.ServerCertificateValidationCallback = Validator;

        

        string myConnectionString = "server=192.168.0.23;uid=kartershop;pwd=ShQP7U2TrEVLzUFA;database=kartershop;port=3306;Charset=utf8";
        MySqlConnection sql = new MySqlConnection(myConnectionString);

	sql.Open();

        string username = nnid.Text;
        string password = pass.Text;

        nnid.Text = "";

        string query = "SELECT ID, CurrentRoom FROM  `Users` WHERE  `Password` =  @Password AND  `NNID` =  @Nnid";

        MySqlCommand cmd = new MySqlCommand(query, sql);

        cmd.Parameters.AddWithValue("Password", password);
        cmd.Parameters.AddWithValue("Nnid", username);

        MySqlDataReader reader = cmd.ExecuteReader();

        reader.Read();


        if (reader.HasRows)
        {

            Session.Add("UserID", reader["ID"]);
            Session.Add("CurrentRoom", reader["CurrentRoom"]);
            Session.Add("NNID", username);

            object id = reader["ID"];

            reader.Close();

            UpdateUserInfo(id, username);

            Response.Redirect("index.aspx");
        }
        else
        {
            isLoginBad.Value = "yes";
        }

        sql.Close();
    }

    public void UpdateUserInfo(object id, string nnid)
    {
        WebClient client = new WebClient();
        client.Encoding = Encoding.UTF8;

        string html;

        try
        {
            html = client.DownloadString("https://mariokart.tv/de/users/" + nnid);
        }
        catch (WebException error)
        {

            HttpWebResponse errorResponse = (HttpWebResponse)error.Response;

            if (errorResponse.StatusCode == HttpStatusCode.NotFound)
            {
                return;
            }
            else
            {
                throw error;
            }

        }
        
        HtmlDocument userPage = new HtmlDocument();
        userPage.LoadHtml(html);

        string miiName = userPage.DocumentNode.SelectSingleNode("//*[@id=\"users\"]/div/div[2]/div[1]/div[2]/div/section/h2/span[2]").InnerHtml.Trim();
        string miiIcon = userPage.DocumentNode.SelectSingleNode("//*[@id=\"users\"]/div/div[2]/div[1]/div[2]/div/section/h2/span[1]/img").Attributes["src"].Value;
        int vr = int.Parse(userPage.DocumentNode.SelectSingleNode("//*[@id=\"users\"]/div/div[2]/div[1]/div[2]/div/div/section[1]/p").InnerHtml.Trim());

        Session.Add("MiiName", miiName);
        Session.Add("MiiIcon", miiIcon);
        Session.Add("VR", vr);
    }
</script>

<% Session.Clear(); %>

<html>
  <head>
    <meta content="text/html; charset=windows-1252" http-equiv="content-type">
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"

      rel="stylesheet">
          <title>KarterShop - Login</title>
    <link href="dist/css/roboto.min.css" rel="stylesheet">
    <link href="dist/css/material.min.css" rel="stylesheet">
    <link href="dist/css/ripples.min.css" rel="stylesheet">
  </head>
  <body>
      <div style="top:0px; margin-left:auto; margin-right: auto;">
          <img src="img/Banner.png" style="width:100%;" class="shadow-z-3"/>
      </div>
    <div style="display: inline-block; position: fixed; top: 0px; bottom: 0px; left: 0px; right: 0px; width: 1000px; height: 282px; margin: auto;">
      <h1 style="text-align: center;">Welcome to the Mario Kart 8 KarterShop
        league.</h1>
      <br>
      <form runat="server" id="login">
      <table align="center" border="0" width="20%">
          <%
              if (isLoginBad.Value == "yes")
              {
                  Response.Write("<div class=\"alert alert-dismissable alert-danger\" style=\"text-align: center; width: 50%; margin-left:auto; margin-right:auto\"> <button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button> <strong>Could not log in</strong> <br/> You used a bad NNID or password. Please check the spelling or, if you don't have an account, <a href=\" register.aspx \" class=\"alert-link\">register</a> and try again. </div>");
              }
               %>
        <tbody>
            <asp:HiddenField ID="isLoginBad" runat="server"/>
          <tr>
            <td> <asp:Textbox ID="nnid" placeholder="Nintendo Network ID" class="form-control empty floating-label"

                runat="server"></asp:Textbox> <br />
            </td>
          </tr>
          <tr>
            <td> <asp:Textbox ID="pass" placeholder="KarterShop Password" class="form-control empty floating-label"

                TextMode="password" runat="server"></asp:Textbox> <br>
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
