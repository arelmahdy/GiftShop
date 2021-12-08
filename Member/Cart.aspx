<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="~/Member/MemberMaster.master" %>

<%@ Register src="Cart.ascx" tagname="Cart" tagprefix="uc1" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <asp:Panel ID="Panel1" runat="server">
                            <asp:Label ID="Label2" runat="server" style="font-weight: 700; font-size: xx-large;" Text="Shopping Cart" Font-Overline="True" Font-Underline="True"></asp:Label>
                            <br />
                            <br />
                            <uc1:Cart ID="Cart2" runat="server" />
                            <br />
                        </asp:Panel>
                    </asp:Content>


