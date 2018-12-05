<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserView_Return.aspx.cs" Inherits="LogIn" %>

<!DOCTYPE html>



<html>
    <head>

    </head>
   <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link rel="stylesheet" href="UserView_Return.css">
  
    <title>TabletMonitor | ReturnDevice</title>
    <body>
      
        <form id="form1" runat="server">
      
  <!-- Menu  -->
  <div  class="container" >
        
   <nav class="navbar navbar-expand-lg navbar-light bg-info ">

    <a class="navbar-brand" href="./LogIn.aspx"><img src="logo.jpg" alt="Tablet Monitor logo" width="27%" height="27%" class="logo"a><asp:Label ID="LblWelcomeMessage" runat="server"></asp:Label>
       </a>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent" >
      <ul class="navbar-nav ml-auto">
        <li >
          <a class="nav-link" href="./LogIn.aspx">|Log Out|</a>
        </li>
  
      </ul>
    
    </div>
    </nav>
    
</div>

<!-- End menu -->


            <p>
                &nbsp;</p>
            <p>

    <a class="navbar-brand" href="./LogIn.aspx"></a>
                <asp:Label ID="LblCheckedOutDevice" runat="server"></asp:Label>
                

            </p>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Return Device" />
        </form>


    </body>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</html>