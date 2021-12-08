<%@ Page Language="C#" %>
<%@ Import Namespace="System.Net.Mail" %>
<!DOCTYPE html>

<script runat="server">

    protected void BtnFollowing_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(@"Data Source=.;AttachDbFilename=|DataDirectory|\Company.mdf;Initial Catalog=company;Integrated Security=True");
        SqlCommand cmd = new SqlCommand( "Select * From member where username = '" + txtusername.Text + "'",con);
        SqlDataReader reader;

        con.Open();

        reader = cmd.ExecuteReader();
        if (reader.Read())
        {
            ViewState["user"] = txtusername.Text;
            ViewState["question"] = reader["question"].ToString();
            ViewState["answer"] = reader["answer"].ToString();
            ViewState["pass"] = reader["password"].ToString();
            ViewState["email"] = reader["email"].ToString();

            txtuser.Text = txtusername.Text;
            txtQuestion.Text = ViewState["question"].ToString();

            MultiView1.ActiveViewIndex = 1; 
            
        }
        else
        {
            lblMsg1.Text = "User Incorrect";
            con.Close();
        }

  
        
    }

    protected void BtnFollowing1_Click(object sender, EventArgs e)
    {
        if (ViewState["answer"].ToString().ToLower()==txtAnswer.Text)
        {
            MultiView1.ActiveViewIndex = 2;
            
        }
        else
        {
            lblMsg3.Text = "Incorrect Answer";
        }
    }

    protected void BtnSave_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(@"Data Source=.;AttachDbFilename=|DataDirectory|\Company.mdf;Initial Catalog=company;Integrated Security=True");
        SqlCommand cmd = new SqlCommand(string.Format("update member set password='{0}'Where username='{1}'",txtpassword.Text , ViewState["user"].ToString()),con);

        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        lblTitle.Visible = false;
        MultiView1.ActiveViewIndex = -1;
        Response.Write("<font size=7 color=green>Your Password Is Changed</font>");
    }

    protected void LBtnSendPass0_Click(object sender, EventArgs e)
    {
        SmtpClient client = new SmtpClient("Localhost", 8080);
        try
        {
            
            client.Send("Company@exam.com",ViewState["email"].ToString(),"Welcomme To Company <br /> Password Recovery","Your Password Is : <br /> "+ ViewState["pass"].ToString());
            MultiView1.ActiveViewIndex = -1;
            Response.Write("<font size=7 color=green>Your Password Is Send</font>");

            
        }
            
        catch (Exception ex)
        {
            lblMsg3.Text = ex.Message; 
        } 
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
        .auto-style2 {
            width: 8px;
        }
        .auto-style3 {
            width: 268435456px;
        }
        .auto-style4 {
            text-align: center;
            height: 45px;
        }
        .auto-style5 {
            width: 268435456px;
            height: 45px;
        }
        .auto-style6 {
            text-align: center;
            height: 62px;
        }
        .auto-style7 {
            width: 268435456px;
            height: 62px;
        }
        .auto-style {
            text-align: left;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center; font-weight: 700; font-size: x-large">
    
        <asp:Label ID="lblTitle" runat="server" style="text-decoration: underline; font-size: larger" Text="Password Recovery Form"></asp:Label>

        <br />

        <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
          
            <asp:View ID="View1" runat="server">
                <table align="center">
                    <tr>
                        <td rowspan="3">
                            <asp:Image ID="Image1" runat="server" Height="170px" ImageUrl="~/Images/Office-Customer-Male-Light-icon1.png" Width="187px" />
                        </td>
                        <td colspan="3">
                            <asp:Label ID="Label1" runat="server" style="font-size: x-large; color: #33CC33" Text="Enter Your UserName AndPress The Following Button"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="UserName :"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtusername" runat="server" style="font-size: x-large; margin-left: 0px" Width="335px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtusername" ErrorMessage="?" style="color: #FF0000"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <asp:Label ID="lblMsg1" runat="server" style="color: #FF0000"></asp:Label>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <asp:Button ID="BtnFollowing" runat="server" style="font-size: x-large; font-weight: 700" Text="Following" OnClick="BtnFollowing_Click" />
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </asp:View>
            <asp:View ID="View2" runat="server">
                <table align="center" style="width: 1063px">
                    <tr>
                        <td class="auto-style2" rowspan="5">
                            <asp:Image ID="Image4" runat="server" Height="217px" ImageUrl="~/Images/images.png" Width="224px" />
                        </td>
                        <td class="auto-style1" colspan="3">
                            <asp:Label ID="Label11" runat="server" style="font-size: x-large; color: #33CC33" Text="Answer The Question For Change Password Or "></asp:Label>
                            <asp:LinkButton ID="LBtnSendPass0" runat="server" OnClick="LBtnSendPass0_Click" CausesValidation="False">Click Here</asp:LinkButton>
                            &nbsp;<asp:Label ID="Label12" runat="server" style="font-size: x-large; color: #33CC33" Text="For Send Your Password To Your Eamil"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <asp:Label ID="Label13" runat="server" Text="UserName :"></asp:Label>
                        </td>
                        <td class="auto-style1">
                            <asp:TextBox ID="txtuser" runat="server" BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" style="font-size: x-large; margin-left: 0px" Width="405px" ReadOnly="True"></asp:TextBox>
                        </td>
                        <td class="auto-style3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style4">
                            <asp:Label ID="Label14" runat="server" Text="Your Question :"></asp:Label>
                        </td>
                        <td class="auto-style4">
                            <asp:TextBox ID="txtQuestion" runat="server" BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" style="font-size: x-large; margin-left: 0px" Width="405px" ReadOnly="True"></asp:TextBox>
                        </td>
                        <td class="auto-style5"></td>
                    </tr>
                    <tr>
                        <td class="auto-style6">
                            <asp:Label ID="Label15" runat="server" Text="Answer :"></asp:Label>
                        </td>
                        <td class="auto-style6">
                            <asp:TextBox ID="txtAnswer" runat="server" style="font-size: x-large; margin-left: 0px" TextMode="MultiLine" Width="408px"></asp:TextBox>
                        </td>
                        <td class="auto-style7">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtAnswer" ErrorMessage="?" style="color: #FF0000"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">&nbsp;</td>
                        <td class="auto-style1">
                            <asp:Label ID="lblMsg3" runat="server" style="color: #FF0000"></asp:Label>
                        </td>
                        <td class="auto-style3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style2">&nbsp;</td>
                        <td class="auto-style" colspan="3">
                            <asp:Button ID="BtnFollowing1" runat="server" style="font-size: x-large; font-weight: 700" Text="Following" OnClick="BtnFollowing1_Click" />
                        </td>
                    </tr>
                </table>
            </asp:View>
            <asp:View ID="View3" runat="server">
                <table align="center">
                    <tr>
                        <td rowspan="3">
                            <asp:Image ID="Image3" runat="server" Height="217px" ImageUrl="~/Images/Password.jpg" Width="224px" />
                        </td>
                        <td colspan="3">
                            <asp:Label ID="Label8" runat="server" style="font-size: x-large; color: #33CC33" Text="Please Change Your Password"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label9" runat="server" Text="Password :"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtpassword" runat="server" style="font-size: x-large; margin-left: 0px" Width="335px" TextMode="Password"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtpassword" ErrorMessage="?" style="color: #FF0000"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label10" runat="server" Text="Confirm Password :"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" style="font-size: x-large; margin-left: 0px" Width="335px" TextMode="Password"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtConfirmPassword" ControlToValidate="txtpassword" ErrorMessage="*" style="color: #FF0000"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td colspan="2" style="text-align: left">
                            <asp:Button ID="BtnSave" runat="server" style="font-size: x-large; font-weight: 700" Text="Save" OnClick="BtnSave_Click" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </asp:View>
        </asp:MultiView>
    
    </div>
    </form>
</body>
</html>
