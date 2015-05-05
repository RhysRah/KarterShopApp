<%@ Page Language="C#" %>

<%@ Assembly Name="MySql.Data" %>
<%@ Assembly Name="HtmlAgilityPack" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="HtmlAgilityPack" %>


<script runat="server">

</script>

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
                <td style="width: 50%; padding: 5px;">
                    <br>
                    <div class="shadow-z-1" style="background-color: white; height: 80%; vertical-align: central">
                        <div style="padding: 20px; height: 100%">
                            <h1 style="text-align: center;">Welcome to the Karter Shop!</h1>
                            Here is the one stop shop for all the kart parts. The coins you have been collecting are now coming to use, as you will now use them to purchase the parts you want so you can use them for the final week. Depending on the strength of each part, they will be cheap, or expensive, so spend wisely!<br />

                                <form runat="server">
                                <table style="width: 100%; height: 60%">
                                    <tbody>
                                        <tr>
                                            <td style="width:40%; margin: 5px" >
                                                <asp:DropDownList CssClass="form-control" ID="CharacterPicker" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 20%; margin: 10px; text-align: center">
                                                Price: 
                                            </td>
                                            <td rowspan="4" style="vertical-align: central; text-align: center">
                                                <h2>Total:</h2>
                                            </td>
                                            </tr>
                                        <tr>
                                            <td style="width: 40%; margin: 5px">
                                                <asp:DropDownList CssClass="form-control" ID="BodyPicker" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 20%; margin: 10px; text-align: center">
                                                Price: 
                                            </td>
                                            
                                            </tr>
                                        <tr>
                                            <td style="width:40%; margin: 5px">
                                                <asp:DropDownList CssClass="form-control" ID="TiresPicker" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 20%; margin: 10px; text-align: center">
                                                Price: 
                                            </td>
                                            
                                            </tr>
                                        <tr>
                                            <td style="width:40%; margin: 5px">
                                                <asp:DropDownList CssClass="form-control" ID="GliderPicker" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 20%; margin: 10px; text-align: center">
                                                Price: 
                                            </td>
                                        </tr
                                        >
                                    </tbody>
                                </table>
                                </form>

                                <br />
                        </div>
                    </div>
                </td>
                <td style="padding: 10px;">
                    <div class="shadow-z-1" style="background-color: white; height: 80%; vertical-align: central">
                        <table class="table table-striped h5" style="width: 50%;">
                            <tbody>
                                <tr>
                                    <td>Speed (Ground)</td>
                                    <td id="speedGround">###</td>
                                </tr>
                                <tr>
                                    <td>Speed (Water)</td>
                                    <td id="speedWater">###</td>
                                </tr>
                                <tr>
                                    <td>Speed (Air)</td>
                                    <td id="speedAir">###</td>
                                </tr>
                                <tr>
                                    <td>Speed (Anti-Grav)</td>
                                    <td id="speedAntigrav">###</td>
                                </tr>
                                <tr>
                                    <td>Acceleration</td>
                                    <td id="accel">###</td>
                                </tr>
                                <tr>
                                    <td>Weight</td>
                                    <td id="weight">###</td>
                                </tr>
                                <tr>
                                    <td>Handling (Ground)</td>
                                    <td id="handlingGround">###</td>
                                </tr>
                                <tr>
                                    <td>Handling (Water)</td>
                                    <td id="handlingWater">###</td>
                                </tr>
                                <tr>
                                    <td>Handling (Air)</td>
                                    <td id="handlingAir">###</td>
                                </tr>
                                <tr>
                                    <td>Handling (Anti-Grav)</td>
                                    <td id="handlingAntigrav">###</td>
                                </tr>
                                <tr>
                                    <td>Traction</td>
                                    <td id="traction">###</td>
                                </tr>
                                <tr>
                                    <td>Mini-Turbo</td>
                                    <td id="miniTurbo">###</td>
                                </tr>
                            </tbody>
                        </table>

                    </div>
                </td>
            </tr>
        </tbody>
    </table>

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

        function ShowHome() {
            homeTab.className = "active";
            bodiesTab.className = "";
            tiresTab.className = "";
            glidersTab.className = "";
        }
        function ShowBodies() {
            homeTab.className = "";
            bodiesTab.className = "active";
            tiresTab.className = "";
            glidersTab.className = "";
        }
        function ShowTires() {
            homeTab.className = "";
            bodiesTab.className = "";
            tiresTab.className = "active";
            glidersTab.className = "";
        }
        function ShowGliders() {
            homeTab.className = "";
            bodiesTab.className = "";
            tiresTab.className = "";
            glidersTab.className = "active";
        }
    </script>
</body>
</html>

