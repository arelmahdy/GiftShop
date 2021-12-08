<%@ Page Title="" Language="C#" MasterPageFile="~/Member/MemberMaster.master" %>

<%@ Register src="..\\LogIn.ascx" tagname="LogIn" tagprefix="uc1" %>

<%@ Register src="Cart.ascx" tagname="Cart" tagprefix="uc2" %>

<%@ Register src="../LogIn.ascx" tagname="LogIn" tagprefix="uc3" %>

<script runat="server">

    protected void Wizard1_ActiveStepChanged(object sender, EventArgs e)
    {
        Label lblLogged = (Label)LogIn1.FindControl("lblUser");
        if (lblLogged.Text=="")
        {
            Wizard1.ActiveStepIndex = 0;
        }
    }

    protected void Wizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["sqlexp"].ToString());
        SqlCommand cmdCardOrder = new SqlCommand();
        SqlCommand cmdOrderDetalis = new SqlCommand();
        SqlTransaction tran;

        cmdCardOrder.Connection = con;
        cmdCardOrder.CommandText = "Add_CartOrder";
        cmdCardOrder.CommandType = CommandType.StoredProcedure;

        cmdCardOrder.Parameters.AddWithValue("@cardnum",txtCardNum.Text);
        cmdCardOrder.Parameters.AddWithValue("@cardtype", ddlCardType.SelectedValue);
        cmdCardOrder.Parameters.AddWithValue("@EMonth", txtMonth.Text);
        cmdCardOrder.Parameters.AddWithValue("@EYear", txtYear.Text);
        cmdCardOrder.Parameters.AddWithValue("@NameInCard", txtNameInCard.Text);
        cmdCardOrder.Parameters.AddWithValue("@ShipName", txtName.Text);
        cmdCardOrder.Parameters.AddWithValue("@ShipCity", txtCity.Text);
        cmdCardOrder.Parameters.AddWithValue("@ShipArea", txtArea.Text);
        cmdCardOrder.Parameters.AddWithValue("@ShipAddress", txtAddress.Text);
        cmdCardOrder.Parameters.AddWithValue("@ShipMethod", rblShipMethod.SelectedValue);
        Label lblLogged = (Label)LogIn1.FindControl("lblUser");
        cmdCardOrder.Parameters.AddWithValue("@Member", lblLogged.Text);

        cmdOrderDetalis.Connection = con;
        cmdOrderDetalis.CommandText = "Add_Orderdetalis";
        cmdOrderDetalis.CommandType = CommandType.StoredProcedure;
        
        con.Open();
        tran = con.BeginTransaction();
        cmdCardOrder.Transaction = tran;
        cmdOrderDetalis.Transaction = tran;

        try
        {
            cmdCardOrder.ExecuteNonQuery();
            DataTable tblcart = new DataTable("Cart");
            tblcart = (DataTable)Session["items"];
            for (int x = 0; x < tblcart.Rows.Count; x++)
            {
                cmdOrderDetalis.Parameters.AddWithValue("@catno",tblcart.Rows[x]["catno"]);
                cmdOrderDetalis.Parameters.AddWithValue("@proid", tblcart.Rows[x]["proid"]);
                cmdOrderDetalis.Parameters.AddWithValue("@quantity", tblcart.Rows[x]["qty"]);
                cmdOrderDetalis.Parameters.AddWithValue("@sellprice", tblcart.Rows[x]["price"]);
                
                cmdOrderDetalis.ExecuteNonQuery();
                cmdOrderDetalis.Parameters.Clear();
            
            }
            lblMsgComplete.Text = "Thank You For Your Order";
            tran.Commit();
        }
        catch (SqlException EX)
        {
            tran.Rollback();
            lblMsgComplete.Text = EX.Message;
            
        }
        con.Close();
        
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style3 {
            height: 20px;
            font-weight: 700;
        }
        .auto-style4 {
            height: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <asp:Panel ID="Panel1" runat="server" >
                            <asp:Label ID="Label2" runat="server" style="font-weight: 700;text-align:center; font-size: xx-large; text-decoration: underline;" Text="Check Out" Font-Bold="True" Font-Names="Impact" Font-Overline="True"></asp:Label>
                            <br />
                            <br />
                            <asp:Wizard ID="Wizard1" align="center" runat="server" ActiveStepIndex="4" BackColor="#EFF3FB" BorderColor="#B5C7DE" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" style="font-size: 1em" OnActiveStepChanged="Wizard1_ActiveStepChanged" OnFinishButtonClick="Wizard1_FinishButtonClick">
                                <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" BorderWidth="2px" Font-Bold="True" Font-Size="0.9em" ForeColor="White" HorizontalAlign="Center" />
                                <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
                                <SideBarButtonStyle BackColor="#507CD1" Font-Names="Verdana" ForeColor="White" />
                                <SideBarStyle BackColor="#507CD1" Font-Size="0.9em" VerticalAlign="Top" />
                                <StepStyle Font-Size="0.8em" ForeColor="#333333" />
                                <WizardSteps>
                                    <asp:WizardStep runat="server" StepType="Start" title="LogIn">
                                        <uc3:LogIn ID="LogIn1" runat="server" />
                                    </asp:WizardStep>
                                    <asp:WizardStep runat="server" title="Delivery Address">
                                        <table align="center">
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Label ID="Label3" runat="server" style="font-weight: 700; font-size: x-large; text-decoration: underline;" Text="Delivery Adress"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label4" runat="server" style="font-weight: 700" Text="Name :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label5" runat="server" style="font-weight: 700" Text="City :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label6" runat="server" style="font-weight: 700" Text="Area :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtArea" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label7" runat="server" style="font-weight: 700" Text="Adress :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:WizardStep>
                                    <asp:WizardStep runat="server" Title="Confirmation">
                                        <table align="center">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label8" runat="server" style="font-weight: 700; font-size: x-large; text-decoration: underline;" Text="Please Confirmation Your Order"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <uc2:Cart ID="Cart1" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:WizardStep>
                                    <asp:WizardStep runat="server" Title="Payment">
                                        <table align="center">
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Label ID="Label9" runat="server" style="font-weight: 700; font-size: x-large; text-decoration: underline;" Text="Payment"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label10" runat="server" style="font-weight: 700" Text="Payment Type :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlCardType" runat="server" style="font-weight: 700">
                                                        <asp:ListItem Selected="True">Visa Card</asp:ListItem>
                                                        <asp:ListItem>Master Card</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style3">
                                                    <asp:Label ID="Label11" runat="server" style="font-weight: 700" Text="Card Number :"></asp:Label>
                                                </td>
                                                <td class="auto-style3">
                                                    <asp:TextBox ID="txtCardNum" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style3">
                                                    <asp:Label ID="Label12" runat="server" style="font-weight: 700" Text="Expirs :"></asp:Label>
                                                </td>
                                                <td class="auto-style3">
                                                    <asp:TextBox ID="txtMonth" runat="server" Width="34px"></asp:TextBox>
                                                    &nbsp;/<asp:TextBox ID="txtYear" runat="server" Width="53px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style4">
                                                    <asp:Label ID="Label13" runat="server" style="font-weight: 700" Text="Name In Card :"></asp:Label>
                                                </td>
                                                <td class="auto-style4">
                                                    <asp:TextBox ID="txtNameInCard" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:WizardStep>
                                    <asp:WizardStep runat="server" StepType="Finish" Title="Shipment Method">
                                        <table align="center">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label14" runat="server" style="font-weight: 700; font-size: x-large" Text="Shipment Method"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style4">
                                                    <asp:RadioButtonList ID="rblShipMethod" runat="server" Height="165px" style="font-weight: 700; text-align: left;" Width="327px">
                                                        <asp:ListItem Value="representive" Selected="True">&lt;b&gt;representive&lt;/b&gt;Only In Cairo Take One Day</asp:ListItem>
                                                        <asp:ListItem Value="Surface Mail">&lt;b&gt;Surface Mail&lt;/b&gt; From 5 To 10 Days</asp:ListItem>
                                                        <asp:ListItem Value="Registerd Mail">&lt;b&gt;Registerd Mail&lt;/b&gt;(DHL Maximum 3 Days)</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:WizardStep>
                                    <asp:WizardStep runat="server" StepType="Complete" Title="Complete">
                                        <table align="center">
                                            <tr>
                                                <td >
                                                    <asp:Label ID="Label16" runat="server" Font-Bold="True" Font-Names="Impact" Font-Overline="True" Font-Underline="True" style="font-weight: 700; font-size: xx-large" Text="Complete" BackColor="White"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblMsgComplete" runat="server" style="font-weight: 700; font-size: x-large; background-color: #99CCFF;"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:WizardStep>
                                </WizardSteps>
                            </asp:Wizard>
                            <br />
                        </asp:Panel>
                    </asp:Content>


