<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Leaderboard.aspx.cs" Inherits="_Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .style1
        {
            height: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

     <asp:SqlDataSource ID="MapDataSource" runat="server" 
     ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
     SelectCommand="SELECT Distinct [Category] FROM [MAP] ORDER BY [Category] ASC"></asp:SqlDataSource>

     <asp:SqlDataSource ID="LeaderDataSource" runat="server" 
     ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
     SelectCommand="SELECT ROW_NUMBER() OVER( ORDER BY SUM(Submission.Score) DESC) AS Rank, Submission.Username, SUM(Submission.Score) AS Score 
                    FROM Map INNER JOIN Submission ON Map.Question = Submission.Question
                    WHERE (Map.Category = @Category)
                    GROUP BY Map.Category, Submission.Username"></asp:SqlDataSource>

<body>
<div id="wrapper">
                <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">Leaderboard</h1>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                        <div class="panel-heading">
                            Ranking Table
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="dataTable_wrapper">
                                <div class="dataTables_wrapper form-inline dt-bootstrap no-footer" id="dataTables-example_wrapper">
                                <div class="row"><div class="col-sm-6"><div id="dataTables-example_length" class="dataTables_length">
                                <label> Category <select onchange="javascript:__doPostBack('dropdown','')" id="dropdown" runat="server" class="form-control input-sm" aria-controls="dataTables-example" name="dataTables-example_length">
                                </select> </label></div></div><div class="col-sm-6"><div class="dataTables_filter" id="dataTables-example_filter">
                                <label>Search User:<input id="search" runat="server" aria-controls="dataTables-example" placeholder="" class="form-control input-sm" type="text"/><asp:Button id="searchButton" runat="server"/></label></div></div></div><div class="row"><div class="col-sm-12">
                                        <table style="width: 100%;" aria-describedby="dataTables-example_info" role="grid" class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline" id="dataTables-example" width="100%">
                                        <thead>
                                            <tr role="row"><th aria-label="Rendering engine: activate to sort column descending" aria-sort="ascending" style="width: 231px;" colspan="1" rowspan="1" aria-controls="dataTables-example" tabindex="0" class="sorting_asc">Rank</th><th aria-label="Browser: activate to sort column ascending" style="width: 266px;" colspan="1" rowspan="1" aria-controls="dataTables-example" tabindex="0" class="sorting">User</th><th aria-label="Platform(s): activate to sort column ascending" style="width: 243px;" colspan="1" rowspan="1" aria-controls="dataTables-example" tabindex="0" class="sorting">Score</th></tr>
                                        </thead>
                                        <tbody>
                                        <asp:Repeater ID="Repeater1" runat="server">
                                                  <itemtemplate>
                                                  <tr role="row" class="gradeA odd">
                                                        <td class="sorting_1"><span><%#Eval("Rank") %></span></td>                                                                
                                                        <td><span><%# Eval("Username") %></span></td>
                                                        <td><span><%# Eval("Score") %></span></td>
                                                    </tr>
                                                  </itemtemplate>
                                                  <AlternatingItemTemplate>
                                                  <tr role="row" class="gradeA even">
                                                        <td class="sorting_1"><span><%#Eval("Rank") %></span></td>                                                                
                                                        <td><span><%# Eval("Username") %></span></td>
                                                        <td><span><%# Eval("Score") %></span></td>
                                                    </tr>
                                                  </AlternatingItemTemplate>
                                        </asp:Repeater>
                                        </tbody> 
                                </table></div></div>
                                
                                <div class="row"><div class="col-sm-6"><div id="dataTables-example_length" class="dataTables_length"><label>Show <select class="form-control input-sm" aria-controls="dataTables-example" name="dataTables-example_length"><option value="10">10</option><option value="25">25</option><option value="50">50</option><option value="100">100</option></select> entries</label></div></div></div>
                                <div class="row"><div class="col-sm-6"><div aria-live="polite" role="status" id="dataTables-example_info" class="dataTables_info">Showing 1 to 10 of 57 entries</div></div><div class="col-sm-6"><div id="dataTables-example_paginate" class="dataTables_paginate paging_simple_numbers"><ul class="pagination"><li id="dataTables-example_previous" tabindex="0" aria-controls="dataTables-example" class="paginate_button previous disabled"><a href="#">Previous</a></li><li tabindex="0" aria-controls="dataTables-example" class="paginate_button active"><a href="#">1</a></li><li tabindex="0" aria-controls="dataTables-example" class="paginate_button "><a href="#">2</a></li><li tabindex="0" aria-controls="dataTables-example" class="paginate_button "><a href="#">3</a></li><li tabindex="0" aria-controls="dataTables-example" class="paginate_button "><a href="#">4</a></li><li tabindex="0" aria-controls="dataTables-example" class="paginate_button "><a href="#">5</a></li><li tabindex="0" aria-controls="dataTables-example" class="paginate_button "><a href="#">6</a></li><li id="dataTables-example_next" tabindex="0" aria-controls="dataTables-example" class="paginate_button next"><a href="#">Next</a></li></ul></div></div></div></div>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->
        </div>
        </body>


</asp:Content>
