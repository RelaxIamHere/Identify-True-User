<%@ Page Title="Log In" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Login.aspx.cs" Inherits="_Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>SB Admin 2 - Bootstrap Admin Theme</title>
        <!-- Bootstrap Core CSS -->
        <link href="bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- MetisMenu CSS -->
        <link href="bower_components/metisMenu/dist/metisMenu.min.css" rel="stylesheet">
        <!-- Social Buttons CSS -->
        <link href="bower_components/bootstrap-social/bootstrap-social.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="dist/css/sb-admin-2.css" rel="stylesheet">
        <!-- Custom Fonts -->
        <link href="bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet"
            type="text/css">
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-panel panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                <asp:Label ID="Label2" runat="server" Text="Please Sign In"></asp:Label></h3></h3>
                        </div>
                        <p>
                            Please enter your username and password.
                            <asp:HyperLink ID="HyperLink1" runat="server" EnableViewState="false">Register</asp:HyperLink>
                            if you don't have an account.
                        </p>
                        <div class="panel-body">
                            <form role="form">
                            <asp:Login ID="Login1" runat="server" EnableViewState="false" RenderOuterTable="false" DestinationPageUrl="Dashboard.aspx" >
                                <LayoutTemplate>
                                    <span class="failureNotification">
                                        <asp:Literal ID="FailureText" runat="server"></asp:Literal>
                                    </span>
                                    <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification"
                                        ValidationGroup="LoginUserValidationGroup" />
                                        <fieldset>
                                            <div class="form-group">
                                                <asp:TextBox class="form-control" placeholder="E-mail" ID="UserName" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                    CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="User Name is required."
                                                    ValidationGroup="LoginUserValidationGroup" Display="Dynamic">*</asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-group">
                                                <asp:TextBox class="form-control" placeholder="Password" ID="Password" runat="server"
                                                    TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                                    CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Password is required."
                                                    ValidationGroup="LoginUserValidationGroup" Display="Dynamic">*</asp:RequiredFieldValidator>
                                            </div>
                                            <div class="checkbox">
                                                <label>
                                                    <asp:CheckBox ID="RememberMe" runat="server" />
                                                    <asp:Label ID="RememberMeLabel" runat="server" AssociatedControlID="RememberMe">Remember Me</asp:Label>
                                                </label>
                                            </div>
                                            <!-- Change this to a button or input when using this as a form -->
                                            <asp:Button class="btn btn-lg btn-success btn-block" ID="LoginButton" runat="server"
                                                CommandName="Login" Text="Log In" ValidationGroup="LoginUserValidationGroup" />
                                        </fieldset>
                                </LayoutTemplate>
                            </asp:Login>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- jQuery -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>
        <!-- Bootstrap Core JavaScript -->
        <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
        <!-- Metis Menu Plugin JavaScript -->
        <script src="bower_components/metisMenu/dist/metisMenu.min.js"></script>
        <!-- Custom Theme JavaScript -->
        <script src="dist/js/sb-admin-2.js"></script>
    </body>
</asp:Content>
