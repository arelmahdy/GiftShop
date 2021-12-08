<html>
<head>
    <style>
        body{font-family:Arial; background-color:#a6c2ff;}
        a{color:blue;text-decoration:none;font:bold;}
        a:hover{color:red;}
        td.menu{background:#cadbff; padding:5px;}

    

        table.nav{
            background:black;
            position:relative;
            font:bold 80% arial;
            top:0px;
            left: -135px;
        }
    </style>
    <script type="text/javascript">
        var i = -135;
        var intHide;
       
        var speed = 2;
        function showmenu(){
            clearInterval(intHide);
            intShow = setInterval("show()",10);
        }
        function hidemenu() {
            clearInterval(intShow);
            intHide = setInterval("hide()", 10);
        }
        function show() {
            if (i < -12) {
                i = i + speed;
                document.getElementById('myMenu').style.left = i;
            }
        }
            function hide() {
                if (i > -135) {
                    i = i - speed;
                    document.getElementById('myMenu').style.left = i;
                }
            }

    </script>
</head>
<body>
<table id="myMenu" class="nav" width="150" onmouseover="showmenu()" onmouseout="hidemenu()">
    <tr><td class="menu"><a href="Index.aspx">Home Page</a></td>
    <td rowspan="6" align="center" bgcolor="#000FF" style="width:20px;">M<br/>E<br/>N<br/>U</td></tr>
    <tr><td class="menu"><a href="Register.aspx">Registeration</a></td></tr>
    <tr><td class="menu"><a href="Unsubscribe.aspx">Unsubscribe</a></td></tr>
    <tr><td class="menu"><a href="Update.aspx">Edit Profile</a></td></tr>
    <tr><td class="menu"><a href="PasswordRecovery.aspx">Password Recovery</a></td></tr>
    <tr><td class="menu"><a href="LogIn.aspx">LogIn</a></td></tr>
</table>
</body>
</html>
