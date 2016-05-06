<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Register.aspx.cs" Inherits="_Register" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
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
                            <h4 class="page-title">Sign Up</h4>
                        </div>

                        <div class="panel-body">
                            <asp:CreateUserWizard ID="RegisterUser" runat="server" EnableViewState="false" OnCreatedUser="RegisterUser_CreatedUser">
                            <LayoutTemplate>
                                <asp:PlaceHolder ID="wizardStepPlaceholder" runat="server"></asp:PlaceHolder>
                                <asp:PlaceHolder ID="navigationPlaceholder" runat="server"></asp:PlaceHolder>
                            </LayoutTemplate>
                            <WizardSteps>
                                <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server">
                                    <ContentTemplate>
                                        <p>
                                            Use the form below to create a new account.
                                        </p>
                                        <p>
                                            Passwords are required to be a minimum of <%= Membership.MinRequiredPasswordLength %> characters in length.
                                        </p>
                                        <span class="failureNotification">
                                            <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
                                        </span>
                                        <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" CssClass="failureNotification" 
                                             ValidationGroup="RegisterUserValidationGroup"/>
                                        <div class="accountInfo">
                                            <fieldset>                                            
                                                <div class="form-group">
                                                    <asp:TextBox ID="UserName" runat="server" class="form-control" placeholder="Username"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                                                         CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="User Name is required." 
                                                         ValidationGroup="RegisterUserValidationGroup" Display="Dynamic">*</asp:RequiredFieldValidator>
                                                </div>
                                                <div class="form-group">
                                                    <asp:TextBox ID="Email" runat="server" class="form-control" placeholder="E-mail"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" 
                                                         CssClass="failureNotification" ErrorMessage="E-mail is required." ToolTip="E-mail is required." 
                                                         ValidationGroup="RegisterUserValidationGroup" Display="Dynamic">*</asp:RequiredFieldValidator>
                                                </div>
                                                <div class="form-group">
                                                    <asp:TextBox ID="Password" runat="server" class="form-control" placeholder="Password" TextMode="Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" 
                                                         CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Password is required." 
                                                         ValidationGroup="RegisterUserValidationGroup" Display="Dynamic">*</asp:RequiredFieldValidator>
                                                </div>
                                                <div class="form-group">
                                                    <asp:TextBox ID="ConfirmPassword" runat="server" class="form-control" placeholder="Confirm Password" TextMode="Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ControlToValidate="ConfirmPassword" CssClass="failureNotification" Display="Dynamic" 
                                                         ErrorMessage="Confirm Password is required." ID="ConfirmPasswordRequired" runat="server" 
                                                         ToolTip="Confirm Password is required." ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                                    <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" 
                                                         CssClass="failureNotification" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match."
                                                         ValidationGroup="RegisterUserValidationGroup">*</asp:CompareValidator>
                                                </div>
                                            </fieldset>
                                            <p class="submitButton">
                                                <asp:Button ID="CreateUserButton" runat="server" class="btn btn-lg btn-success btn-block" CommandName="MoveNext" Text="Create User" 
                                                     ValidationGroup="RegisterUserValidationGroup"/>
                                            </p>
                                        </div>
                                    </ContentTemplate>
                                    <CustomNavigationTemplate>
                                    </CustomNavigationTemplate>
                                </asp:CreateUserWizardStep>
                            </WizardSteps>
                        </asp:CreateUserWizard>

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