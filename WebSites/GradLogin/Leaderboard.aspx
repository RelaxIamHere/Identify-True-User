<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Leaderboard.aspx.cs" Inherits="_Leaderboard" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

     <asp:SqlDataSource ID="MapDataSource" runat="server" 
     ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
     SelectCommand="SELECT Distinct [Category] FROM [MAP] ORDER BY [Category] ASC"></asp:SqlDataSource>

     <asp:SqlDataSource ID="LeaderDataSource" runat="server" 
     ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
     SelectCommand="SELECT* FROM ( SELECT ROW_NUMBER() OVER( ORDER BY SUM(Submission.Score) DESC) AS Rank, COUNT(Submission.Language) AS Language, Submission.Username AS Username, SUM(Submission.Score) AS Score 
                        FROM Map INNER JOIN Submission ON Map.Question = Submission.Question
                        WHERE (Map.Category = @Category)
                        GROUP BY Map.Category, Submission.Username) a
                    WHERE a.Username LIKE @Username"></asp:SqlDataSource>

     <asp:SqlDataSource ID="CategoryDataSource" runat="server" 
     ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
     SelectCommand="SELECT [Category], [QuestionName] FROM [MAP] WHERE [Question]=@Question"></asp:SqlDataSource>

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
                             <label><i class="fa fa-trophy fa-fw"></i> Ranking Table</label>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="dataTable_wrapper">
                                <div class="dataTables_wrapper form-inline dt-bootstrap no-footer" id="dataTables-example_wrapper">
                                <div class="row"><div class="col-sm-6"><div id="dataTables-example_length" class="dataTables_length">
                                <label id="labelCategory" runat="server"> Category <select onchange="javascript:__doPostBack('dropdownCategory','')" id="dropdownCategory" runat="server" class="form-control input-sm" aria-controls="dataTables-example" name="dataTables-example_length" style="-moz-appearance: none;">
                                </select> </label></div></div><div class="col-sm-6"><div class="dataTables_filter" id="dataTables-example_filter">
                               
                                 <div class="input-group">
                                    <span class="input-group-addon"><i runat="server" href="javascript:__doPostBack('searchButton','')" id="searchButton" class="fa fa-search fa-fw" aria-hidden="true"></i></span>
                                    <input id="search" runat="server" class="form-control" type="text" placeholder="Search for Username"/>
                                    <button style="display:none;"></button>   
                                </div>

                                  </div></div></div><br /><div class="row"><div class="col-sm-12">
                                        <table style="width: 100%;" aria-describedby="dataTables-example_info" role="grid" class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline" id="dataTables-example" width="100%">
                                        <thead>
                                            <tr role="row"><th style="width: 231px;" class="sorting_asc">Rank</th><th style="width: 266px;">User</th>
                                            <%if (!string.IsNullOrEmpty(Request.QueryString["p"])) {%>
                                            <th style="width: 243px;">Language</th>
                                            <%} %>
                                            <th style="width: 243px;">Score</th></tr>
                                        </thead>
                                        <tbody>
                                        <asp:ListView ID="ListView1" runat="server" GroupItemCount="1" >
                                                    <itemtemplate>
                                                    <tr role="row" class="gradeA odd">
                                                        <td class="sorting_1"><span><%#Eval("Rank") %></span></td>                                                                
                                                        <td><a href="Dashboard.aspx?u=<%#Eval("Username") %>"><span><%# Eval("Username") %></span></a></td>
                                                        <%if (!string.IsNullOrEmpty(Request.QueryString["p"])){%>
                                                            <td><span><%# Eval("Language") %></span></td>
                                                        <%} %>
                                                        <td><span><%# Eval("Score") %></span></td>
                                                    </tr>
                                                    </itemtemplate>
                                                    <AlternatingItemTemplate>
                                                    <tr role="row" class="gradeA even">
                                                        <td class="sorting_1"><span><%#Eval("Rank") %></span></td>                                                                
                                                        <td><a href="Dashboard.aspx?u=<%#Eval("Username") %>"><span><%# Eval("Username") %></span></a></td>
                                                        <%if (!string.IsNullOrEmpty(Request.QueryString["p"])){%>
                                                            <td><span><%# Eval("Language") %></span></td>
                                                        <%} %>
                                                        <td><span><%# Eval("Score") %></span></td>
                                                    </tr>
                                                    </AlternatingItemTemplate>
                                       </asp:ListView>
                                        </tbody> 
                                </table></div></div>

                                <div class="row"><div class="col-sm-6"><div id="dataTables-example_length" class="dataTables_length">
                                <label>Show <select onchange="javascript:__doPostBack('dropdownSize','')" id="dropdownSize" runat="server" class="form-control input-sm" aria-controls="dataTables-example" name="dataTables-example_length" style="-moz-appearance: none;"><option value="10">10</option><option value="25">25</option><option value="50">50</option><option value="100">100</option></select> entries</label></div></div></div>
                                
                                <div class="row"><div class="col-sm-6"><div aria-live="polite" role="status" id="dataTables-example_info" class="dataTables_info"><span id="recordCount" runat="server">Showing 1 to 10 of 57 entries</span></div></div>
                                <div class="col-sm-6">
                                    
                                   <asp:DataPager ID="DataPager1" runat="server" PagedControlID="ListView1"
                                    QueryStringField="Page">
                                    <Fields>
                                        <asp:NextPreviousPagerField PreviousPageText="<" FirstPageText="First" ShowPreviousPageButton="true"
                                            ShowFirstPageButton="true" ShowNextPageButton="false" 
                                            ButtonCssClass="btn btn-default" RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="false" />
                                        <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="btn btn-primary"  RenderNonBreakingSpacesBetweenControls="false"
                                            NumericButtonCssClass="btn btn-default" ButtonCount="10" NextPageText="..." NextPreviousButtonCssClass="btn btn-default" />
                                        <asp:NextPreviousPagerField NextPageText=">" LastPageText="Last" ShowNextPageButton="true"
                                            ShowLastPageButton="true" ShowPreviousPageButton="false" 
                                            ButtonCssClass="btn btn-default" RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="false"/>
                                    </Fields>
                                </asp:DataPager>
                                    
                               </div></div></div>
                            
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
        <!-- jQuery -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>
        </body>
</asp:Content>
