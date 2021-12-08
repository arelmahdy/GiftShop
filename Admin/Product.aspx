<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" %>

<script runat="server">

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
    }
    protected void Search()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["sqlexp"].ToString());
        SqlCommand cmd = new SqlCommand(string.Format("Select * From product Where {0} like'%{1}%'", rbtSearchBy.SelectedValue, txtsearch.Text), con);
        DataTable tblPro = new DataTable();

        con.Open();
        tblPro.Load(cmd.ExecuteReader());
        con.Close();

        gdvsearch.DataSource = tblPro;
        gdvsearch.DataBind();
        gdvsearch.SelectedIndex = -1;

        btnDelete.Enabled = false;
        btnEdit.Enabled = false;
    }
    protected void btnsearch0_Click(object sender, EventArgs e)
    {
        Search();
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        pnlConDel.Visible = true;
    }



    protected void btnYes_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["sqlexp"].ToString());
        SqlCommand cmd = new SqlCommand(string.Format("delete from product where catno={0} and proid={1}", gdvsearch.SelectedRow.Cells[1].Text,gdvsearch.SelectedRow.Cells[2].Text), con);

        try
        {
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            lblMsg1.Text = "Product " + gdvsearch.SelectedRow.Cells[3].Text + " IS Deleted";

        }
        catch (Exception ex)
        {
            lblMsg1.Text = ex.Message;
        }
        pnlConDel.Visible = false;
        Search();
    }

    protected void gdvsearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        btnEdit.Enabled = true;
        btnDelete.Enabled = true;
    }

    protected void btnAddNewPro_Click(object sender, EventArgs e)
    {
        lblTitle.Text = "Add New";
        ViewState["type"] = "add";
        txtProno.ReadOnly = false;
        txtProno.Text = "";
        txtProname.Text = "";
        txtPrice.Text = "";
        txtQny.Text = "";
        txtDescription.Text = "";
        imgPro.Visible = false;
        MultiView1.ActiveViewIndex = 1;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
                   //Fill Data In ComboBox 
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["sqlexp"].ToString());
        SqlCommand cmd = new SqlCommand("Select * From category ", con);
        DataTable tblcat = new DataTable();
        
        con.Open();
        tblcat.Load(cmd.ExecuteReader());
        con.Close();
        
        ddlCat.DataSource = tblcat;
        ddlCat.DataTextField = "catname";
        ddlCat.DataValueField = "catno";
        ddlCat.DataBind(); 
        }

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
      


            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["sqlexp"].ToString());
            SqlCommand cmd = new SqlCommand("", con);

            if (ViewState["type"].ToString() == "add")
                cmd.CommandText = string.Format("insert into product values ({0},{1},'{2}',{3},{4},GetDate(),'{5}')", ddlCat.SelectedValue, txtProno.Text, txtProname.Text, txtPrice.Text, txtQny.Text, txtDescription.Text);
            else
                cmd.CommandText = string.Format("update product set proname='{0}',price={1},avqty={2},writingdate=GetDate(),description='{3}' where catno={4} and proid={5}", txtProname.Text, txtPrice.Text, txtQny.Text, txtDescription.Text, ddlCat.SelectedValue, txtProno.Text);

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                MultiView1.ActiveViewIndex = 0;
                if (fupPro.HasFile)
                    fupPro.SaveAs(Server.MapPath("ProImage\\" + ddlCat.SelectedValue + txtProno.Text + ".jpg"));
                lblMsg1.Text = "Product Is " + ViewState["type"] + "ed";
            }
            catch (Exception ex)
            {

                lblMsg2.Text = ex.Message;
            }
            Search();
        }
    
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        lblTitle.Text = "Edit Data";
        ViewState["type"] = "edit";
        ddlCat.SelectedValue = gdvsearch.SelectedRow.Cells[1].Text;
        txtProno.Text = gdvsearch.SelectedRow.Cells[2].Text;
        txtProname.Text = gdvsearch.SelectedRow.Cells[3].Text;
        txtPrice.Text = gdvsearch.SelectedRow.Cells[4].Text;
        txtQny.Text = gdvsearch.SelectedRow.Cells[5].Text;
        txtDescription.Text = gdvsearch.SelectedRow.Cells[7].Text;
        imgPro.Visible = true;
        imgPro.ImageUrl = "ProImage\\" + ddlCat.SelectedValue + txtProno.Text + ".jpg";
        txtProno.ReadOnly = true;
        MultiView1.ActiveViewIndex = 1;    
        
    }


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style3 {
            font-weight: bold;
            font-size: medium;
        }
        .auto-style4 {
            height: 45px;
            color: #FFFFFF;
            width: 425px;
            background-color: #003366;
        }
        .auto-style5 {
            width: 425px;
            color: #6699FF;
            background-color: #FFFFFF;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
                        <asp:Panel ID="Panel1" runat="server">
                            <asp:Label ID="Label2" runat="server" style="font-weight: 700; font-size: xx-large;" Text="Product Form" Font-Names="Impact" Font-Overline="True" Font-Underline="True"></asp:Label>
                            <br />
                            <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                                <asp:View ID="View1" runat="server">
                                    <table align="center">
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnDelete" runat="server" CssClass="auto-style3" Text="Delete Product" OnClick="btnDelete_Click" Enabled="False" />
                                                &nbsp;
                                                <asp:Button ID="btnEdit" runat="server" CssClass="auto-style3" Text="Edit Dtata" Enabled="False" OnClick="btnEdit_Click" />
                                                &nbsp;
                                                <asp:Button ID="btnAddNewPro" runat="server" CssClass="auto-style3" Text="Add New Product" OnClick="btnAddNewPro_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <asp:Label ID="Label4" runat="server" style="font-weight: 700; font-size: x-large" Text="Search By :"></asp:Label>
                                                <br />
                                                <asp:RadioButtonList ID="rbtSearchBy" runat="server" RepeatDirection="Horizontal" style="font-weight: 700; font-size: large">
                                                    <asp:ListItem Selected="True" Value="proname">Product Name</asp:ListItem>
                                                    <asp:ListItem Value="description">Description</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtsearch" runat="server"></asp:TextBox>
                                                &nbsp;
                                                <asp:Button ID="btnsearch" runat="server" style="font-weight: 700" Text="Search" OnClick="btnsearch0_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <asp:Label ID="lblMsg1" runat="server" style="font-weight: 700; font-size: large"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Panel ID="pnlConDel" runat="server" Visible="False">
                                                    <table align="center">
                                                        <tr>
                                                            <td class="auto-style4">
                                                                <asp:Label ID="Label12" runat="server" Font-Names="Trebuchet MS" style="font-weight: 700; font-size: x-large" Text="Confirm Delete"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="auto-style5">
                                                                <asp:Label ID="Label13" runat="server" style="font-weight: 700; font-size: large; color: #000066; background-color: #FFFFCC" Text="Do You Want The Delete To The Product ?"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="auto-style5">
                                                                <asp:Button ID="btnYes" runat="server" style="font-weight: 700" Text="Yes" Width="48px" OnClick="btnYes_Click" />
                                                                &nbsp;&nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
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
                                </asp:View>
                                <asp:View ID="View2" runat="server">
                                    <table align="center">
                                        <tr>
                                            <td colspan="3">
                                                <asp:Label ID="lblTitle" runat="server" Font-Names="imapct" style="font-weight: 700; font-size: xx-large"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label5" runat="server" style="font-weight: 700; font-size: large" Text="Category :"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCat" runat="server" Height="21px" Width="163px" >
                                                </asp:DropDownList>
                                            </td>
                                            <td rowspan="7">
                                                <asp:Image ID="imgPro" runat="server" Height="130px" Width="131px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style1">
                                                <asp:Label ID="Label6" runat="server" style="font-weight: 700; font-size: large" Text="Product Number :"></asp:Label>
                                            </td>
                                            <td class="auto-style1">
                                                <asp:TextBox ID="txtProno" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label7" runat="server" style="font-weight: 700; font-size: large" Text="Product Name :"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtProname" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label8" runat="server" style="font-weight: 700; font-size: large" Text="Price :"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPrice" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label9" runat="server" style="font-weight: 700; font-size: large" Text="Current Quantity :"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtQny" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label10" runat="server" style="font-weight: 700; font-size: large" Text="Description :"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" style="resize:none;"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label11" runat="server" style="font-weight: 700; font-size: large" Text="Product Image :"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:FileUpload ID="fupPro" runat="server" Width="181px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="lblMsg2" runat="server" style="font-weight: 700; font-size: large; color: #FF0000"></asp:Label>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>
                                                <asp:Button ID="btnSave" runat="server" style="font-weight: 700" Text="Save" Width="74px" OnClick="btnSave_Click" />
                                                &nbsp;&nbsp;
                                                <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" style="font-weight: 700" Text="Cancel" Width="69px" />
                                            </td>
                                            <td>
                                                &nbsp;</td>
                                        </tr>
                                    </table>
                                </asp:View>
                            </asp:MultiView>
                        </asp:Panel>
                    </asp:Content>


