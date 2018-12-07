<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LogIn.aspx.cs" Inherits="LogIn" %>

<!DOCTYPE html>

  <!-- login  -->

    <html>
        <head>

        </head>
        <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="LogIn.css">
        
        <title>TabletMonitor | LogIn</title>
        <body>

          <!-- Menu  -->

          <!-- Navigation bar for the web starts here  -->
    <div class="container">
        <nav class="navbar navbar-expand-lg navbar-light bg-info">
        <a class="navbar-brand" href="./LogIn.aspx"><img src="logo.jpg" alt="Tablet Monitor logo" width="27%" height="27%" class="logo"a></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
           <ul class="navbar-nav ml-auto">
               <ul class="navbar-nav ml-auto">
         <!--  -->
          <li >
            <a class="nav-link" href="./About.aspx">|About| </a>
          </li>
          <li >
            <a class="nav-link" href="./Contact.aspx">|Contact| </a>
          </li>
          
        </ul>
       </div>

    <div class="collapse navbar-collapse" id="navbarSupportedContent" >
      <ul class="navbar-nav ml-auto">
         <li >
          <a class="nav-link" href="./LogIn.aspx">|Log In| </a>
        </li>
  
      </ul>
      <!--  -->
        
            </ul>
           </div>
      </nav>
    </div>
        
        <!-- login form  -->
       <div class="container">
           <form id="form1" runat="server">
           <h2 class="form-signin-heading">Please Log In</h2>
                <label for="inputUsername" class="sr-only">User name</label>
               <asp:TextBox ID="InputUsername" class="form-control" placeholder="<Employee ID>" runat="server"></asp:TextBox>
               <asp:Button ID="LogInButton" class="btn btn-lg btn-success btn-block" runat="server" OnClick="LogInButton_Click" Text="Log In" />
               <asp:Label ID="ErrorLabel" runat="server" Text="" Visible="false"></asp:Label>
           </form>
          
      </div> <!-- /container -->

 


 

      </body>
      
      <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

  </html>