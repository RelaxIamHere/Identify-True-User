<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="ChangePassword.aspx.cs" Inherits="_ChangePassword" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<asp:SqlDataSource ID="ContactDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
         SelectCommand="SELECT Name, Surname, Birthday, Phone, Mail, Website, Country, City, Address, Company, School
                       FROM Contact WHERE (Username = @Username)"
        InsertCommand="INSERT INTO [Contact] ([Username],[Name],[Surname],[Birthday],[Phone],[Mail],[Website],[Country],[City],[Address],[Company],[School]) VALUES (@Username, @Name, @Surname, @Birthday, @Phone, @Mail, @Website, @Country, @City, @Address, @Company, @School)"
        UpdateCommand="UPDATE [Contact] SET [Name]=@Name, [Surname]=@Surname, [Birthday]=@Birthday, [Phone]=@Phone, [Mail]=@Mail, [Website]=@Website, [Country]=@Country, [City]=@City, [Address]=@Address, [Company]=@Company, [School]=@School WHERE [Username]=@Username"></asp:SqlDataSource>
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
                    <div class="col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <label>Contact Information</label>
                            </div>
                            <!-- /.panel-heading -->
                            <div class="panel-body">
                                        <div class="accountInfo">
                                            <fieldset class="changePassword">
                                                <legend>Account Information</legend>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-user" aria-hidden="true"></i>
                                                    </span>
                                                    <input runat="server" id="name" class="form-control" type="text" placeholder="Name">
                                                </div><br />
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-user" aria-hidden="true"></i>
                                                    </span>
                                                    <input runat="server" id="surname" class="form-control" type="text" placeholder="Surname">
                                                </div><br />
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="fa fa-calendar" aria-hidden="true"></i>
                                                    </span>
                                                    <asp:TextBox runat="server" id="birthday" class="form-control" type="date" value="2000-01-01" placeholder="Birthday"></asp:TextBox>
                                                </div><br />
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-earphone" aria-hidden="true"></i>
                                                    </span>
                                                    <input runat="server" id="phone" class="form-control" type="text" placeholder="Phone">
                                                </div><br />
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-envelope" aria-hidden="true"></i>
                                                    </span>
                                                    <input runat="server" id="mail" class="form-control" type="text" placeholder="E-mail">
                                                </div><br />
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-globe" aria-hidden="true"></i>
                                                    </span>
                                                    <input runat="server" id="website" class="form-control" type="text" placeholder="Website">
                                                </div><br />
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-map-marker" aria-hidden="true"></i>
                                                    </span>
                                                    <input runat="server" id="country" class="form-control" type="text" placeholder="Country">
                                                </div><br />
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-map-marker" aria-hidden="true"></i>
                                                    </span>
                                                    <input runat="server" id="city" class="form-control" type="text" placeholder="City">
                                                </div><br />
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-map-marker" aria-hidden="true"></i>
                                                    </span>
                                                    <input runat="server" id="address" class="form-control" type="text" placeholder="Address">
                                                </div><br />
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="fa fa-building" aria-hidden="true"></i>
                                                    </span>
                                                    <input runat="server" id="company" class="form-control" type="text" placeholder="Company">
                                                </div><br />
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="fa fa-graduation-cap" aria-hidden="true"></i>
                                                    </span>
                                                    <input runat="server" id="school" class="form-control" type="text" placeholder="School">
                                                </div><br />
                                            </fieldset>
                                                <div class="form-group">
                                                <div style="width:49%; float:left;">
                                                 <asp:Button type="submit" class="btn btn-primary btn-block" ID="ContactButton" OnClick="ContactButton_Click"
                                                        runat="server" Text="Update"/>     
                                                        </div>
                                                <div style="width:49%; float:right;">
                                                <asp:Button type="reset" class="btn btn-default btn-block" 
                                                        runat="server" CausesValidation="False" Text="Cancel"/>
                                                         </div>
                   
                                                </div>  
                                        </div>
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