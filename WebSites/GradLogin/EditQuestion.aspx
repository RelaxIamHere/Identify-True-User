<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="EditQuestion.aspx.cs" Inherits="_EditQuestion" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <asp:SqlDataSource ID="MapDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT [Category] FROM [MAP] WHERE [Question]=@Question"
        UpdateCommand="UPDATE [MAP] SET [QuestionName]=@QuestionName WHERE [Question]=@Question"></asp:SqlDataSource>

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
                <div class="row">
                
<div class="col-lg-12">
<div class="col-lg-8">
<center><label id="labelResult" runat=server visible=false></label></center>
<div style="width:95%; border-left-color: #5bc0de; padding: 10px; margin: 0 auto; border: 1px solid #eee; border-left-width: 5px; border-radius: 3px;">
<h3><strong><input id="qName" runat="server" class="form-control" type="text" placeholder="Question Name" /></strong></h3>
<p><textarea id="qText1" runat="server" class="form-control" type="text" rows="4" placeholder="Question Text" /></p>
<h4>Input</h4>
<p><textarea id="qText2" runat="server" class="form-control" type="text" rows="4" placeholder="Input Description Text" /></p>
<h4>Output</h4>
<p><textarea id="qText3" runat="server" class="form-control" type="text" rows="4" placeholder="Output Description Text" /></p>
<h4>Example</h4>
<pre>
<strong>Input:</strong>
<p><textarea id="qText4" runat="server" class="form-control" type="text" rows="4" placeholder="Example Input" /></p>
<strong>Output:</strong>
<p><textarea id="qText5" runat="server" class="form-control" type="text" rows="4" placeholder="Example Output" /></p>
</pre>
<br />
<button runat="server" id="buttonUpdate" onclick="javascript:__doPostBack('buttonUpdate','')" class="btn btn-primary btn-sm pull-right">
Update Question
</button>
</div>
<br /><br />
</div>     
                                <div class="col-lg-4">
                                    <div class="chat-panel panel panel-default">
                                        <div class="panel-heading">
                                            <i class="fa fa-pencil fa-fw"></i>Edit TestCases
                                        </div>
                                        <!-- /.panel-heading -->
                                        <div class="panel-footer" style="overflow: hidden;">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-gears fa-fw" aria-hidden="true"></i>
                                                </span>
                                                <input runat="server" id="textQcategory" class="form-control" type="text" placeholder="Type New Category" disabled>
                                            </div>
                                            <br />
                                            <label runat="server" id="labelMessage"></label>
                                            <button runat="server" id="buttonCreate" onclick="javascript:__doPostBack('buttonCreate','')" class="btn btn-primary btn-sm pull-right">
                                                    Create New Testcase
                                                </button>
                                        </div>
                                        <!-- /.panel-footer -->
                                    </div>
                                    <!-- /.panel .chat-panel -->
                                </div>
                                <!-- /.col-lg-4 -->
            </div><br /><br />
            </div>
            </div>
            <!-- /#page-wrapper -->           
        </div>
    </body>
</asp:Content>
