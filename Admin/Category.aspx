<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" %>

<script runat="server">

protected void search()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["sqlexp"].ToString());
        SqlCommand cmd = new SqlCommand(string.Format("Select * From category Where {0} like'%{1}%'",rbtSearchBy.SelectedValue,txtsearch.Text),con);
        DataTable tblcat = new DataTable();

        con.Open();
        tblcat.Load(cmd.ExecuteReader());
        con.Close();
    
        gdvsearch.DataSource = tblcat;
        gdvsearch.DataBind();
        gdvsearch.SelectedIndex = -1;

        btnDelete.Enabled = false;
        btnEdit.Enabled = false;
    
    }






    protected void btnSearch_Click(object sender, EventArgs e)
    {
        search();
    }

    protected void gdvsearch_SelectedIndexChanged1(object sender, EventArgs e)
    {
        btnEdit.Enabled = true;
        btnDelete.Enabled = true;
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["sqlexp"].ToString());
        SqlCommand cmd = new SqlCommand(string.Format("delete from category where catno={0}",gdvsearch.SelectedRow.Cells[1].Text),con);

        try
        {
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();   
            lblMsg1.Text = "Category " + gdvsearch.SelectedRow.Cells[2].Text + " IS Deleted";
           
        }
        catch (Exception ex)
        {
            lblMsg1.Text = ex.Message;
        }
        search();
    }

    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        lblTitle.Text = "Add New";
        ViewState["type"] = "add";
        txtcatno.Text = "";
        txtcatno.ReadOnly = false;
        txtcatname.Text = "";
        txtdescription.Text = "";
        imgCat.Visible = false;
        MultiView1.ActiveViewIndex=1;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["sqlexp"].ToString());
        SqlCommand cmd = new SqlCommand("",con);

        if (ViewState["type"].ToString()=="add")
           cmd.CommandText = string.Format("insert into category values ({0},'{1}','{2}')",txtcatno.Text,txtcatname.Text,txtdescription.Text);
        else
            cmd.CommandText = string.Format("update category set catname='{0}',description='{1}' where catno={2}",txtcatname.Text,txtdescription.Text,txtcatno.Text);
         
        try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                MultiView1.ActiveViewIndex = 0;
                if (fupcatimage.HasFile)
                    fupcatimage.SaveAs(Server.MapPath("CatImage\\"+txtcatno.Text+".jpg"));             
                lblMsg1.Text = "Category Is " + ViewState["type"] + "ed";
            }
            catch (Exception ex)
            {
                
                lblMsg2.Text = ex.Message;
            }
            search();
        }


    protected void btncancel_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        lblTitle.Text = "Edit Data";
        ViewState["type"] = "edit";
        txtcatno.Text = gdvsearch.SelectedRow.Cells[1].Text;
        txtcatname.Text = gdvsearch.SelectedRow.Cells[2].Text;
        txtdescription.Text = gdvsearch.SelectedRow.Cells[3].Text;
        imgCat.Visible = true;
        imgCat.ImageUrl = "CatImage\\" + txtcatno.Text + ".jpg";
        MultiView1.ActiveViewIndex = 1;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style2 {
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="Label2" runat="server" Font-Names="Impact" Font-Overline="True" Font-Underline="True" style="font-weight: 700; font-size: xx-large" Text="Category Form"></asp:Label>
    <br />
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <table align="center">
                <tr>
                    <td>
                        <asp:Button ID="btnDelete" runat="server" style="font-weight: 700" Text="Delete Category" Enabled="False" OnClick="btnDelete_Click" />
                        &nbsp;<asp:Button ID="btnEdit" runat="server" style="font-weight: 700" Text="Edit Data" Enabled="False" OnClick="btnEdit_Click" />
                        &nbsp;<asp:Button ID="btnAddNew" runat="server" style="font-weight: 700" Text="Add New Category" OnClick="btnAddNew_Click" />
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="Label3" runat="server" style="font-size: x-large; font-weight: 700" Text="Search By :"></asp:Label>
                        <asp:RadioButtonList ID="rbtSearchBy" runat="server" RepeatDirection="Horizontal" style="font-weight: 700;">
                            <asp:ListItem Selected="True" Value="catname">CategoryName</asp:ListItem>
                            <asp:ListItem Value="description">Description</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtsearch" runat="server"></asp:TextBox>
                        <asp:Button ID="btnSearch" runat="server" style="font-weight: 700" Text="Search" OnClick="btnSearch_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblMsg1" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:GridView ID="gdvsearch" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" style="font-weight: 700" OnSelectedIndexChanged="gdvsearch_SelectedIndexChanged1">
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
        </asp:View>
        <asp:View ID="View2" runat="server">
            <table align="center">
                <tr>
                    <td colspan="3" align="center">
                        <asp:Label ID="lblTitle" runat="server" Font-Names="Impact" style="font-weight: 700; font-size: x-large"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" style="font-weight: 700" Text="Category Number :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtcatno" runat="server" Width="190px"></asp:TextBox>
                    </td>
                    <td rowspan="4">
                        <asp:Image ID="imgCat" runat="server" Height="130px" Width="131px" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" style="font-weight: 700" Text="Category Name :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtcatname" runat="server" Width="190px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" style="font-weight: 700" Text="Description :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtdescription" runat="server" TextMode="MultiLine" style="resize:none;" Height="58px" Width="190px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label7" runat="server" style="font-weight: 700" Text="Category Image :"></asp:Label>
                    </td>
                    <td>
                        <asp:FileUpload ID="fupcatimage" runat="server" style="font-weight: 700" Width="190px" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblMsg2" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <asp:Button ID="btnSave" runat="server" CssClass="auto-style2" Text="Save" Height="32px" OnClick="btnSave_Click" Width="80px" />
                        &nbsp;
                        <asp:Button ID="btncancel" runat="server" CssClass="auto-style2" Text="Cancel" Height="32px" Width="80px" OnClick="btncancel_Click" />
                    </td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </asp:View>
    </asp:MultiView>
    <br />
</asp:Content>

