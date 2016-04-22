<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Category.aspx.cs" Inherits="_Category" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

<asp:SqlDataSource ID="MapDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT [Question], [QuestionName] FROM [MAP] WHERE [Category]=@Category ORDER BY [Category] ASC"></asp:SqlDataSource>

<asp:SqlDataSource ID="SubmissionSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT [Score] FROM [Submission] WHERE [Question]=@Question AND [Username]=@Username"></asp:SqlDataSource>

<body>
<div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Category: <span><%= Request.QueryString["c"]%></span></h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div id="populate" class="row" runat="server">
            </div>
        </div>
        <!-- /#page-wrapper -->
        </div>
        </body>


</asp:Content>
