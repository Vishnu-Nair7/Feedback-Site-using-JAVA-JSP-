<%@ page import = "java.sql.*"  %>
<html>
  <head>
     <title>Admin Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
    <style>
       * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins',sans-serif;
        }

        body {
            background: #55efc4;
            overflow: hidden;
        }
        
        .container {
            max-width: 440px;
            padding: 0 20px;
            margin: 170px auto;
        }
        
        .wrapper {
            width: 100%;
            background: #fff;
            border-radius: 5px;
            box-shadow: 0px 4px 10px 1px rgba(0,0,0,0.1);
        }

        .wrapper .title {
            height: 90px;
            background: #16a085;
            border-radius: 5px 5px 0 0;
            color: #fff;
            font-size: 30px;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .wrapper form {
            padding: 30px 25px 25px 25px;
        }

        .wrapper form .row {
            height: 45px;
            margin-bottom: 15px;
            position: relative;
        }

        .wrapper form .row input {
            height: 100%;
            width: 100%;
            outline: none;
            padding-left: 60px;
            border-radius: 5px;
            border: 1px solid lightgrey;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        form .row input:focus {
            border-color: #16a085;
            box-shadow: inset 0px 0px 2px 2px rgba(26,188,156,0.25);
        }
            
        form .row input::placeholder {
            color: #999;
        }
            
        .wrapper form .row i {
            position: absolute;
            width: 47px;
            height: 100%;
            color: #fff;
            font-size: 18px;
            background: #16a085;
            border: 1px solid #16a085;
            border-radius: 5px 0 0 5px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

            
        .wrapper form .button input {
            color: #fff;
            font-size: 20px;
            font-weight: 500;
            padding-left: 0px;
            background: #16a085;
            border: 1px solid #16a085;
            cursor: pointer;
        }
            
        form .button input:hover {
            background: #12876f;
        }

        .wrapper form .home-link {
                text-align: left;
                margin-top: 20px;
                font-size: 17px;
            }
            .wrapper form .home-link a {
                color: #0984e3;
                text-decoration: none;
                font-size: 20px;
            }

            form .home-link a:hover {
                text-decoration: underline;
            }
    </style>
</head>
  <body>
    <div class="container">
      <div class="wrapper">
        <div class="title"><span>Admin Login</span></div>
        <form method="post">
          <div class="row">
            <i class="fas fa-user"></i>
            <input type="text" name="username" placeholder="Username" required autocomplete="off">
          </div>
          <div class="row">
            <i class="fas fa-lock"></i>
            <input type="password" name="password" placeholder="Password" required autocomplete="off">
          </div>
          <div class="row button">
            <input type="submit" name="btnLogin" value="Login">
          </div>
          <div class="home-link"><a href="index.jsp">Home</a></div>
        </form>

        <%
          if (request.getParameter("btnLogin") != null)
          {
           String username = request.getParameter("username");
           username = username.trim();
           String password = request.getParameter("password");
           password = password.trim();

           try {
              DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                              
              String url = "jdbc:mysql://localhost:3306/database_name";
              Connection con = DriverManager.getConnection(url, mysql_username, mysql_password);

              String check = "select * from table_name where username=? and password=?";
              PreparedStatement p = con.prepareStatement(check);
              p.setString(1, username);
              p.setString(2, password);
              ResultSet rs = p.executeQuery();
              
              if(rs.next())
              {
                session.setAttribute("username", username);
                response.sendRedirect("view.jsp");
              }
              else {
                  %>
                  <script>
                      let errAlert = "No such admin with these credentials";
                      alert(errAlert);
                  </script>
                  <%
              }
           } 
           catch (SQLException e) {
              %>
                          <script>
                              let edAlert = "Issue: " + "<%= e %>";
                              alert(eAlert);
                          </script>
              <%
            }
          }
        %>


      </div>
    </div>

  </body>
</html>
