<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" %>

<script runat="server">
    protected void search()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["sqlexp"].ToString());
        SqlCommand cmd = new SqlCommand(string.Format("Select * From member Where {0} like'%{1}%'", rblSearchBy.SelectedValue, txtSearch0.Text), con);
        DataTable tblcat = new DataTable();

        con.Open();
        tblcat.Load(cmd.ExecuteReader());
        con.Close();

        gdvsearch.DataSource = tblcat;
        gdvsearch.DataBind();
        gdvsearch.SelectedIndex = -1;

        btnDeleteMember.Enabled = false;
       

    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void gdvsearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        btnDeleteMember.Enabled = true;
    }

    protected void btnSearch0_Click(object sender, EventArgs e)
    {
        search();
    }

    protected void btnShowAllMember_Click(object sender, EventArgs e)
    {
        txtSearch0.Text = "";
        search();
    }

    protected void btnDeleteMember_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["sqlexp"].ToString());
        SqlCommand cmd = new SqlCommand(string.Format("delete from member where username='{0}'", gdvsearch.SelectedRow.Cells[8].Text), con);

        try
        {
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            lblMsg.Text = "Member " + gdvsearch.SelectedRow.Cells[8].Text + " IS Deleted";

        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message;
        }
        search();
    }

    protected void btnReportMember_Click(object sender, EventArgs e)
    {
        Response.Redirect("ReportMember.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style3 {
            height: 45px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
                        <asp:Panel ID="Panel1" runat="server">
                            <asp:Label ID="Label2" runat="server" style="font-weight: 700; font-size: xx-large;" Text="Member Form" Font-Names="Trebuchet MS" Font-Overline="True" Font-Underline="True"></asp:Label>
                            <br />
                            <table align="center">
                                <tr>
                                    <td>
                                        <asp:Button ID="btnDeleteMember" runat="server" Text="Delete Member" Enabled="False" OnClick="btnDeleteMember_Click" />
                                        &nbsp;
                                        <asp:Button ID="btnShowAllMember" runat="server" Text="Show All Member" OnClick="btnShowAllMember_Click" />
                                        &nbsp;
                                        <asp:Button ID="btnReportMember" runat="server" Text="Report Member" OnClick="btnReportMember_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="Label3" runat="server" style="font-weight: 700; font-size: x-large" Text="Search By :"></asp:Label>
                                        <asp:RadioButtonList ID="rblSearchBy" runat="server" RepeatDirection="Horizontal" style="font-weight: 700">
                                            <asp:ListItem Selected="True" Value="fullName">Full Name</asp:ListItem>
                                            <asp:ListItem Value="gender">Gender</asp:ListItem>
                                            <asp:ListItem Value="country">Country</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtSearch0" runat="server"></asp:TextBox>
                                        &nbsp;<asp:Button ID="btnSearch0" runat="server" style="font-weight: 700" Text="Search" OnClick="btnSearch0_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style3">&nbsp;
                                        <asp:Label ID="lblMsg" runat="server" style="font-weight: 700; font-size: x-large"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gdvsearch" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" OnSelectedIndexChanged="gdvsearch_SelectedIndexChanged">
                                            <AlternatingRowStyle BackColor="#F7F7F7" />
                                            <Columns>
                                                <asp:ButtonField ButtonType="Button" CommandName="Select" HeaderText="Select Row" Text="→" />
                                            </Columns>
                                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                            <SortedAscendingCellStyle BackColor="#F4F4FD" />
                                            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                                            <SortedDescendingCellStyle BackColor="#D8D8F0" />
                                            <SortedDescendingHeaderStyle BackColor="#3E3277" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </asp:Content>


