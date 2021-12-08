<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">



    protected void btnlogintoedit_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(@"Data Source=.;AttachDbFilename=|DataDirectory|\Company.mdf;Initial Catalog=company;Integrated Security=True");
        SqlCommand cmd = new SqlCommand();
        SqlDataReader reader;

        cmd.Connection = con;
        cmd.CommandText =string.Format("Select * From member Where username='{0}' and password='{1}'" ,txtusername.Text,txtpassword.Text);
        con.Open();
        reader = cmd.ExecuteReader();

        if (reader.Read()==true)
        {
            HttpCookie cookie = new HttpCookie("edit");
            cookie.Values.Add("user",txtusername.Text);
            Response.Cookies.Add(cookie);
            con.Close(); 
            Response.Redirect("Edit.aspx");    
            
        }
        else
        {
            lblMsg.Text = "UserName/Password IS Invalid";
            con.Close();
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
                   .st{
            border-radius:10px;
            padding:4px;
            border-style:none;
            outline:none;
            text-align:center;
        }
        .auto-style1 {
            color: #FFFFFF;
        }
        .auto-style2 {
            border-radius: 10px;
            padding: 4px;
            border-style: none;
            outline: none;
            text-align: center;
            background-color: #CCCCFF;
        }
    </style>
</head>
<body style="background-color: #000066">
    <form id="form1" runat="server">
    <div>
    
        <table align="center" id="unsubscribetable" runat="server" style="margin-top:60px;">
            <tr>
                <td colspan="4" style="text-align: center">
                    <asp:Label ID="Label1" runat="server" style="font-weight: 700; font-size: xx-large" Text="Log In To Edit" CssClass="auto-style1"></asp:Label>
                    <br />
                    <br />
                    <br />
                </td>
            </tr>
            <tr>
                <td colspan="4" style="text-align: center">
                    <asp:Label ID="Label2" runat="server" style="font-weight: 700; font-size: large; color: #00CC00" Text="Enter UserName/ Password  And Press The Update Button"></asp:Label>
                </td>
            </tr>
            <tr>
                <td rowspan="4">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/unnamed.png" />
                </td>
                <td>
                    <asp:Label ID="Label3" runat="server" style="font-weight: 700; font-size: x-large" Text="UserName :" CssClass="auto-style1"></asp:Label>
                    <asp:TextBox ID="txtusername" runat="server" style="font-weight: 700; font-size: large" Width="322px" CssClass="auto-style2"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtusername" ErrorMessage="*" style="font-weight: 700; font-size: large; color: #FF0000"></asp:RequiredFieldValidator>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label4" runat="server" style="font-weight: 700; font-size: x-large" Text="Password :" CssClass="auto-style1"></asp:Label>
&nbsp;&nbsp;<asp:TextBox ID="txtpassword" runat="server" style="font-weight: 700; font-size: large" TextMode="Password" Width="322px" CssClass="auto-style2"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtpassword" ErrorMessage="*" style="font-weight: 700; font-size: large; color: #FF0000"></asp:RequiredFieldValidator>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <asp:Label ID="lblMsg" runat="server" style="font-weight: 700; font-size: x-large; text-align: center; color: #FF0000"></asp:Label>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnlogintoedit" runat="server" style="font-weight: 700; padding:10px 10px; font-size: large; color: #FFFFFF; background-color: #CCCCFF;" Text="Log In To Edit" OnClick="btnlogintoedit_Click" CssClass="st"  />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
