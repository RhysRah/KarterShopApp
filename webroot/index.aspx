<%@Page Language="C#"%>

<%@ Assembly Name="MySql.Data" %>
<%@ Assembly Name="HtmlAgilityPack" %>
<%@ Import namespace="MySql.Data.MySqlClient" %>
<%@ Import namespace="System.Net" %>
<%@ Import namespace="HtmlAgilityPack" %>


<script runat="server">

    protected void registerButton_Click(object sender, EventArgs e)
    {
        string myConnectionString = "server=192.168.0.23;uid=kartershop;pwd=ShQP7U2TrEVLzUFA;database=kartershop;port=3306;Charset=utf8";
        MySqlConnection sql = new MySqlConnection(myConnectionString);

	    sql.Open();

        bool canHost = host.Checked;
        bool isParticipating = register.Checked;
        

        if (isParticipating)
        {
            string getRoomsQuery = "SELECT ID, ABS(" + Session["VR"].ToString() + " - AverageVR) AS Distance FROM Rooms WHERE (SELECT COUNT(*) FROM Users WHERE CurrentRoom = `Rooms`.ID) < 12 ORDER BY Distance LIMIT 1";

            string updateRoomAverageVRQuery = "UPDATE `kartershop`.`Rooms` SET `AverageVR` = (SELECT AVG(VR) FROM Users Where CurrentRoom = @RoomID) WHERE `Rooms`.`ID` = @RoomID";

            string addUserToRoomQuery = "UPDATE Users SET CurrentRoom = @Room WHERE ID = " + Session["UserID"].ToString();
        }
        else
        {
            string searchForHosts = "SELECT ID FROM Users WHERE CanHost = 1 AND IsHost = 0 AND CurrentRoom = (SELECT CurrentRoom FROM Users WHERE ID = " + Session["UserID"] + ")";
            MySqlCommand searchCmd = new MySqlCommand(searchForHosts, sql);
            
            MySqlDataReader rdr = searchCmd.ExecuteReader();

            if (rdr.HasRows)
            {
                string changeHost = "UPDATE Users SET IsHost = 1 WHERE CanHost = 1 AND IsHost = 0 AND CurrentRoom = (SELECT CurrentRoom FROM Users WHERE ID = " + Session["UserID"] + ") LIMIT 1";
                searchCmd.CommandText = changeHost;
                searchCmd.ExecuteNonQuery();
            }
            else
            {
                string moveHostToRoom = "UPDATE Users SET CurrentRoom = " + Session["CurrentRoom"] + " WHERE CanHost = 1 AND IsHost = 0 ORDER BY ABS( VR - "+ Session["VR"] + ") LIMIT 1";
                searchCmd.CommandText = moveHostToRoom;
                int rows = searchCmd.ExecuteNonQuery();

                if (rows == 0)
                {
                    //move everyone to waitlist
                }
                
            }
            
            string removeUser = "UPDATE Users SET CurrentRoom = 0 WHERE ID = " + Session["ID"].ToString();
            MySqlCommand command = new MySqlCommand(removeUser, sql);
            command.ExecuteNonQuery();
        }
    }
</script>



<%


    string vr = "";
    string miiName = "";
    string miiIcon = "";
        
    try
    {
        vr = Session["VR"].ToString();
        miiName = Session["MiiName"].ToString();
        miiIcon = Session["MiiIcon"].ToString();
    }
    catch
    {
        Response.Redirect("login.aspx");
    }
    
    
        string myConnectionString = "server=192.168.0.23;uid=kartershop;pwd=ShQP7U2TrEVLzUFA;database=kartershop;port=3306;Charset=utf8";
        MySqlConnection sql = new MySqlConnection(myConnectionString);

	    sql.Open();

        string getUserRoom = "select AverageVR from Rooms where ID = ( select CurrentRoom from Users where ID = 54)";
            MySqlCommand command = new MySqlCommand(getUserRoom, sql);
            object roomAverageVR = command.ExecuteScalar();

            bool isInRoom = false;

            if (roomAverageVR != null)
            {
                isInRoom = true;
            }
    
     %>

<html>
  <head>
      <title>KarterShop</title>
    <meta content="text/html; charset=windows-1252" http-equiv="content-type">
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"
      rel="stylesheet">
    <link href="dist/css/roboto.min.css" rel="stylesheet">
    <link href="dist/css/material.min.css" rel="stylesheet">
    <link href="dist/css/ripples.min.css" rel="stylesheet">
  </head>
  <body>
    <div style="text-align: center;"></div>
    <table style="width: 95%; height: 100%; text-align: left; margin-left: auto; margin-right: auto;"
      border="0">
      <tbody>
        <tr>
          <td style="width:50%; padding:10px;"><br>
            <div class="shadow-z-1" style="background-color:white;">
              <div style="padding: 20px; height:100%">
                <h1 style="  text-align: center;">Welcome!</h1>
                <p><br>
                </p>
                <table style="width: 100%; height: 200px;" border="0">
                  <tbody>
                    <tr>
                      <td style="text-align: center;" class="shadow-z-1">
                        <h2 style="height: 84px;"><img style="width: 65px; height: 61px; margin-top: -12px;"
                            title="Mii Icon" alt="" src="<% Response.Write(miiIcon); %>"> <% Response.Write(miiName); %> </h2>
                        <h2 style="height: 84px;"><% Response.Write(vr); %> VR</h2>
                        <h3><img style="width: 151px; height: 74px;" alt="" src="img/mktv.png">
                        </h3>
                        <h3>[Verified/Unverified]</h3>
                        <br>
                        <div><br>
                        </div>
                        <div> <button class="btn btn-success" style="height: 100px; width:80%; font-weight: bold; left:0px;">Shop</button></div>
                        <div> <a href="login.aspx" class="btn btn-warning" style="width:40%; left:0px;">Logout</a>
                          <button class="btn btn-primary" style="width:40%; left:0px;">Options</button></div>
                      </td>
                      <td style="text-align: right" class="shadow-z-2"> <br>
                        <h3 style="text-align: center;">[coin icon] [coins]</h3>
                        <p><br>
                        </p>
                        <h3 style="text-align: center;">Total ranked score :
                          [points]</h3>
                        <p><br>
                        </p>
                        <p><br>
                        </p>
                        <p><br>
                        </p>
                        <h2 style=" text-align: center;">Top ranking players:</h2>
                        <p><br>
                        </p>
                        <h3 style="height: 84px; text-align: center;"><img style="width: 65px; height: 61px; margin-top: -12px;"
                            title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">[Mii
                          name] - [Score]</h3>
                        <h3 style="height: 84px; text-align: center;"><img style="width: 65px; height: 61px; margin-top: -12px;"
                            title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">[Mii
                          name] - [Score]</h3>
                        <h3 style="height: 84px; text-align: center;"><img style="width: 65px; height: 61px; margin-top: -12px;"
                            title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">[Mii
                          name] - [Score]</h3>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </td>
          <td style="padding:10px;">
            <div class="shadow-z-1" style="background-color:white;">
              <div style="padding: 20px;"><br>
                  <%
                      string currentResponse;
                      if(isInRoom){
                      currentResponse = "<h1 style=\"text-align: center;\">Your room for round [Week Number]</h1><br /> <h3 style=\"text-align: center;\"> Average VR: " + roomAverageVR.ToString() + "</h3>"; 
                  }
                  else{
                      currentResponse = "<h1 style=\"text-align: center;\">You are not registered for [Week Number]</h1><br />"; 
                  }

                      Response.Write(currentResponse); %>
                <p><br>
                </p>
                <table style="width:100%;">
                  <tbody>
                    <tr>
                      <td>
                        <table style="width: 100%; height: 200px; padding:10px"
                          class="shadow-z-2" border="0">
                          <tbody>
                            <tr style="padding:10px; color:red;">
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: right"> [Mii Name] </h3>
                              </td>
                              <td style="text-align: center; width:10%; padding:10px;">
                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                  title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">
                              </td>
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: left; "> [NNID] </h3>
                              </td>
                            </tr>
                            <tr style="padding:10px;">
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: right"> [Mii Name] </h3>
                              </td>
                              <td style="text-align: center; width:10%; padding:10px;">
                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                  title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">
                              </td>
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: left; "> [NNID] </h3>
                              </td>
                            </tr>
                            <tr style="padding:10px;">
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: right"> [Mii Name] </h3>
                              </td>
                              <td style="text-align: center; width:10%; padding:10px;">
                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                  title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">
                              </td>
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: left; "> [NNID] </h3>
                              </td>
                            </tr>
                            <tr style="padding:10px;">
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: right"> [Mii Name] </h3>
                              </td>
                              <td style="text-align: center; width:10%; padding:10px;">
                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                  title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">
                              </td>
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: left; "> [NNID] </h3>
                              </td>
                            </tr>
                            <tr style="padding:10px;">
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: right"> [Mii Name] </h3>
                              </td>
                              <td style="text-align: center; width:10%; padding:10px;">
                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                  title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">
                              </td>
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: left; "> [NNID] </h3>
                              </td>
                            </tr>
                            <tr style="padding:10px;">
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: right"> [Mii Name] </h3>
                              </td>
                              <td style="text-align: center; width:10%; padding:10px;">
                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                  title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">
                              </td>
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: left; "> [NNID] </h3>
                              </td>
                            </tr>
                          </tbody>
                        </table>
                      </td>
                      <td>
                        <table style="width: 100%; height: 200px; padding:10px"
                          class="shadow-z-2" border="0">
                          <tbody>
                            <tr style="padding:10px;">
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: right"> [Mii Name] </h3>
                              </td>
                              <td style="text-align: center; width:10%; padding:10px;">
                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                  title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">
                              </td>
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: left; "> [NNID] </h3>
                              </td>
                            </tr>
                            <tr style="padding:10px;">
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: right"> [Mii Name] </h3>
                              </td>
                              <td style="text-align: center; width:10%; padding:10px;">
                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                  title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">
                              </td>
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: left; "> [NNID] </h3>
                              </td>
                            </tr>
                            <tr style="padding:10px;">
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: right"> [Mii Name] </h3>
                              </td>
                              <td style="text-align: center; width:10% ;padding:10px;">
                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                  title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">
                              </td>
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: left; "> [NNID] </h3>
                              </td>
                            </tr>
                            <tr style="padding:10px;">
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: right"> [Mii Name] </h3>
                              </td>
                              <td style="text-align: center; width:10% ;padding:10px;">
                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                  title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">
                              </td>
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: left; "> [NNID] </h3>
                              </td>
                            </tr>
                            <tr style="padding:10px;">
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: right"> [Mii Name] </h3>
                              </td>
                              <td style="text-align: center; width:10%; padding:10px;">
                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                  title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">
                              </td>
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: left; "> [NNID] </h3>
                              </td>
                            </tr>
                            <tr style="padding:10px;">
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: right"> [Mii Name] </h3>
                              </td>
                              <td style="text-align: center; width:10%; padding:10px;">
                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                  title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">
                              </td>
                              <td style="width:45%; padding:10px;">
                                <h3 style="text-align: left; "> [NNID] </h3>
                              </td>
                            </tr>
                          </tbody>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
                <div class="shadow-z-1" style="padding:15px"> <br>
                  <div style="text-align: center;">Registrations for the next
                    round are <span style="font-weight: bold;">[Open/Closed]</span>
                    [for [timer]].<br>
                  </div>
                    <br />
                    <form runat="server">                  <div style="text-align: center;" class="togglebutton-material-green togglebutton"> <label> <asp:Checkbox
                        ID="register" runat="server"></asp:Checkbox> <span style="font-weight: bold;">I
                        am participating in the next round.<br>
                      </span></label>
                      <br />
                    <div style="text-align: center;" class="togglebutton-material-deep-orange togglebutton"> <label>
                        <asp:Checkbox ID="host" runat="server"></asp:Checkbox> <span style="font-weight: bold;">I
                          am willing to host a room.</span> </label> </div>
                      <br />
                    <asp:Button ID="registerButton" class="btn btn-primary" Text="Update Registration" style="width:40%; left:0px;" OnClick="registerButton_Click" runat="server"></asp:Button> <br>
                  </div>
                        </form>
                </div>
              </div>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
    <div style="text-align: center;"> </div>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <script src="js/ripples.min.js"></script>
    <script src="js/material.min.js"></script>
    <script>
            $(document).ready(function() {
                // This command is used to initialize some elements and make them work properly
                $.material.init();
            });
        </script>
  </body>
</html>
