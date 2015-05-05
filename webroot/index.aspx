<%@ Page Language="C#" %>

<%@ Assembly Name="MySql.Data" %>
<%@ Assembly Name="HtmlAgilityPack" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="HtmlAgilityPack" %>


<script runat="server">

    protected void registerButton_Click(object sender, EventArgs e)
    {
        string myConnectionString = "server=192.168.0.23;uid=kartershop;pwd=ShQP7U2TrEVLzUFA;database=kartershop;port=3306;Charset=utf8";
        MySqlConnection sql = new MySqlConnection(myConnectionString);

        sql.Open();

        bool canHost = host.Checked;
        bool isParticipating = register.Checked;

        string query;

        if (isParticipating)
        {
            query = "UPDATE Users SET CurrentRoom = 1, CanHost = @Host WHERE ID = " + Session["UserID"].ToString();
            Session["CurrentRoom"] = 1;
        }
        else
        {
            query = "UPDATE Users SET CurrentRoom = 0, CanHost = @Host WHERE ID = " + Session["UserID"].ToString();
            Session["CurrentRoom"] = 0;
        }

        MySqlCommand cmd = new MySqlCommand(query, sql);
        cmd.Parameters.Add("Host", canHost);

        cmd.ExecuteNonQuery();

        sql.Close();

    }

    protected void LoadRoomInfo(HtmlGenericControl miiName, HtmlImage miiIcon, HtmlGenericControl nnid, string name, string icon, string username)
    {
        miiName.InnerHtml = name;
        miiIcon.Src = icon;
        nnid.InnerHtml = username;
    }

    protected void GetRoomMembers(MySqlCommand cmd)
    {
        string getRoomMembersQuery = "SELECT MiiName, MiiIcon, NNID FROM Users WHERE CurrentRoom = " + Session["CurrentRoom"] + " ORDER BY IsHost, VR DESC;";

        cmd.CommandText = getRoomMembersQuery;
        MySqlDataReader reader = cmd.ExecuteReader();

        //ugly as fuck but meh
        if (!reader.Read()) return;
        LoadRoomInfo(p1MiiName, p1MiiIcon, p1nnid, reader["MiiName"].ToString(), reader["MiiIcon"].ToString(), reader["NNID"].ToString());
        if (!reader.Read()) return;
        LoadRoomInfo(p2MiiName, p2MiiIcon, p2nnid, reader["MiiName"].ToString(), reader["MiiIcon"].ToString(), reader["NNID"].ToString());
        if (!reader.Read()) return;
        LoadRoomInfo(p3MiiName, p3MiiIcon, p3nnid, reader["MiiName"].ToString(), reader["MiiIcon"].ToString(), reader["NNID"].ToString());
        if (!reader.Read()) return;
        LoadRoomInfo(p4MiiName, p4MiiIcon, p4nnid, reader["MiiName"].ToString(), reader["MiiIcon"].ToString(), reader["NNID"].ToString());
        if (!reader.Read()) return;
        LoadRoomInfo(p5MiiName, p5MiiIcon, p5nnid, reader["MiiName"].ToString(), reader["MiiIcon"].ToString(), reader["NNID"].ToString());
        if (!reader.Read()) return;
        LoadRoomInfo(p6MiiName, p6MiiIcon, p6nnid, reader["MiiName"].ToString(), reader["MiiIcon"].ToString(), reader["NNID"].ToString());
        if (!reader.Read()) return;
        LoadRoomInfo(p7MiiName, p7MiiIcon, p7nnid, reader["MiiName"].ToString(), reader["MiiIcon"].ToString(), reader["NNID"].ToString());
        if (!reader.Read()) return;
        LoadRoomInfo(p8MiiName, p8MiiIcon, p8nnid, reader["MiiName"].ToString(), reader["MiiIcon"].ToString(), reader["NNID"].ToString());
        if (!reader.Read()) return;
        LoadRoomInfo(p9MiiName, p9MiiIcon, p9nnid, reader["MiiName"].ToString(), reader["MiiIcon"].ToString(), reader["NNID"].ToString());
        if (!reader.Read()) return;
        LoadRoomInfo(p10MiiName, p10MiiIcon, p10nnid, reader["MiiName"].ToString(), reader["MiiIcon"].ToString(), reader["NNID"].ToString());
        if (!reader.Read()) return;
        LoadRoomInfo(p11MiiName, p11MiiIcon, p11nnid, reader["MiiName"].ToString(), reader["MiiIcon"].ToString(), reader["NNID"].ToString());
        if (!reader.Read()) return;
        LoadRoomInfo(p12MiiName, p12MiiIcon, p12nnid, reader["MiiName"].ToString(), reader["MiiIcon"].ToString(), reader["NNID"].ToString());

    }

    protected string GetCountdownText()
    {
        DateTime today = DateTime.Today;
        int daysUntilGoal = ((int)DayOfWeek.Saturday - (int)today.DayOfWeek + 7) % 7;
        DateTime goal = today.AddDays(daysUntilGoal);

        goal = goal.AddHours(20);

        DateTime now = DateTime.Now;

        if (now.Ticks > goal.Ticks)
        {
            return "Registrations are closed!";
        }

        TimeSpan countdown = goal.Subtract(now);

        string text = "The registration deadline is in " + countdown.Days.ToString() + " Day(s), " + countdown.Hours.ToString() + " hours and " + countdown.Minutes.ToString() + " minutes.";
        return text;
    }
    
</script>



<%

    string vr = "";
    string miiName = "";
    string miiIcon = "";
    object userId = "";

    try
    {
        vr = Session["VR"].ToString();
        miiName = Session["MiiName"].ToString();
        miiIcon = Session["MiiIcon"].ToString();
        userId = Session["userId"].ToString();
    }
    catch
    {
        Response.Redirect("login.aspx");
    }


    string myConnectionString = "server=192.168.0.23;uid=kartershop;pwd=ShQP7U2TrEVLzUFA;database=kartershop;port=3306;Charset=utf8";
    MySqlConnection sql = new MySqlConnection(myConnectionString);

    sql.Open();

    string getRegisteredUsers = "SELECT COUNT(*) FROM Users Where CurrentRoom > 0";
    string getRegisteredHosts = "SELECT COUNT(*) FROM Users Where CurrentRoom > 0 AND CanHost = 1";
    string updateUserInfo = "UPDATE Users SET MiiName = @MiiName, MiiIcon = @MiiIcon, VR = @VR WHERE ID = @ID";
    MySqlCommand command = new MySqlCommand(getRegisteredUsers, sql);
    object users = command.ExecuteScalar();
    command.CommandText = getRegisteredHosts;
    object hosts = command.ExecuteScalar();
    command.CommandText = updateUserInfo;
    command.Parameters.AddWithValue("MiiName", miiName);
    command.Parameters.AddWithValue("MiiIcon", miiIcon);
    command.Parameters.AddWithValue("VR", vr);
    command.Parameters.AddWithValue("ID", userId);
    command.ExecuteNonQuery();

    bool isInRoom = (int)Session["CurrentRoom"] != 0;
    bool isMatchmade = (int)Session["CurrentRoom"] > 1;

    if (isMatchmade)
    {
        roomDisplay.Visible = true;
        GetRoomMembers(command);
    }
    else
    {
        roomDisplay.Visible = false;
    }


    sql.Close();

    mktvLink.HRef = "https://mariokart.tv/en_us/users/" + Session["NNID"];
    miiverseLink.HRef = "https://miiverse.nintendo.net/users/" + Session["NNID"];
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
                    <td style="width: 50%; padding: 10px;">
                        <br>
                        <div class="shadow-z-1" style="background-color: white;">
                            <div style="padding: 20px; height: 100%">
                                <h1 style="text-align: center;">Welcome!</h1>
                                <p>
                                    <br>
                                </p>
                                <table style="width: 100%; height: 200px;" border="0">
                                    <tbody>
                                        <tr>
                                            <td style="text-align: center;" class="shadow-z-1">
                                                <h2 style="height: 84px;">
                                                    <img style="width: 65px; height: 61px; margin-top: -12px;"
                                                        title="Mii Icon" alt="" src="<% Response.Write(miiIcon); %>">
                                                    <% Response.Write(miiName); %> </h2>
                                                <h2 style="height: 84px;"><% Response.Write(vr); %> VR</h2>
                                                   <a ID="mktvLink" target="_blank" runat="server"><img class="shadow-z-1-hover" style="width: 151px; height: 74px; margin: 10px" alt="" src="img/mktv.png"></a>
                                                   <a ID="miiverseLink" target="_blank" runat="server"><img class="shadow-z-1-hover" style="height: 74px; height: 74px; margin: 10px" alt="" src="img/miiverse.png"></a>
                                                <br>
                                                <div>
                                                    <br>
                                                </div>
                                                <div>
                                                    <button class="btn btn-success" style="height: 100px; width: 80%; font-weight: bold; left: 0px;">Shop</button>
                                                </div>
                                                <div>
                                                    <a href="login.aspx" class="btn btn-warning" style="width: 40%; left: 0px;">Logout</a>
                                                    <button class="btn btn-primary" data-toggle="modal" data-target="#options" style="width: 40%; left: 0px;">Options</button>
                                                </div>
                                            </td>
                                            <td style="text-align: right" class="shadow-z-2">
                                                <br>
                                                <h3 style="text-align: center;">[coin icon] [coins]</h3>
                                                <p>
                                                    <br>
                                                </p>
                                                <h3 style="text-align: center;">Total ranked score :
                          [points]</h3>
                                                <p>
                                                    <br>
                                                </p>
                                                <p>
                                                    <br>
                                                </p>
                                                <p>
                                                    <br>
                                                </p>
                                                <h2 style="text-align: center;">Top ranking players:</h2>
                                                <p>
                                                    <br>
                                                </p>
                                                <h3 style="height: 84px; text-align: center;">
                                                    <img style="width: 65px; height: 61px; margin-top: -12px;"
                                                        title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">[Mii
                          name] - [Score]</h3>
                                                <h3 style="height: 84px; text-align: center;">
                                                    <img style="width: 65px; height: 61px; margin-top: -12px;"
                                                        title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">[Mii
                          name] - [Score]</h3>
                                                <h3 style="height: 84px; text-align: center;">
                                                    <img style="width: 65px; height: 61px; margin-top: -12px;"
                                                        title="Mii Icon" alt="" src="https://mii-secure.cdn.nintendo.net/iq4ahh9fxt66_normal_face.png">[Mii
                          name] - [Score]</h3>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </td>
                    <td style="padding: 10px;">
                        <div class="shadow-z-1" style="background-color: <% if (isInRoom)
                                                                            {
                                                                                Response.Write("#cfffcf");
                                                                            }
                                                                            else
                                                                            {
                                                                                Response.Write("#ffcfcf");
                                                                            } %>;">
                            <div style="padding: 20px;">
                                <br>
                                <%
                                    string currentResponse;
                                    if (isInRoom)
                                    {
                                        currentResponse = "<h1 style=\"text-align: center;\">You are registered for round [Week Number]</h1><br />";
                                    }
                                    else
                                    {
                                        currentResponse = "<h1 style=\"text-align: center;\">You are not registered for round [Week Number]</h1><br />";
                                    }

                                    if (isMatchmade)
                                    {
                                        currentResponse = "<h1 style=\"text-align: center;\">The room listing for round [Week Number] is up! </h1><br />";
                                    }

                                    Response.Write(currentResponse); %>

                                <table class="shadow-z-1" style="width: 100%; padding: 20px; font-size: 16px;">
                                    <tbody>
                                        <tr>
                                            <td style="text-align: center; width: 50%; padding: 10px; font-size: 22px;">
                                                <strong>Players registered: <% Response.Write(users.ToString()); %></strong>
                                            </td>
                                            <td style="text-align: center; width: 50%; padding: 10px; font-size: 22px;">
                                                <strong>Hosts ready: <% Response.Write(hosts.ToString()); %></strong>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table style="width: 100%;" id="roomDisplay" runat="server">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <table style="width: 100%; height: 200px; padding: 10px"
                                                    class="shadow-z-2" border="0">
                                                    <tbody>
                                                        <tr style="padding: 10px; color: red;">
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h3 style="text-align: right" runat="server" id="p1MiiName"></h3>
                                                            </td>
                                                            <td style="text-align: center; width: 10%; padding: 10px;">
                                                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                                                    title="Mii Icon" src="data:image/gif;base64,R0lGODlhAQABAAAAACwAAAAAAQABAAA=" runat="server" id="p1MiiIcon">
                                                            </td>
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h4 style="text-align: left;" runat="server" id="p1nnid"></h4>
                                                            </td>
                                                        </tr>
                                                        <tr style="padding: 10px;">
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h3 style="text-align: right" runat="server" id="p2MiiName"></h3>
                                                            </td>
                                                            <td style="text-align: center; width: 10%; padding: 10px;">
                                                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                                                    title="Mii Icon" src="data:image/gif;base64,R0lGODlhAQABAAAAACwAAAAAAQABAAA=" runat="server" id="p2MiiIcon">
                                                            </td>
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h4 style="text-align: left;" runat="server" id="p2nnid"></h4>
                                                            </td>
                                                        </tr>
                                                        <tr style="padding: 10px;">
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h3 style="text-align: right" runat="server" id="p3MiiName"></h3>
                                                            </td>
                                                            <td style="text-align: center; width: 10%; padding: 10px;">
                                                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                                                    title="Mii Icon" alt="" src="data:image/gif;base64,R0lGODlhAQABAAAAACwAAAAAAQABAAA=" runat="server" id="p3MiiIcon">
                                                            </td>
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h4 style="text-align: left;" runat="server" id="p3nnid"></h4>
                                                            </td>
                                                        </tr>
                                                        <tr style="padding: 10px;">
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h3 style="text-align: right" runat="server" id="p4MiiName"></h3>
                                                            </td>
                                                            <td style="text-align: center; width: 10%; padding: 10px;">
                                                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                                                    title="Mii Icon" alt="" src="data:image/gif;base64,R0lGODlhAQABAAAAACwAAAAAAQABAAA=" runat="server" id="p4MiiIcon">
                                                            </td>
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h4 style="text-align: left;" runat="server" id="p4nnid"></h4>
                                                            </td>
                                                        </tr>
                                                        <tr style="padding: 10px;">
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h3 style="text-align: right" runat="server" id="p5MiiName"></h3>
                                                            </td>
                                                            <td style="text-align: center; width: 10%; padding: 10px;">
                                                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                                                    title="Mii Icon" alt="" src="data:image/gif;base64,R0lGODlhAQABAAAAACwAAAAAAQABAAA=" runat="server" id="p5MiiIcon">
                                                            </td>
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h4 style="text-align: left;" runat="server" id="p5nnid"></h4>
                                                            </td>
                                                        </tr>
                                                        <tr style="padding: 10px;">
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h3 style="text-align: right" runat="server" id="p6MiiName"></h3>
                                                            </td>
                                                            <td style="text-align: center; width: 10%; padding: 10px;">
                                                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                                                    title="Mii Icon" alt="" src="data:image/gif;base64,R0lGODlhAQABAAAAACwAAAAAAQABAAA=" runat="server" id="p6MiiIcon">
                                                            </td>
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h4 style="text-align: left;" runat="server" id="p6nnid"></h4>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>
                                                <table style="width: 100%; height: 200px; padding: 10px"
                                                    class="shadow-z-2" border="0">
                                                    <tbody>
                                                        <tr style="padding: 10px;">
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h3 style="text-align: right" runat="server" id="p7MiiName"></h3>
                                                            </td>
                                                            <td style="text-align: center; width: 10%; padding: 10px;">
                                                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                                                    title="Mii Icon" alt="" src="data:image/gif;base64,R0lGODlhAQABAAAAACwAAAAAAQABAAA=" runat="server" id="p7MiiIcon">
                                                            </td>
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h4 style="text-align: left;" runat="server" id="p7nnid"></h4>
                                                            </td>
                                                        </tr>
                                                        <tr style="padding: 10px;">
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h3 style="text-align: right" runat="server" id="p8MiiName"></h3>
                                                            </td>
                                                            <td style="text-align: center; width: 10%; padding: 10px;">
                                                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                                                    title="Mii Icon" alt="" src="data:image/gif;base64,R0lGODlhAQABAAAAACwAAAAAAQABAAA=" runat="server" id="p8MiiIcon">
                                                            </td>
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h4 style="text-align: left;" runat="server" id="p8nnid"></h4>
                                                            </td>
                                                        </tr>
                                                        <tr style="padding: 10px;">
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h3 style="text-align: right" runat="server" id="p9MiiName"></h3>
                                                            </td>
                                                            <td style="text-align: center; width: 10%; padding: 10px;">
                                                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                                                    title="Mii Icon" alt="" src="data:image/gif;base64,R0lGODlhAQABAAAAACwAAAAAAQABAAA=" runat="server" id="p9MiiIcon">
                                                            </td>
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h4 style="text-align: left;" runat="server" id="p9nnid"></h4>
                                                            </td>
                                                        </tr>
                                                        <tr style="padding: 10px;">
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h3 style="text-align: right" runat="server" id="p10MiiName"></h3>
                                                            </td>
                                                            <td style="text-align: center; width: 10%; padding: 10px;">
                                                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                                                    title="Mii Icon" alt="" src="data:image/gif;base64,R0lGODlhAQABAAAAACwAAAAAAQABAAA=" runat="server" id="p10MiiIcon">
                                                            </td>
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h4 style="text-align: left;" runat="server" id="p10nnid"></h4>
                                                            </td>
                                                        </tr>
                                                        <tr style="padding: 10px;">
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h3 style="text-align: right" runat="server" id="p11MiiName"></h3>
                                                            </td>
                                                            <td style="text-align: center; width: 10%; padding: 10px;">
                                                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                                                    title="Mii Icon" alt="" src="data:image/gif;base64,R0lGODlhAQABAAAAACwAAAAAAQABAAA=" runat="server" id="p11MiiIcon">
                                                            </td>
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h4 style="text-align: left;" runat="server" id="p11nnid"></h4>
                                                            </td>
                                                        </tr>
                                                        <tr style="padding: 10px;">
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h3 style="text-align: right" runat="server" id="p12MiiName"></h3>
                                                            </td>
                                                            <td style="text-align: center; width: 10%; padding: 10px;">
                                                                <img style="width: 65px; height: 61px; margin-top: -12px;"
                                                                    title="Mii Icon" alt="" src="data:image/gif;base64,R0lGODlhAQABAAAAACwAAAAAAQABAAA=" runat="server" id="p12MiiIcon">
                                                            </td>
                                                            <td style="width: 45%; padding: 10px;">
                                                                <h4 style="text-align: left;" runat="server" id="p12nnid"></h4>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>

                                <br />


    <form runat="server">
                                <div class="shadow-z-1" style="padding: 15px">
                                    <br>
                                    <div style="text-align: center;">
                                        <h3 style="color: red; font-weight: bold">
                                            <% Response.Write(GetCountdownText()); %>
                                        </h3>
                                    </div>
                                    <br />
                                    <div style="text-align: center;" class="togglebutton-material-green togglebutton">
                                        <label>
                                            <asp:CheckBox
                                                ID="register" runat="server"></asp:CheckBox>
                                            <span style="font-weight: bold;">I
                        am participating in the next round.<br>
                                            </span>
                                        </label>
                                        <br />
                                        <div style="text-align: center;" class="togglebutton-material-deep-orange togglebutton">
                                            <label>
                                                <asp:CheckBox ID="host" runat="server"></asp:CheckBox>
                                                <span style="font-weight: bold;">I
                          am willing to host a room.</span>
                                            </label>
                                        </div>
                                        <br />
                                        <asp:Button ID="registerButton" class="btn btn-primary" Text="Update Registration" Style="width: 40%; left: 0px;" OnClick="registerButton_Click" runat="server"></asp:Button>
                                        <br>
                                    </div>
                                </div>
        </form>
                            </div>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>

        <div id="options" class="shadow-z-3 modal fade" style="display: inline-block; position: fixed; top: 0px; bottom: 0px; left: 0px; right: 0px; width: 800px; height: 400px; margin: auto; background: white;">
            <div class="modal-content" style="width: 100%; height: 100%;">
                <iframe src="options.aspx" scrolling="no" frameBorder="0" style="width: 100%; height: 100%">Your browser is too bad.</iframe>
            </div>
        </div>

    <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
    <div style="text-align: center;"></div>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <script src="js/ripples.min.js"></script>
    <script src="js/material.min.js"></script>
    <script>
        $(document).ready(function () {
            // This command is used to initialize some elements and make them work properly
            $.material.init();
        });
    </script>
    <script>
        var end = new Date('04/01/2015 20:10');

        var _second = 1000;
        var _minute = _second * 60;
        var _hour = _minute * 60;
        var _day = _hour * 24;
        var timer;

        function showRemaining() {
            var now = new Date();
            var distance = end - now;
            if (distance < 0) {

                clearInterval(timer);
                document.getElementById('countdown').innerHTML = 'EXPIRED!';

                return;
            }
            var days = Math.floor(distance / _day);
            var hours = Math.floor((distance % _day) / _hour);
            var minutes = Math.floor((distance % _hour) / _minute);
            var seconds = Math.floor((distance % _minute / _second));

            document.getElementById('countdown').innerHTML = days + ':';
            document.getElementById('countdown').innerHTML += hours + ':';
            document.getElementById('countdown').innerHTML += minutes + ':';
            document.getElementById('countdown').innerHTML += seconds;
        }

        timer = setInterval(showRemaining, 1000);


    </script>
</body>
</html>
