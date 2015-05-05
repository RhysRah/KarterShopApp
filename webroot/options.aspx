<%@ Page Language="C#" Debug="true" %>

<%@ Assembly Name="MySql.Data" %>
<%@ Assembly Name="HtmlAgilityPack" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="HtmlAgilityPack" %>

<!DOCTYPE html>

<script runat="server">

    private void ChangePassword()
    {
        string conStr = "server=192.168.0.23;uid=kartershop;pwd=ShQP7U2TrEVLzUFA;database=kartershop;port=3306;Charset=utf8";
        MySqlConnection conn = new MySqlConnection(conStr);

        conn.Open();

        string changePass = "UPDATE Users SET Password = @NewPass WHERE ID = @ID AND Password = @OldPass";
        MySqlCommand cmd = new MySqlCommand(changePass, conn);

        cmd.Parameters.AddWithValue("NewPass", newPass.Text);
        cmd.Parameters.AddWithValue("OldPass", oldPass.Text);

        cmd.Parameters.AddWithValue("ID", Session["UserID"]);
        
        int rows = cmd.ExecuteNonQuery();

        if (rows == 1)
        {
            
            //alert ok
            alert.Attributes["class"] = "alert alert-dismissable alert-success";
            alert.InnerHtml = "Your password was successfully changed.";
            alert.Visible = true;
            return;
        }

            alert.Visible = true;
            alert.Attributes["class"] = "alert alert-dismissable alert-danger";
            alert.InnerHtml = "Your password was not changed.";
        
        //alert not ok

            conn.Close();
    }

    protected void SendReport(string explained, string nnid, string reason = "contact")
    {
        string conStr = "server=192.168.0.23;uid=kartershop;pwd=ShQP7U2TrEVLzUFA;database=kartershop;port=3306;Charset=utf8";
        MySqlConnection conn = new MySqlConnection(conStr);

        conn.Open();

        string changePass = "INSERT INTO Reports (ReportType, ReportText, SenderID, UserNNID) VALUES (@ReportType, @ReportText, @ID, @NNID)";
        MySqlCommand cmd = new MySqlCommand(changePass, conn);

        cmd.Parameters.AddWithValue("ReportType", reason);
        cmd.Parameters.AddWithValue("ReportText", explained);
        cmd.Parameters.AddWithValue("ID", Session["UserID"]);
        cmd.Parameters.AddWithValue("NNID", nnid);

        cmd.ExecuteNonQuery();

        conn.Close();
        
        Page.ClientScript.RegisterStartupScript(
            GetType(),
            "Message",
            "alert(\"Your message was successfully submitted to the admins. You may be contacted over Miiverse.\")",
            true);
        
    }
    
    protected void confirmReport_Click(object sender, EventArgs e)
    {
        SendReport(reportBody.InnerText, ReportNNID.Text, reportOption.SelectedValue);
    }
    protected void confirmMessage_Click(object sender, EventArgs e)
    {
        ChangePassword();
    }

    protected void confirmContact_Click(object sender, EventArgs e)
    {
        SendReport(MessageBody.InnerText, Session["NNID"].ToString());
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta content="text/html; charset=windows-1252" http-equiv="content-type">
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"
        rel="stylesheet">
    <title>KarterShop - Login</title>
    <link href="dist/css/roboto.min.css" rel="stylesheet">
    <link href="dist/css/material.min.css" rel="stylesheet">
    <link href="dist/css/ripples.min.css" rel="stylesheet">
</head>
<body style="background-color: white">
    <form runat="server">
                <div class="navbar navbar-default">
                    <div class="navbar-header">
                        <span class="navbar-brand">Options</span>
                    </div>
                    <div class="navbar-collapse collapse navbar-responsive-collapse">
                        <ul class="nav navbar-nav">
                            <li class="active" id="userProfileTab"><a href="javascript:ShowUserProfile()">User Profile</a></li>
                            <li id="reportingTab"><a href="javascript:ShowReporting()">Reporting</a></li>
                            <li id="contactTab"><a href="javascript:ShowContact()">Contact Admins</a></li>
                        </ul>
                    </div>
                </div>
                <div style="margin: 10px">
                    <div id="optionsUserProfile" style="">
                        <asp:Panel ID="ChangePass" class="form-horizontal" runat="server">
                            <fieldset style="text-align:center">
                                <legend>Change Password</legend>
                                        <asp:TextBox type="password" class="form-control floating-label" ID="oldPass" placeholder="Old password" runat="server"></asp:TextBox>
                                <br />
                                        <asp:TextBox type="password" class="form-control floating-label" ID="newPass" onkeyup="CheckPass(); return false;" placeholder="New password" runat="server"></asp:TextBox>
                                <br />
                                        <asp:TextBox type="password" class="form-control floating-label" ID="retypeNew" onkeyup="CheckPass(); return false;" placeholder="Confirm password" runat="server"></asp:TextBox>

                                <asp:Button ID="confirmMessage" class="btn" style="left:0px;" OnClick="confirmMessage_Click" runat="server"/>
                            </fieldset>
                            <div id="alert" class="alert alert-dismissable alert-danger" runat="server" visible="false"></div>
                            </asp:Panel>
                    </div>
                    
                    <div id="optionsReporting" style="display: none">
                    If you want to submit a screenshot (for cheating accusations, for instance) please upload it to a picture sharing website like <a href="http://imgur.com">imgur</a> and include a link in your report details.
                        <br />
                        <br />
                        <asp:TextBox ID="ReportNNID" CssClass="form-control floating-label" onkeyup="CheckReport(); return 0;" placeholder="Reported Player NNID" runat="server"></asp:TextBox>
                        <asp:DropDownList ID="reportOption" CssClass="form-control" onclick="CheckReport(); return 0;" runat="server">
                            <asp:ListItem Value="error">Report reason...</asp:ListItem>
                            <asp:ListItem Value="cheating">Player Cheating</asp:ListItem>
                            <asp:ListItem Value="noshow-host">Host not showing</asp:ListItem>
                            <asp:ListItem Value="noshow-player">Player not showing</asp:ListItem>
                            <asp:ListItem Value="badattitude">Player bad attitude</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <textarea id="reportBody" class="form-control floating-label" placeholder="Explain your report in detail." onkeyup="CheckReport(); return 0;" rows="5" runat="server"></textarea>
                        <br />
                        <div style="width:100%; text-align: center">
                        <asp:Button ID="confirmReport" class="btn" style="left:0px; margin-left:auto; margin-right:auto" onkeyup="CheckReport(); return 0;" OnClick="confirmReport_Click" runat="server"/>
</div>
                    </div>

                    <div id="optionsContact" style="display: none">
                    If you want to submit a screenshot, please upload it to a picture sharing website like <a href="http://imgur.com">imgur</a> and include a link in your message.
                        <br />
                        <br />
                        <textarea id="MessageBody" class="form-control floating-label" placeholder="Write your message here." rows="8" runat="server"></textarea>
                        <br />
                        <div style="width:100%; text-align: center">
                        <asp:Button ID="confirmContact" class="btn btn-success" style="left:0px; margin-left:auto; margin-right:auto" text="Send Admin Message" OnClick="confirmContact_Click" runat="server"/>
</div>
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
            CheckPass();
            CheckReport();
        });

        function ShowReporting() {
            reportingTab.className = "active";
            contactTab.className = "";
            userProfileTab.className = "";

            optionsUserProfile.style.display = "none"
            optionsContact.style.display = "none"
            optionsReporting.style.display = "block"
        }
        function ShowUserProfile() {
            userProfileTab.className = "active";
            contactTab.className = "";
            reportingTab.className = "";

            optionsReporting.style.display = "none"
            optionsContact.style.display = "none"
            optionsUserProfile.style.display = "block"
        }
        function ShowContact() {
            contactTab.className = "active";
            reportingTab.className = "";
            userProfileTab.className = "";

            optionsUserProfile.style.display = "none"
            optionsReporting.style.display = "none"
            optionsContact.style.display = "block"
        }

        function CheckPass() {
            var pass1 = document.getElementById('newPass');
            var pass2 = document.getElementById('retypeNew');
            var button = document.getElementById('confirmMessage');


            button.disabled = false;
            button.className = "btn btn-success";
            button.value = "Change password";

            if (pass1.value != pass2.value) {
                button.disabled = true;
                button.className = "btn btn-warning";
                button.value = "Passwords do not match";
            }

            if (pass1.value.length < 5) {
                button.disabled = true;
                button.className = "btn btn-danger";
                button.value = "Your password is too short";
            }
        }

        function CheckReport() {
            var reason = document.getElementById('reportOption');
            var detail = document.getElementById('reportBody');
            var nnid = document.getElementById('ReportNNID');
            var button = document.getElementById('confirmReport');

            button.disabled = false;
            button.className = "btn btn-success";
            button.value = "Submit report";

            if (detail.value.length == 0) {
                button.disabled = true;
                button.className = "btn btn-danger";
                button.value = "Please explain your report.";
            }
            if (reason[reason.selectedIndex].value == "error") {
                button.disabled = true;
                button.className = "btn btn-danger";
                button.value = "Please select a report reason.";
            }
            if (nnid.value.length < 6) {
                button.disabled = true;
                button.className = "btn btn-danger";
                button.value = "Bad NNID";
            }

        }
    </script>
</form>
</body>
</html>
