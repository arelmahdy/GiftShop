<%@ Page Title="" Language="C#" MasterPageFile="~/Member/MemberMaster.master" %>

<script runat="server" >

    protected void Page_Load(object sender, EventArgs e)
    {
        
        
        this.btnexit.Attributes.Add("onclick", "window.close();");
       
    }


    

</script>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <asp:Panel ID="Panel1" runat="server">
                            <asp:Label ID="Label2" runat="server" style="font-weight: 700; font-size: xx-large;" Text="This Is Home Member Page"></asp:Label>
                            <br />
                            <br />
                            <asp:Button ID="btnexit" runat="server" style="font-weight: 700" Text="Exit" Width="119px"   />
                        </asp:Panel>
                    </asp:Content>


