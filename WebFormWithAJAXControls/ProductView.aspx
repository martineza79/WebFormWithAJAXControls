<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductView.aspx.cs" Inherits="WebFormWithAJAXControls.ProductView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Products Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/bootstrap-theme.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.9.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
</head>
<body>
    <div class="container">
        <header class="jumbotron">This Web Page contains AJAX controls with Bootstrap framework.<br />LINQ queries are used to return collection of products from the database</header>
        <main>
            <h1>Products By Category</h1>
            <form id="form1" runat="server" class="form-horizontal">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

                <div class="row">
                    <div class="col-xs-12 table-responsive">
                        <label id="lblCategory" for="ddlCategory" class="col-xs-3 control-label">
                            Choose a category:
                        </label>

                        <div class="col-xs-3">
                            <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="true" CssClass="form-control" DataSourceID="sqlDataSource1" DataTextField="LongName" DataValueField="CategoryID" OnSelectedIndexChanged="Reset"></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HalloweenConnection %>" SelectCommand="SELECT [CategoryID], [LongName] FROM [Categories] ORDER BY [LongName]"></asp:SqlDataSource>
                        </div>

                        <asp:Button ID="btnClear" runat="server" Text="ClearDetails" OnClick="Reset" CssClass="btn"/>
                    </div>
                    <div class="col-xs-7">
                        <br />
                        <asp:UpdatePanel ID="pnlProducts" runat="server">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlCategory"
                                    EventName="SelectedIndexChanged" />
                            </Triggers>
                            <ContentTemplate>
                                <asp:GridView ID="grdProducts" runat="server" AutoGenerateColumns="false"
                                    DataSourceID="SqlDataSource2" DataKeyNames="ProductID"
                                    CssClass="table table-bordered table-striped table-condensed"
                                    OnSelectedIndexChanged="grdProducts_SelectedIndexChanged"
                                    OnPreRender="GridView_PreRender">
                                    <Columns>
                                        <asp:CommandField ShowSelectButton="true" SelectText="View">
                                            <ItemStyle CssClass="col-xs-1" />
                                        </asp:CommandField>
                                        <asp:BoundField DataField="ProductID" HeaderText="ID"
                                            ReadOnly="True">
                                            <ItemStyle CssClass="col-xs-2" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Name" HeaderText="Name">
                                            <ItemStyle CssClass="col-xs-4" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="UnitPrice" HeaderText="Price"
                                            DataFormatString="{0:c}">
                                            <ItemStyle CssClass="col-xs-2 text-right" />
                                            <HeaderStyle CssClass="text-right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="OnHand" HeaderText="On Hand">
                                            <ItemStyle CssClass="col-xs-2 text-right" />
                                            <HeaderStyle CssClass="text-right" />
                                        </asp:BoundField>
                                    </Columns>
                                    <HeaderStyle CssClass="bg-halloween" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:HalloweenConnection %>"
                                    SelectCommand="SELECT [ProductID], [Name], [UnitPrice], [OnHand]
                                         FROM [Products] WHERE ([CategoryID] = @CategoryID)
                                         ORDER BY [ProductID]">
                                    <SelectParameters>
                                        <asp:ControlParameter Name="CategoryID" Type="String"
                                            ControlID="ddlCategory" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <h2>Product Details</h2>
                                <asp:DetailsView ID="dvwProduct" runat="server" AutoGenerateRows="False"
                                    DataKeyNames="ProductID" DataSourceID="SqlDataSource3"
                                    CssClass="table table-bordered table-condensed">
                                    <Fields>
                                        <asp:BoundField DataField="ProductID" HeaderText="ID"
                                            ReadOnly="True">
                                            <HeaderStyle CssClass="col-xs-4" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Name" HeaderText="Name" />
                                        <asp:BoundField DataField="UnitPrice" HeaderText="Price"
                                            DataFormatString="{0:c}" />
                                        <asp:BoundField DataField="OnHand" HeaderText="On Hand" />
                                        <asp:BoundField DataField="ShortDescription" HeaderText="Short
                              Description" />
                                        <asp:BoundField DataField="LongDescription" HeaderText="Long
                              Description" />
                                        <asp:BoundField DataField="CategoryID" HeaderText="Category ID" />
                                    </Fields>
                                    <RowStyle CssClass="dvRow" />
                                </asp:DetailsView>
                                <asp:SqlDataSource runat="server" ID="SqlDataSource3"
                                    ConnectionString="<%$ ConnectionStrings:HalloweenConnection %>"
                                    SelectCommand="SELECT [ProductID], [Name], [ShortDescription],
                            [LongDescription], [CategoryID], [UnitPrice], [OnHand] 
                            FROM [Products] WHERE ([ProductID] = @ProductID)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="grdProducts" Type="String"
                                            PropertyName="SelectedValue" Name="ProductID" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>

                    <div class="col-xs-5 table-responsive">
                        <h2 id="most-viewed">Most viewed</h2>
                        <asp:UpdatePanel ID="pnlViews" runat="server">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="grdProducts"
                                    EventName="SelectedIndexChanged" />
                            </Triggers>
                            <ContentTemplate>
                                <asp:GridView ID="grdViews" runat="server"
                                    AutoGenerateColumns="false" OnPreRender="GridView_PreRender"
                                    CssClass="table table-bordered table-condensed">
                                    <Columns>
                                        <asp:BoundField DataField="ProductName" HeaderText="Product">
                                            <ItemStyle CssClass="col-xs-5" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ViewCount" HeaderText="Views">
                                            <ItemStyle CssClass="col-xs-3" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CategoryID" HeaderText="Cat ID">
                                            <ItemStyle CssClass="col-xs-4" />
                                        </asp:BoundField>
                                    </Columns>
                                    <HeaderStyle CssClass="bg-halloween" />
                                </asp:GridView>
                                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                    <ProgressTemplate>
                                        <div class="spinner">
                                            <img src="Images/spinner.gif"
                                                alt="Please Wait" />Loading...
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </form>
        </main>
    </div>
</body>
</html>
