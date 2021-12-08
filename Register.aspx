<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html><script runat="server">



    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (Session["randnus"].ToString() == txtCaptcha.Text)
        {
            if (cbxTerms.Checked==true)
            {
                SqlConnection con = new SqlConnection();
                SqlCommand cmd = new SqlCommand();

                con.ConnectionString = @"Data Source=.;AttachDbFilename=|DataDirectory|\Company.mdf;Initial Catalog=company;Integrated Security=True";
           
                cmd.Connection = con;
                cmd.CommandText = string.Format("insert into member values('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}')",txtFullName.Text,rbtGender.SelectedValue,ddCountry.SelectedValue,txtPhone.Text,txtEmail.Text,txtQuestion.Text,txtAnswer.Text,txtUserName.Text,txtPassword.Text);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    tblregister.Visible = false;
                    Response.Write("<div align = 'Center'> <font size='7' color='#000066' >Your Account Is Created</font></div>");
                }
                catch (SqlException ex)
                {

                    if (ex.Number == 2627)
                    {
                        lblMsg.Text = "Please Change The UserName";
                    }
                    else
                    {
                        lblMsg.Text = "An Error :" + ex.Message;
                    }
                }
            }
            else
            {
                lblMsg.Text = "Agree Terms Of The Company. ";
            }
        }
        else
        {
            lblMsg.Text = "Captcha Image Incorrect.";
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
</script><html xmlns="http://www.w3.org/1999/xhtml"><head runat="server"><title></title><style type="text/css">
        .auto-style1 {
            height: 32px;
        }
        .auto-style2 {
            width: 5px;
                                                                                                text-align: center;
                                                                                            }
        .auto-style3 {
            height: 32px;
            width: 5px;
        }
        .auto-style5 {
            height: 35px;
        }
        .auto-style6 {
            width: 5px;
            height: 35px;
            
        }
        .auto-style7 {
            color: #00CCFF;
        }    
        .auto-style8 {
            color: #FFFFFF;
        }
        #tblregister 
        {
            background-color: #6700CE;

        }
       .st{
            border-radius:10px;
            padding:4px;
            border-style:none;
            outline:none;
            text-align:center;
        }

    </style></head><body style="background-color:#666699; "><form id="form1" runat="server">
    <div>
    
        <table align="center" runat="server" id="tblregister" style="border-radius:20px; padding:10px; margin-top:50px;">
            <tr>
                <td colspan="3" style="text-align: center">
                    <asp:Label ID="Label1" runat="server" Font-Bold="False" Font-Names="Impact" Font-Overline="True" Font-Size="XX-Large" Text="Registration Form" style="color: #00CCFF"></asp:Label>
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
                <td class="auto-style2" >
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
                    <asp:TextBox ID="txtUserName" runat="server" style="font-weight: 700; font-size: large" Width="268px" CssClass="st"></asp:TextBox>
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
                <td>
                    <asp:Label ID="Label12" runat="server" style="font-weight: 700; font-size: large" Text="Captcha Image :" CssClass="auto-style7"></asp:Label>
                </td>
                <td style="text-align: center" class="auto-style2">
                    <asp:Image ID="imgCaptcha" runat="server" Height="46px" Width="153px" ImageUrl="~/CaptchaImage.aspx" CssClass="st" />
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label13" runat="server" style="font-weight: 700; font-size: large" Text="Captcha Text :" CssClass="auto-style7"></asp:Label>
                </td>
                <td class="auto-style2">
                    <asp:TextBox ID="txtCaptcha" runat="server" style="font-weight: 700; font-size: large" Width="268px" CssClass="st"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="!" style="font-weight: 700; color: #FF0000" ControlToValidate="txtCaptcha"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center; color: #FF0000">
                    <asp:Label ID="lblMsg" runat="server" style="font-size: large; font-weight: 700"></asp:Label>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:CheckBox ID="cbxTerms" runat="server" style="font-weight: 700; font-size: large; color: #00CCFF;" Text="I Agree Of The&lt;a href='Terms.html' style=&quot;color:white;&quot;&gt; Terms &lt;/a&gt;Company" />
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnRegister" runat="server" style="font-weight: 700; padding:10px 0px; font-size: large" Text="Register" Width="158px"  OnClick="btnRegister_Click" BackColor="#003399" ForeColor="White" CssClass="st" />
                </td>
                <td class="auto-style2" style="direction: ltr">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
