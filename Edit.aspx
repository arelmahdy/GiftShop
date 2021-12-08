<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void btnsavechanges_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(@"Data Source=.;AttachDbFilename=|DataDirectory|\Company.mdf;Initial Catalog=company;Integrated Security=True");
        SqlCommand cmd = new SqlCommand(string.Format("update member set fullname='{0}',gender='{1}',country='{2}',phone='{3}',email='{4}',question='{5}',answer='{6}',password='{7}' Where username='{8}'",txtFullName.Text,rbtGender.SelectedValue,ddCountry.SelectedValue,txtPhone.Text,txtEmail.Text,txtQuestion.Text,txtAnswer.Text,txtPassword.Text,txtUserName.Text),con);

        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        tbledit.Visible = false;
        Response.Write("<div align = 'Center'> <font size='7' color='blue' >All Your Data Is Saved</font></div>");
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {


            string strUser = "";
            if (Request.Cookies["edit"] != null)
            {
                strUser = Request.Cookies["edit"]["user"].ToString();

                SqlConnection con = new SqlConnection(@"Data Source=.;Initial Catalog=company;Integrated Security=True");
                SqlCommand cmd = new SqlCommand(string.Format("Select * From member Where username='{0}'", strUser), con);

                SqlDataReader reader;
                con.Open();
                reader = cmd.ExecuteReader();
                if (reader.Read() == true)
                {
                    txtFullName.Text = reader[0].ToString();
                    rbtGender.SelectedValue = reader[1].ToString();
                    ddCountry.SelectedValue = reader[2].ToString();
                    txtPhone.Text = reader[3].ToString();
                    txtEmail.Text = reader[4].ToString();
                    txtQuestion.Text = reader[5].ToString();
                    txtAnswer.Text = reader[6].ToString();
                    txtUserName.Text = strUser;
                }
                else
                {
                    Response.Redirect("Update.aspx");
                    con.Close();
                }

            }
        }
    }      
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">

        .auto-style5 {
            height: 35px;
        }
        .auto-style7 {
            color: #00CCFF;
        }
        .auto-style6 {
            width: 5px;
            height: 35px;
        }
        .auto-style2 {
            width: 5px;
            }
        .auto-style8 {
            color: #FFFFFF;
        }
        .auto-style1 {
            height: 32px;
        }
        .auto-style3 {
            height: 32px;
            width: 5px;
        }
         .st{
            border-radius:10px;
            padding:4px;
            border-style:none;
            outline:none;
            text-align:center;
        }
        </style>
</head>
<body style="background-color:#666699; ">
    <form id="form1" runat="server">
    <div>
    
        <table align="center" runat="server" id="tbledit" style="border-radius:20px; padding:10px; margin-top:50px; background-color: #6700CE;">
            <tr>
                <td colspan="3" style="text-align: center">
                    <asp:Label ID="Label1" runat="server" Font-Bold="False" Font-Names="Impact" Font-Overline="True" Font-Size="XX-Large" Text="Edit Profile Form" style="color: #00CCFF"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style5">
                    <asp:Label ID="Label2" runat="server" style="font-weight: 700; font-size: large" Text="Full Name :" CssClass="auto-style7"></asp:Label>
                </td>
                <td class="auto-style6">
                    <asp:TextBox ID="txtFullName" runat="server" style="font-weight: 700; font-size: large" Width="268px" CssClass="st"></asp:TextBox>
                </td>
                <td class="auto-style5">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFullName" ErrorMessage="!" style="font-weight: 700; color: #FF0000"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label3" runat="server" style="font-weight: 700; font-size: large" Text="Gender :" CssClass="auto-style7"></asp:Label>
                </td>
                <td style="text-align: center" class="auto-style2" >
                    <asp:RadioButtonList ID="rbtGender" runat="server" RepeatDirection="Horizontal" style="font-weight: 700; font-size: large; color: #00CCFF;"  Width="116px" CssClass="st">
                        <asp:ListItem Selected="True" Value="M">Male</asp:ListItem>
                        <asp:ListItem Value="F">Female</asp:ListItem>
                    </asp:RadioButtonList>
                    </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label4" runat="server" style="font-weight: 700; font-size: large" Text="Country :" CssClass="auto-style7"></asp:Label>
                </td>
                <td class="auto-style2">
                    <asp:DropDownList ID="ddCountry" runat="server" style="font-weight: 700; font-size: large" Width="273px" CssClass="st">
                        <asp:ListItem Selected="True">Cairo</asp:ListItem>
                        <asp:ListItem>Giza</asp:ListItem>
                        <asp:ListItem>Tanta</asp:ListItem>
                        <asp:ListItem>Luxor</asp:ListItem>
                        <asp:ListItem>Aswan</asp:ListItem>
                        <asp:ListItem>Alex</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td style="color: #FF0000">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddCountry" ErrorMessage="!" style="font-weight: 700; color: #FF0000"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label5" runat="server" style="font-weight: 700; font-size: large" Text="Phone :" CssClass="auto-style7"></asp:Label>
                </td>
                <td class="auto-style2">
                    <asp:TextBox ID="txtPhone" runat="server" style="font-weight: 700; font-size: large" Width="268px" CssClass="st"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtPhone" ErrorMessage="!" style="font-weight: 700; color: #FF0000"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label6" runat="server" style="font-weight: 700; font-size: large" Text="Email :" CssClass="auto-style7"></asp:Label>
                </td>
                <td style="text-align: center; color: #000066; direction: ltr; font-weight: 700" class="auto-style2" >
                    
                   
                    <span class="auto-style8">exampleemail@host.com</span><br />
                    
                   
                    <asp:TextBox ID="txtEmail" runat="server" style="font-weight: 700; font-size: large" Width="268px" CssClass="st"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail" ErrorMessage="!" style="font-weight: 700; color: #FF0000"></asp:RequiredFieldValidator>
                    &nbsp;
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid Email" style="font-weight: 700; font-size: medium; color: #FF0000" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label7" runat="server" style="font-weight: 700; font-size: large" Text="Question :" CssClass="auto-style7"></asp:Label>
                </td>
                <td class="auto-style2">
                    <asp:TextBox ID="txtQuestion" runat="server" style="font-weight: 700; font-size: large" Width="268px" CssClass="st"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtQuestion" ErrorMessage="!" style="font-weight: 700; color: #FF0000"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label8" runat="server" style="font-weight: 700; font-size: large" Text="Answer :" CssClass="auto-style7"></asp:Label>
                </td>
                <td class="auto-style2">
                    <asp:TextBox ID="txtAnswer" runat="server" style="font-weight: 700; font-size: large" TextMode="MultiLine" Width="268px" CssClass="st"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtAnswer" ErrorMessage="!" style="font-weight: 700; color: #FF0000"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label9" runat="server" style="font-weight: 700; font-size: large" Text="User Name :" CssClass="auto-style7"></asp:Label>
                </td>
                <td class="auto-style2">
                    <asp:TextBox ID="txtUserName" runat="server" style="font-weight: 700; font-size: large" Width="268px" ReadOnly="True" CssClass="st"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtUserName" ErrorMessage="!" style="font-weight: 700; color: #FF0000"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label10" runat="server" style="font-weight: 700; font-size: large" Text="Password :" CssClass="auto-style7"></asp:Label>
                </td>
                <td class="auto-style2">
                    <asp:TextBox ID="txtPassword" runat="server" style="font-weight: 700; font-size: large" TextMode="Password" Width="268px" CssClass="st"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtPassword" ErrorMessage="!" style="font-weight: 700; color: #FF0000"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">
                    <asp:Label ID="Label11" runat="server" style="font-weight: 700; font-size: large" Text="Confirm Password :" CssClass="auto-style7"></asp:Label>
                </td>
                <td class="auto-style3">
                    <asp:TextBox ID="txtConfirmPassword" runat="server" style="font-weight: 700; font-size: large" TextMode="Password" Width="268px" CssClass="st"></asp:TextBox>
                </td>
                <td class="auto-style1">
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtConfirmPassword" ControlToValidate="txtPassword" ErrorMessage="!" style="font-weight: 700; font-size: medium; color: #FF0000"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center; color: #FF0000">
                    <asp:Label ID="lblMsg" runat="server" style="font-size: large; font-weight: 700"></asp:Label>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnsavechanges" runat="server" style="font-weight: 700; padding:10px 5px; font-size: large" Text="Save Changes" Width="158px"  BackColor="#003399" ForeColor="White" OnClick="btnsavechanges_Click" CssClass="st" />
                </td>
                <td class="auto-style2" style="direction: ltr">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
