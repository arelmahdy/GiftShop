<%@ Page Title="" Language="C#" MasterPageFile="~/Member/MemberMaster.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Request.QueryString["catno"]!=null)||(Request.QueryString["proid"]!=null))
        {

            string strCatNo = Request.QueryString["catno"];
            string StrProId = Request.QueryString["proid"]; 
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["sqlexp"].ToString());
                    SqlCommand cmd = new SqlCommand(string.Format("Select * From catpro Where catno={0} and proid={1}",(strCatNo),(StrProId)),con);
                    DataTable tbl= new DataTable();
                    con.Open();
                    tbl.Load(cmd.ExecuteReader());
                    con.Close();
                   
                   
                        lblcatname.Text =tbl.Rows[0][0].ToString();
                        lblcatno.Text = tbl.Rows[0][1].ToString();
                        lblCutQun.Text = tbl.Rows[0][5].ToString();
                        lblDesc.Text = tbl.Rows[0][7].ToString();
                        lblPrice.Text = tbl.Rows[0][4].ToString();
                        lblProName.Text = tbl.Rows[0][3].ToString();
                        lblProNo.Text = tbl.Rows[0][2].ToString();
                        lblWriData.Text = tbl.Rows[0][6].ToString();

                        imgPro.ImageUrl = "..\\Admin\\ProImage\\" + strCatNo + StrProId + ".jpg";
                   
        }
        else
        {
            Response.Redirect("Categories.aspx");
          
        }
        
    }

    protected void btnAddToCart_Click(object sender, EventArgs e)
    {
        DataTable tblCart = new DataTable();
        if (Session["items"] != null)
            tblCart = (DataTable)Session["items"];
        else
        {
            tblCart.Columns.Add("catno");
            tblCart.Columns.Add("catname");
            tblCart.Columns.Add("proid");
            tblCart.Columns.Add("proname");
            tblCart.Columns.Add("price"); 
            tblCart.Columns.Add("qty");
            tblCart.Columns.Add("subtotal");
            DataColumn[] Pk = { tblCart.Columns["catno"], tblCart.Columns["proid"] };
            tblCart.Constraints.Add("cart_PK",Pk,true);
        } 
        DataRow row = tblCart.NewRow();
        row["catno"] = lblcatno.Text;
        row["catname"] = lblcatname.Text;
        row["proid"] = lblProNo.Text;
        row["proname"] = lblProName.Text;
        row["price"] = lblPrice.Text;
        row["qty"] = lblCutQun.Text;
        row["subtotal"] = Convert.ToDouble(row["qty"])*Convert.ToDouble(row["price"]);


        try
        {
        tblCart.Rows.Add(row);
        Session["items"] = tblCart;
        Response.Redirect("Categories.aspx"); 
        }
        catch (Exception ex)
        {
            lblErr.Text = "You Already Choosed This Product Try Another One";
            
        }
 
    
	
    }
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
    .auto-style3 {
        width: 257px;
            height: 326px;
        }
    .auto-style4 {
        width: 168px;
    }

        .auto-style5 {
            height: 326px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <asp:Panel ID="Panel1" runat="server">
                            <asp:Label ID="Label2" runat="server" style="font-weight: 700; font-size: xx-large;" Text="Product Detalis" Font-Names="Trebuchet MS" Font-Overline="True" Font-Underline="True"></asp:Label>
                            <br />
                            <br />
                            <table align="center" style="width: 717px">
                                <tr>
                                    <td class="auto-style3">
                                        <asp:Image ID="imgPro" runat="server" Height="308px" Width="255px" />
                                    </td>
                                    <td class="auto-style5">
                                        <table align="center" style="width: 383px">
                                            <tr>
                                                <td class="auto-style4">
                                                    <asp:Label ID="Label3" runat="server" style="font-weight: 700; font-size: large; color: #FFFF66" Text="Category Number :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblcatno" runat="server" style="font-weight: 700; font-size: large"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style4">
                                                    <asp:Label ID="Label4" runat="server" style="font-weight: 700; font-size: large; color: #FFFF66; text-align: left" Text="Category Name :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblcatname" runat="server" style="font-weight: 700; font-size: large"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style4">
                                                    <asp:Label ID="Label5" runat="server" style="font-weight: 700; font-size: large; color: #FFFF66; text-align: left" Text="Product Number :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblProNo" runat="server" style="font-weight: 700; font-size: large"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style4">
                                                    <asp:Label ID="Label6" runat="server" style="font-weight: 700; font-size: large; color: #FFFF66; text-align: left" Text="Product Name :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblProName" runat="server" style="font-weight: 700; font-size: large"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style4">
                                                    <asp:Label ID="Label7" runat="server" style="font-weight: 700; font-size: large; color: #FFFF66; text-align: left" Text="Price :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPrice" runat="server" style="font-weight: 700; font-size: large"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style4">
                                                    <asp:Label ID="Label8" runat="server" style="font-weight: 700; font-size: large; color: #FFFF66; text-align: left" Text="Current Quentity :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCutQun" runat="server" style="font-weight: 700; font-size: large"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style4">
                                                    <asp:Label ID="Label9" runat="server" style="font-weight: 700; font-size: large; color: #FFFF66; text-align: left" Text="Writing Data :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblWriData" runat="server" style="font-weight: 700; font-size: large"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style4">
                                                    <asp:Label ID="Label10" runat="server" style="font-weight: 700; font-size: large; color: #FFFF66; text-align: left" Text="Description :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblDesc" runat="server" style="font-weight: 700; font-size: large"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style4">
                                                    <asp:Label ID="lblErr" runat="server" style="font-weight: 700; font-size: large"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtQty" runat="server" Width="45px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtQty" ErrorMessage="?" style="font-weight: 700; color: #FF0000"></asp:RequiredFieldValidator>
                                                    <asp:Button ID="btnAddToCart" runat="server" style="font-weight: 700;   border-radius:3rem; outline:none;  background-color:#0094ff;color:white;font-family:'Trebuchet MS';" Text="Add To Cart" OnClick="btnAddToCart_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </asp:Content>


