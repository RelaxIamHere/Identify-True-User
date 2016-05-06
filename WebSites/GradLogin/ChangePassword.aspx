﻿<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="ChangePassword.aspx.cs" Inherits="_ChangePassword" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<body>
        <div id="wrapper">
            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">User Profile</h1>
                        <p>
                            Use the form below to change your password.
                        </p>
                        <p>
                            New passwords are required to be a minimum of <%= Membership.MinRequiredPasswordLength %> characters in length.
                        </p>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-5">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <label>Change Password</label>
                            </div>
                            <!-- /.panel-heading -->
                            <div class="panel-body">
                                   <asp:ChangePassword ID="ChangeUserPassword" runat="server" CancelDestinationPageUrl="~/" EnableViewState="false" RenderOuterTable="false" 
                                     SuccessPageUrl="ChangePasswordSuccess.aspx">
                                    <ChangePasswordTemplate>
                                        <span class="failureNotification">
                                            <asp:Literal ID="FailureText" runat="server"></asp:Literal>
                                        </span>
                                        <asp:ValidationSummary ID="ChangeUserPasswordValidationSummary" runat="server" CssClass="failureNotification" 
                                             ValidationGroup="ChangeUserPasswordValidationGroup"/>
                                        <div class="accountInfo">
                                            <fieldset class="changePassword">
                                                <legend>Account Information</legend>
                                                <p>
                                                    <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Old Password:</asp:Label>
                                                     <asp:TextBox class="form-control" ID="CurrentPassword" runat="server"  
                                                        TextMode="Password"></asp:TextBox>           
                                                    <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword" 
                                                         CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Old Password is required." 
                                                         ValidationGroup="ChangeUserPasswordValidationGroup" Display="Dynamic" >*</asp:RequiredFieldValidator>
                                                </p>
                                                <p>
                                                    <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">New Password:</asp:Label>
                                                    <asp:TextBox ID="NewPassword" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" 
                                                         CssClass="failureNotification" ErrorMessage="New Password is required." ToolTip="New Password is required." 
                                                         ValidationGroup="ChangeUserPasswordValidationGroup" Display="Dynamic">*</asp:RequiredFieldValidator>
                                                </p>
                                                <p>
                                                    <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Confirm New Password:</asp:Label>
                                                    <asp:TextBox ID="ConfirmNewPassword" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword" 
                                                         CssClass="failureNotification" Display="Dynamic" ErrorMessage="Confirm New Password is required."
                                                         ToolTip="Confirm New Password is required." ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator>
                                                    <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" 
                                                         CssClass="failureNotification" Display="Dynamic" ErrorMessage="The Confirm New Password must match the New Password entry."
                                                         ValidationGroup="ChangeUserPasswordValidationGroup" >*</asp:CompareValidator>
                                                </p>
                                            </fieldset>
                                                <div class="form-group">
                                                <div style="width:49%; float:left;">
                                                 <asp:Button type="submit" class="btn btn-primary btn-block" ID="ChangePasswordPushButton" 
                                                        runat="server" CommandName="ChangePassword" Text="Change Password" 
                                                     ValidationGroup="ChangeUserPasswordValidationGroup"/>     
                                                        </div>
                                                <div style="width:49%; float:right;">
                                                <asp:Button type="reset" class="btn btn-default btn-block" ID="CancelPushButton" 
                                                        runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"/>
                                                         </div>
                   
                                                </div>  
                                        </div>
                                    </ChangePasswordTemplate>
                                </asp:ChangePassword>
                            </div>
                            <!-- /.panel-body -->
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div>
            <!-- /#page-wrapper -->
        </div>
    </body> 

</asp:Content>