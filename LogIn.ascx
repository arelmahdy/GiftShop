<%@ Control Language="C#" ClassName="LogIn" %>


<script runat="server">
    protected void Login()
    {
        SqlConnection con = new SqlConnection(@"Data Source=.;AttachDbFilename=|DataDirectory|\Company.mdf;Initial Catalog=company;Integrated Security=True");
        SqlCommand cmd = new SqlCommand(string.Format("select * from member where username= '{0}' and password= '{1}'", txtusername.Text, txtpassword.Text), con);

        SqlDataReader reader;

        con.Open();
        reader = cmd.ExecuteReader();

        if (reader.Read())
        {
            HttpCookie cookie = new HttpCookie("login");
            cookie.Values.Add("user", txtusername.Text);
            cookie.Values.Add("pass", txtpassword.Text);
            if (cbxRememberMe.Checked == true)
            
                cookie.Expires = DateTime.MaxValue;
                Response.Cookies.Add(cookie);
            

            if (txtusername.Text.ToLower() == "admin")
            {
                Response.Redirect("..\\Admin\\Admin.aspx");
            }
            else
            {
                pnllogin.Visible = false;
                lblUser.Text = txtusername.Text;
                pnlWelcome.Visible = true;

            }
        }
        else
        {
            lblMsg.Text = "UserName/Password Is Invalid";

        }

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Request.Cookies["login"]!=null)&&(Request.Cookies["login"]["user"]!=null)&&(Request.Cookies["login"]["pass"]!=null))
        {
            txtusername.Text = Request.Cookies["login"]["user"];
            txtpassword.Text = Request.Cookies["login"]["pass"];
            cbxRememberMe.Checked = true;
             Login();
        }
       
    }

    protected void BtnLogIn_Click(object sender, EventArgs e)
    {
        Login();
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        HttpCookie cookiedelete = new HttpCookie("login");
        cookiedelete.Expires = DateTime.Now.AddDays(-1);

        Response.Cookies.Add(cookiedelete);

        lblUser.Text = "";
        pnllogin.Visible = true;
        pnlWelcome.Visible = false;
    }

    protected void lbtMemberServices_Click(object sender, EventArgs e)
    {
        Response.Redirect("..//Member/Member.aspx");
    }
   
</script>



   

        <asp:Panel ID="pnllogin" runat="server" Width="396px">
            <table>
                <tr>
                    <td colspan="3" style="text-align: center; font-weight: 700; font-size: xx-large;" class="auto-style4">
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Italic="False" Font-Names="Impact" Font-Overline="True" Font-Underline="True" style="font-weight: 700; font-size: xx-large; text-decoration: underline" Text="LogIn Form"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" style="font-weight: 700; font-size: large" Text="User Name :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtusername" runat="server" style="font-weight: 700; font-size: large" Width="233px"></asp:TextBox>
                    </td>
                    <td class="auto-style1">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtusername" ErrorMessage="?" style="font-weight: 700; font-size: large; color: #FF0000"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" style="font-weight: 700; font-size: large" Text="Password :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtpassword" runat="server" style="font-weight: 700; font-size: large" TextMode="Password" Width="232px"></asp:TextBox>
                    </td>
                    <td class="auto-style1">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtpassword" ErrorMessage="?" style="font-weight: 700; font-size: large; color: #FF0000"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: 700; font-size: large" colspan="2">
                        <asp:CheckBox ID="cbxRememberMe" runat="server" Text="Remember Me" />
                    </td>
                    <td class="auto-style1">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center">
                        <asp:Label ID="lblMsg" runat="server" style="font-weight: 700; font-size: large; color: #FF0000"></asp:Label>
                    </td>
             
                </tr>
                <tr>
                   <td colspan="2" style="text-align: center">
                        <asp:Button ID="BtnLogIn" runat="server" style="font-weight: 700; font-size: large" Text="LogIn" OnClick="BtnLogIn_Click" Width="95px" />
                    </td>
                   
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlWelcome" runat="server" Width="392px" Visible="False">
            <table style="width: 397px">
                <tr>
                    <td style="text-align: center">
                        <asp:Label ID="Label4" runat="server" style="font-weight: 700; font-size: xx-large; color: #660066" Text="Welcome Back  :"></asp:Label>
                        <asp:Label ID="lblUser" runat="server" style="font-weight: 700; font-size: xx-large"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center">
                        <asp:LinkButton ID="LinkButton1" runat="server" style="font-weight: 700; font-size: x-large" OnClick="LinkButton1_Click">Sign Out</asp:LinkButton>
                        <br />
                        <asp:LinkButton ID="lbtMemberServices" runat="server"  style="font-weight: 700; font-size: x-large" OnClick="lbtMemberServices_Click">Member Services</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    



    

