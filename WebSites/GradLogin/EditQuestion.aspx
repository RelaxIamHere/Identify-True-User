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
       <div class="panel panel-default">
        <div class="panel-heading">
            <label><i class="fa fa-pencil fa-fw"></i> Edit Question</label>
        </div>
        <!-- /.panel-heading -->

        <div class="panel-footer" style="height:auto; overflow:hidden;">
         <h3><strong><input id="qName" runat="server" class="form-control" type="text" placeholder="Question Name" /></strong></h3>
        <p><textarea id="qText1" runat="server" class="form-control" type="text" rows="4" placeholder="Question Text" style="resize:vertical;" /></p>
        <h4>Input</h4>
        <p><textarea id="qText2" runat="server" class="form-control" type="text" rows="4" placeholder="Input Description Text" style="resize:vertical;" /></p>
        <h4>Output</h4>
        <p><textarea id="qText3" runat="server" class="form-control" type="text" rows="4" placeholder="Output Description Text" style="resize:vertical;" /></p>
        <h4>Example</h4>
        <pre><strong>Input:</strong>
        <p><textarea id="qText4" runat="server" class="form-control" type="text" rows="4" placeholder="Example Input" style="resize:vertical;" /></p><strong>Output:</strong>
        <p><textarea id="qText5" runat="server" class="form-control" type="text" rows="4" placeholder="Example Output" style="resize:vertical;" /></p>
        </pre>
        <button runat="server" id="buttonUpdate" onclick="javascript:updateActive()" class="btn btn-primary btn-sm pull-right">
        Update Question
        </button>
        </div>
        </div>

</div>     
                                <div class="col-lg-4">

                                    <div class="chat-panel panel panel-default" id="divTestcase" runat="server" visible=false>
                                        <div class="panel-heading">
                                            <label><i class="fa fa-pencil fa-fw"></i> <label id="labelIdTestcase" runat="server"></label></label>
                                        </div>
                                        <!-- /.panel-heading -->
                                        <div class="panel-footer" style="overflow: hidden;">
                                            <div class="row">
                                            <div class="col-sm-12">
                                             <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-arrow-circle-right fa-fw" aria-hidden="true"></i>
                                                </span>
                                                <textarea id="editInput" runat="server" class="form-control" rows="3" type="text" placeholder="Input" style="resize:vertical;"></textarea>
                                            </div><br />
                                             <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-arrow-circle-left fa-fw" aria-hidden="true"></i>
                                                </span>
                                                <textarea id="editOutput" runat="server" class="form-control" rows="3" type="text" placeholder="Output" style="resize:vertical;"></textarea>
                                            </div><br />
                                             <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-clock-o fa-fw" aria-hidden="true"></i>
                                                </span>
                                                <input id="editTime" runat="server" class="form-control" type="text" placeholder="Time Limit (Seconds)">
                                            </div><br />
                                            <label runat="server" id="labelUpdate"></label>
                                            <button runat="server" id="buttonApiUpdate" onclick="javascript:__doPostBack('buttonApiUpdate','')" class="btn btn-primary btn-sm pull-right">
                                                Update Testcase
                                            </button>
                                            </div>
                                        </div>
                                        </div>
                                        <!-- /.panel-footer -->
                                    </div>

                                    <div class="chat-panel panel panel-default">
                                        <div class="panel-heading">
                                            <label><i class="fa fa-pencil fa-fw"></i> Edit TestCase</label>
                                        </div>
                                        <!-- /.panel-heading -->
                                        <div class="panel-body" style="overflow: hidden; height:auto">
                                            <div class="row">
                                            <div class="col-sm-12">
                                                <table aria-describedby="dataTables-example_info" role="grid"
                                                    class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline"
                                                    id="dataTables" width="100%">
                                                    <thead>
                                                        <tr role="row">
                                                            <th style="width: 100px;">
                                                                ID
                                                            </th>
                                                            <th style="width: 100px;">
                                                                Active
                                                            </th>
                                                            <th style="width: 100px;">
                                                                Time
                                                            </th>
                                                            <th style="width: 50px;">
                                                                Edit
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="table" runat="server">
                                                         
                                                    </tbody>
                                                </table>
                                                
                                            </div>
                                        </div>
                                        </div>
                                        <!-- /.panel-body -->
                                        <div class="panel-footer" style="overflow:hidden">
                                            <label runat="server" id="labelCreate"></label>
                                            <button runat="server" id="buttonCreate" onclick="javascript:__doPostBack('buttonCreate','')" class="btn btn-primary btn-sm pull-right">
                                                Create New Testcase
                                            </button>
                                        </div>
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
    <!-- jQuery -->
    <script src="bower_components/jquery/dist/jquery.min.js"></script>
    <script type="text/javascript">
        function updateActive() {
           var counter=0;
           var list= [];
           $("#dataTables > tbody > tr > td >center > input").each(function(){
                if ($(this).prop('checked') == true)
                 list.push(counter);
                 counter++;
             });
             document.cookie="activeTest="+list;
             __doPostBack('buttonUpdate', '');
        }
    </script>
</asp:Content>
