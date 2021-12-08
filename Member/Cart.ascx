<%@ Control Language="C#" ClassName="Cart"%>

<script runat="server">

    protected void Fillgdv()
    {
        gdvCart.DataSource = (DataTable)Session["items"];
        
        gdvCart.DataBind();
        double sum = 0;
        for (int i = 0; i < gdvCart.Rows.Count; i++)
        {
            sum += Convert.ToDouble(gdvCart.Rows[i].Cells[6].Text);
            lblTotal.Text = sum.ToString();
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        Fillgdv();
    }

    protected void gdvCart_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gdvCart.EditIndex = e.NewEditIndex;
        Fillgdv();
    }

    protected void gdvCart_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gdvCart.EditIndex = -1;
        Fillgdv();
    }
    DataTable tblcart = new DataTable();
    DataRow row;
    protected void FindRow(int RowNum)
    {
        tblcart = (DataTable)Session["items"];
        object[] PK = { tblcart.Rows[RowNum][0],tblcart.Rows[RowNum][2] };
        row = tblcart.Rows.Find(PK);
    }
    protected void DeleteRow(int RowNum)
    {
        FindRow(RowNum);
        row.Delete();
        gdvCart.EditIndex = -1;
        Session["items"] = tblcart;
        Fillgdv();    
    }

    protected void gdvCart_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        DeleteRow(e.RowIndex);
        
    }

    protected void gdvCart_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        TextBox textqty = (TextBox)gdvCart.Rows[e.RowIndex].Cells[5].Controls[0];
        double qty = Convert.ToDouble(textqty.Text);
        if (qty < 1)
            DeleteRow(e.RowIndex);
        else
        {
            FindRow(e.RowIndex);
            row["qty"] = qty;
            row["subtotal"] = qty * Convert.ToDouble(row["price"]);
            Session["items"] = tblcart;
            gdvCart.EditIndex = -1;
        }
        Fillgdv();
    }
</script>
 <table align="center">
            <tr>
                <td align="center">
                    <asp:GridView ID="gdvCart" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" HorizontalAlign="Center" OnRowEditing="gdvCart_RowEditing" OnRowCancelingEdit="gdvCart_RowCancelingEdit" OnRowDeleting="gdvCart_RowDeleting" OnRowUpdating="gdvCart_RowUpdating">
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                        <Columns>
                            <asp:BoundField DataField="catno" HeaderText="Category Number" ReadOnly="True" />
                            <asp:BoundField DataField="catname" HeaderText="Category Name" ReadOnly="True" />
                            <asp:BoundField DataField="proid" HeaderText="Product Number" ReadOnly="True" />
                            <asp:BoundField DataField="proname" HeaderText="Product Name" ReadOnly="True" />
                            <asp:BoundField DataField="price" HeaderText="Price" ReadOnly="True" />
                            <asp:BoundField DataField="qty" HeaderText="Quantity" />
                            <asp:BoundField DataField="subtotal" HeaderText="Sub Total" ReadOnly="True" />
                            <asp:TemplateField HeaderText="Product Image">
                                <ItemTemplate>
                                    <asp:Image ID="Image1" runat="server" AlternateText='<%# Eval("proname") %>' Height="126px" ImageUrl='<%# "..\\Admin\\ProImage\\"+Eval("catno")+Eval("proid")+".jpg" %>' Width="118px" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ButtonType="Button" HeaderText="Control" ShowDeleteButton="True" ShowEditButton="True" />
                        </Columns>
                        <EditRowStyle HorizontalAlign="Center" />
                        <EmptyDataRowStyle HorizontalAlign="Center" />
                        <EmptyDataTemplate>
                            <strong>The Shopping Cart Is Nothing To&nbsp; Shop <a href="Categories.aspx">Click Here</a></strong>
                        </EmptyDataTemplate>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <SortedAscendingCellStyle BackColor="#F4F4FD" />
                        <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                        <SortedDescendingCellStyle BackColor="#D8D8F0" />
                        <SortedDescendingHeaderStyle BackColor="#3E3277" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td style="text-align: center; font-weight: 700; font-size: large">
                    <asp:Label ID="Label1" runat="server" style="text-align: center" Text="Total Is :"></asp:Label>
                    <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label>
                </td>
            </tr>
        </table>



