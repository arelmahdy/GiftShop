<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>

<script runat="server">

    protected void btnunsubscribe_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(@"Data Source=.;AttachDbFilename=|DataDirectory|\Company.mdf;Initial Catalog=company;Integrated Security=True");
        SqlCommand cmdselect = new SqlCommand();
        SqlCommand cmdDel = new SqlCommand();
        SqlDataReader  reader;
        
        cmdDel.Connection = con;
        cmdselect.Connection = con;
        
        cmdselect.CommandText = string.Format("Select * From member Where username='{0}' and password = '{1}'",txtusername.Text,txtpassword.Text);
        cmdDel.CommandText = string.Format("Delete From member Where username = '{0}'",txtusername.Text);

        con.Open();
        reader = cmdselect.ExecuteReader();
        
        if (reader.Read()==true)
        {
            reader.Close();
            cmdDel.ExecuteNonQuery();
            unsubscribetable.Visible = false;
            Response.Write("<div align = 'Center'> <font size='7' color='blue' >UnSubscribed</font></div>");
        }
        else
        {
            lblMsg.Text = "UserName/Password Incorrect.";
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
    </style>
</head>
<body style="background-color: #000066">
    <form id="form1" runat="server">
    <div>
    
        <table align="center" id="unsubscribetable" runat="server" style="margin-top:60px;">
            <tr>
                <td colspan="4" style="text-align: center">
                    <asp:Label ID="Label1" runat="server" style="font-weight: 700; font-size: xx-large" Text="Unsubscribe Form" CssClass="auto-style1"></asp:Label>
                    <br />
                    <br />
                    <br />
                </td>
            </tr>
            <tr>
                <td colspan="4" style="text-align: center">
                    <asp:Label ID="Label2" runat="server" style="font-weight: 700; font-size: large; color: #00CC00" Text="Enter UserName/ Password  And Press The Unsubscribe Button"></asp:Label>
                </td>
            </tr>
            <tr>
                <td rowspan="4">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/851fab7a.png" />
                </td>
                <td>
                    <asp:Label ID="Label3" runat="server" style="font-weight: 700; font-size: x-large" Text="UserName :" CssClass="auto-style1"></asp:Label>
                    &nbsp;<asp:TextBox ID="txtusername" runat="server" style="font-weight: 700; font-size: large; background-color: #CCCCFF;" Width="322px" CssClass="st"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtusername" ErrorMessage="*" style="font-weight: 700; font-size: large; color: #FF0000"></asp:RequiredFieldValidator>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label4" runat="server" style="font-weight: 700; font-size: x-large" Text="Password :" CssClass="auto-style1"></asp:Label>
&nbsp; &nbsp;<asp:TextBox ID="txtpassword" runat="server" style="font-weight: 700; font-size: large; background-color: #CCCCFF;" TextMode="Password" Width="322px" CssClass="st"></asp:TextBox>
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
                    <asp:Button ID="btnunsubscribe" runat="server" style="font-weight: 700; padding:10px 5px; font-size: large; color: #FFFFFF; background-color: #CCCCFF;" Text="UnSubscribe" OnClick="btnunsubscribe_Click" CssClass="st" />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
