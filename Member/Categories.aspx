<%@ Page Title="" Language="C#" MasterPageFile="~/Member/MemberMaster.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">

                        <asp:Panel ID="Panel1" runat="server">
                            <asp:Label ID="Label2" runat="server" style="font-weight: 700; font-size: xx-large;" Text="Categories" Font-Names="Trebuchet MS" Font-Overline="True" Font-Underline="True"></asp:Label>
                            <br />
                            <br />
                            <asp:DataList ID="DataList1"  runat="server" DataKeyField="catno" DataSourceID="SqlDataSource1" align="center" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="0" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" GridLines="Horizontal" RepeatColumns="3" RepeatDirection="Horizontal" Width="750px" style="border-spacing:4px;border-collapse:separate;" >
                                <AlternatingItemStyle BackColor="#F7F7F7" />
                                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <ItemStyle BackColor="#E7E7FF" ForeColor="#4A3C8C"/>
                                <ItemTemplate >
                                    <table align="center" style="border:1px solid black; width:100%;">
                                        <tr >
                                            <td >
                                                <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Names="Impact" Font-Overline="True" style="font-weight: 700; font-size: x-large" Text="Category Name"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblCatName" runat="server" style="font-weight: 700; font-size: x-large" Text='<%# Eval("catname") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                 <a href="CatPro.aspx?catno=<%# Eval("catno")%>&catname=<%# Eval("catname")%> ">
                                                <asp:Image ID="imgCat" runat="server" AlternateText='<%# Eval("catname") %>' Height="114px" ImageUrl='<%# "..\\Admin\\CatImage\\" + Eval("catno") + ".jpg" %>' Width="149px" />
                                                 </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Names="Impact" Font-Overline="True" style="font-weight: 700; font-size: x-large" Text="Description"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="direction: ltr">
                                                <asp:Label ID="lblCatDesc" runat="server" style="font-weight: 700; font-size: x-large" Text='<%# Eval("description") %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                </ItemTemplate>
                                <SelectedItemStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            </asp:DataList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sqlexp %>" SelectCommand="SELECT [catno], [catname], [description] FROM [category]"></asp:SqlDataSource>
                        </asp:Panel>
                    </asp:Content>


