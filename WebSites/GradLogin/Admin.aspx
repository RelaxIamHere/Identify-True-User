<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Admin.aspx.cs" Inherits="_Admin" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:SqlDataSource ID="MapDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="SELECT Distinct [Category] FROM [MAP] ORDER BY [Category] ASC">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="QuestionDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="SELECT [Question], [QuestionName] FROM [MAP] WHERE [Category]=@Category AND [QuestionName] LIKE @QuestionName ORDER BY [ID] DESC"
        InsertCommand="INSERT INTO [MAP] ([Question],[QuestionName],[Category]) VALUES (@Question, @QuestionName, @Category)"
        DeleteCommand="DELETE FROM [MAP] WHERE [Question]=@Question"></asp:SqlDataSource>
    <body>
        <div id="wrapper">
            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Admin Panel</h1>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <label>Questions</label>
                            </div>
                            <!-- /.panel-heading -->
                            <div class="panel-body">
                                
                                <div class="col-lg-8">
                                <div class="dataTable_wrapper">
                                    <div class="dataTables_wrapper form-inline dt-bootstrap no-footer" id="dataTables-example_wrapper">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div id="dataTables-example_length" class="dataTables_length">
                                                    <label>
                                                        Category
                                                        <select onchange="javascript:__doPostBack('dropdownCategory','')" id="dropdownCategory"
                                                            runat="server" class="form-control input-sm" aria-controls="dataTables-example"
                                                            name="dataTables-example_length" style="-moz-appearance: none;">
                                                        </select>
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="dataTables_filter" id="dataTables-example_filter">
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><i runat="server" href="javascript:__doPostBack('searchButton','')"
                                                            id="searchButton" class="fa fa-search fa-fw" aria-hidden="true"></i></span>
                                                        <input id="search" runat="server" class="form-control" type="text" placeholder="Search for Question Name" />
                                                        <button style="display: none;">
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div><br />
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <table style="width: 100%;" aria-describedby="dataTables-example_info" role="grid"
                                                    class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline"
                                                    id="dataTables-example" width="100%">
                                                    <thead>
                                                        <tr role="row">
                                                            <th style="width: 231px;">
                                                                Question Code
                                                            </th>
                                                            <th style="width: 266px;">
                                                                Question Name
                                                            </th>
                                                            <th style="width: 50px;">
                                                                Edit
                                                            </th>
                                                            <th style="width: 50px;">
                                                                Delete
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:ListView ID="ListView1" runat="server" GroupItemCount="1">
                                                            <ItemTemplate>
                                                                <tr role="row" class="gradeA odd">
                                                                    <td class="sorting_1">
                                                                        <span>
                                                                            <%#Eval("Question") %></span>
                                                                    </td>
                                                                    <td>
                                                                        <span>
                                                                            <%# Eval("QuestionName") %></span>
                                                                    </td>
                                                                     <td>
                                                                        <span><a class="btn btn-primary btn-block btn-outline" href="EditQuestion.aspx?p=<%#Eval("Question") %>"><i class="fa fa-pencil-square-o">
                                                                        </i></a></span>
                                                                    </td>
                                                                    <td>
                                                                        <span><a class="btn btn-primary btn-block btn-outline" href="javascript:__doPostBack('delete','<%#Eval("Question")%>')"><i class="fa fa-remove">
                                                                        </i></a></span>
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <AlternatingItemTemplate>
                                                                <tr role="row" class="gradeA even">
                                                                    <td class="sorting_1">
                                                                        <span>
                                                                            <%#Eval("Question") %></span>
                                                                    </td>
                                                                    <td>
                                                                        <span>
                                                                            <%# Eval("QuestionName") %></span>
                                                                    </td>
                                                                     <td>
                                                                        <span><a class="btn btn-primary btn-block btn-outline" href="EditQuestion.aspx?p=<%#Eval("Question") %>"><i class="fa fa-pencil-square-o">
                                                                        </i></a></span>
                                                                    </td>
                                                                    <td>
                                                                        <span><a class="btn btn-primary btn-block btn-outline" href="javascript:__doPostBack('delete','<%#Eval("Question")%>')"><i class="fa fa-remove">
                                                                        </i></a></span>
                                                                    </td>
                                                                </tr>
                                                            </AlternatingItemTemplate>
                                                        </asp:ListView>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div id="dataTables-example_length" class="dataTables_length">
                                                    <label>
                                                        Show
                                                        <select onchange="javascript:__doPostBack('dropdownSize','')" id="dropdownSize" runat="server"
                                                            class="form-control input-sm" aria-controls="dataTables-example" name="dataTables-example_length" style="-moz-appearance: none;">
                                                            <option value="10">10</option>
                                                            <option value="25">25</option>
                                                            <option value="50">50</option>
                                                            <option value="100">100</option>
                                                        </select>
                                                        entries</label></div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div aria-live="polite" role="status" id="dataTables-example_info" class="dataTables_info">
                                                    <span id="recordCount" runat="server">Showing 1 to 10 of 57 entries</span></div>
                                            </div>
                                            <div class="col-sm-6">
                                                <asp:DataPager ID="DataPager1" runat="server" PagedControlID="ListView1" QueryStringField="Page">
                                                    <Fields>
                                                        <asp:NextPreviousPagerField PreviousPageText="<" FirstPageText="First" ShowPreviousPageButton="true"
                                                            ShowFirstPageButton="true" ShowNextPageButton="false" ButtonCssClass="btn btn-default"
                                                            RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="false" />
                                                        <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="btn btn-primary"
                                                            RenderNonBreakingSpacesBetweenControls="false" NumericButtonCssClass="btn btn-default"
                                                            ButtonCount="10" NextPageText="..." NextPreviousButtonCssClass="btn btn-default" />
                                                        <asp:NextPreviousPagerField NextPageText=">" LastPageText="Last" ShowNextPageButton="true"
                                                            ShowLastPageButton="true" ShowPreviousPageButton="false" ButtonCssClass="btn btn-default"
                                                            RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="false" />
                                                    </Fields>
                                                </asp:DataPager>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                </div>
                                <br />
                                <div class="col-lg-4">
                                    <div class="chat-panel panel panel-default">
                                        <div class="panel-heading">
                                            <label><i class="fa fa-pencil fa-fw"></i> Create Question</label>
                                        </div>
                                        <!-- /.panel-heading -->
                                        <div class="panel-footer" style="overflow: hidden;">
                                            <div class="input-group">
                                                    <label><input type="checkbox" id="checkboxCategory" runat="server" onchange="javascript:__doPostBack('checkboxCategory','')"> Existing Category</label>
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-gears fa-fw" aria-hidden="true"></i>
                                                </span>
                                                <input runat="server" id="textQcategory" class="form-control" type="text" placeholder="Type New Category" disabled>
                                            </div>
                                            <br />
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-gear fa-fw" aria-hidden="true"></i>
                                                </span>
                                                <input runat="server" id="textQcode" class="form-control" type="text" placeholder="Question Code">
                                            </div>
                                            <br />
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-tag fa-fw" aria-hidden="true"></i>
                                                </span>
                                                <input runat="server" id="textQname"  class="form-control" type="text" placeholder="Question Name">
                                            </div>
                                            <br />
                                            <label runat="server" id="labelMessage"></label>
                                            <button runat="server" id="buttonCreate" onclick="javascript:__doPostBack('buttonCreate','')" class="btn btn-primary btn-sm pull-right">
                                                    Create New Question
                                                </button>
                                        </div>
                                        <!-- /.panel-footer -->
                                    </div>
                                    <!-- /.panel .chat-panel -->
                                </div>
                                <!-- /.col-lg-4 -->
                                <!-- /.table-responsive -->
                            </div>
                            <!-- /.panel-body -->
                        </div>
                    </div>
                    <!-- /.col-lg-8 -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /#page-wrapper -->
        </div>
    <!-- jQuery -->
    <script src="bower_components/jquery/dist/jquery.min.js"></script>
    </body>
</asp:Content>
