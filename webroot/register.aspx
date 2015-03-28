<%@ Page Language="C#" %>

<%@ Assembly Name="MySql.Data" %>
<%@ Assembly Name="HtmlAgilityPack" %>
<%@ Import namespace="MySql.Data.MySqlClient" %>
<%@ Import namespace="System.Net" %>
<%@ Import namespace="HtmlAgilityPack" %>

<script runat="server">

    //Because mono is fucking stupid
    public static bool Validator(object sender, System.Security.Cryptography.X509Certificates.X509Certificate certificate, System.Security.Cryptography.X509Certificates.X509Chain chain,
                                      System.Net.Security.SslPolicyErrors sslPolicyErrors)
    {
        return true;
    }

    public void doRegister(object sender, EventArgs e)
    {
        
        if (pass1.Text != pass2.Text)
        {
            return;
        }
        
        //Because mono is fucking stupid
        ServicePointManager.ServerCertificateValidationCallback = Validator;
        
        string username = nnid.Text;
        string password = pass1.Text;

        nnid.Text = "";

        WebClient client = new WebClient();
        client.Encoding = Encoding.UTF8;

        string html;
        
        try
        {
            html = client.DownloadString("https://mariokart.tv/de/users/" + username);
        }
        catch (WebException error) {
            
            HttpWebResponse errorResponse = (HttpWebResponse)error.Response;

            if (errorResponse.StatusCode == HttpStatusCode.NotFound)
            {
                confirmMessage.Text = "Invalid NNID";
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
        
        string myConnectionString = "server=192.168.0.23;uid=kartershop;pwd=ShQP7U2TrEVLzUFA;database=kartershop;port=3306;Charset=utf8";
        MySqlConnection sql = new MySqlConnection(myConnectionString);


	sql.Open();


    string query = "INSERT INTO  `kartershop`.`Users` (`Password` , `NNID`, `MiiName`, `MiiIcon`, `VR`) VALUES (@Password,  @Nnid, @MiiName, @MiiIcon, @VR);";

    MySqlCommand cmd = new MySqlCommand(query, sql);

    cmd.Parameters.AddWithValue("Password", password);
    cmd.Parameters.AddWithValue("Nnid", username);

    cmd.Parameters.AddWithValue("MiiName", miiName);
    cmd.Parameters.AddWithValue("MiiIcon", miiIcon);
    cmd.Parameters.AddWithValue("VR", vr);
    try
    {
        cmd.ExecuteNonQuery();
    }
    catch (MySqlException ex)
    {
        if (ex.ErrorCode == 1062)
        {
            confirmMessage.Text = "NNID already registered";
            return;
        }
    }
        
    Response.Redirect("login.aspx");


    }
    
</script>

<html>
  <head>
      <title>KarterShop - Register new account</title>
    <meta content="text/html; charset=windows-1252" http-equiv="content-type">
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"
      rel="stylesheet">
    <link href="dist/css/roboto.min.css" rel="stylesheet">
    <link href="dist/css/material.min.css" rel="stylesheet">
    <link href="dist/css/ripples.min.css" rel="stylesheet">
  </head>
  <body>
      <div style="top:0px; margin-left:auto; margin-right: auto;">
          <img src="img/Banner.png" style="width:100%;" class="shadow-z-3"/>
      </div>
    <div style="display: inline-block; position: fixed; top: 0px; bottom: 0px; left: 0px; right: 0px; width: 1000px; height: 282px; margin: auto;">
      <h1 style="text-align: center;">Register for the Mario Kart 8 KarterShop
        league:</h1>
      <br>
        <form runat="server">
      <table style="text-align:center; width:20%; margin-left:auto; margin-right:auto;" border="0">
        <tbody>
          <tr>
            <td> <asp:Textbox id="nnid" placeholder="Nintendo Network ID" class="form-control empty floating-label"
                onkeyup="checkPass(); return false;" runat="server"> </asp:Textbox><br>
            </td>
          </tr>
          <tr>
            <td> <asp:Textbox placeholder="KarterShop Password" id="pass1"
                class="form-control empty floating-label" onkeyup="checkPass(); return false;"
                TextMode="password" runat="server"></asp:Textbox> <br>
            </td>
          </tr>
          <tr>
            <td> <asp:Textbox placeholder="Confirm Password" id="pass2"
                class="form-control empty floating-label" onkeyup="checkPass(); return false;"
                TextMode="password" runat="server"></asp:Textbox> <br>
            </td>
          </tr>
          <tr>
            <td style="text-align: center;"> <asp:Button Text="Please enter your NNID" class="btn btn-danger" style="left:0px;" id="confirmMessage" runat="server" OnClick="doRegister" disabled></asp:Button> <br>
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
            $(document).ready(function() {
                // This command is used to initialize some elements and make them work properly
                $.material.init();
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
        button.value = "Register";

    if(pass1.value != pass2.value){
        button.disabled = true;
        button.className = "btn btn-warning";
        button.value = "Passwords do not match";
    }

    if (pass1.value.length < 5) {
        button.disabled = true;
        button.className = "btn btn-danger";
        button.value = "Your password is too short";
    }
    if (nnid.value.trim() == "") {
        button.disabled = true;
        button.className = "btn btn-danger";
        button.value = "Please enter your NNID";
    }
}  </script>
  </body>
</html>
