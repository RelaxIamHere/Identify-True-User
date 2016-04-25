<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="EditQuestion.aspx.cs" Inherits="_EditQuestion" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <asp:SqlDataSource ID="MapDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT [Category] FROM [MAP] WHERE [Question]=@Question"></asp:SqlDataSource>

    <body>
        <div id="wrapper">
            <div id="page-wrapper">
                <div class="row">
                    <div style="width:75%; float:left">
                        <h2 class="page-header" id="header" runat="server">
                            Contest</h2>
                    </div>
                

                </div>
                <!-- /.row -->

                  <div runat="server" id="problem" style="width: 80%; border-left-color: #5bc0de; padding: 20px; margin: 0 auto;
                        border: 1px solid #eee; border-left-width: 5px; border-radius: 3px;">
                        
                 </div>
                 <br /><br />
                 <div style="width: 80%; border-left-color: #5bc0de; padding: 20px; margin: 0 auto;
                        border: 1px solid #eee; border-left-width: 5px; border-radius: 3px;">
                        <h3><strong>Example Challange</strong></h3>
                        <h3><strong id="Strong1" runat="server"></strong></h3>
                        <p>SQL data implementasyon sorusu.</p><hr />
                        <p><br /><strong>Sample input:</strong><br />1 3<br /><br />
                        <strong>Sample output:</strong><br />4 5 6 7<br />1 3 6</p>
                 </div>

            </div>
            <!-- /#page-wrapper -->
        </div>
    </body>
</asp:Content>
