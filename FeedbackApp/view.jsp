<%@ page import = "java.sql.*"  %>
<html>
  <head>
    <title>Admin Home Page</title>
    <style>
      body {
            background: #87f3d4;
            overflow: hidden;
        }

      .table table {
        background-color: rgb(35, 155, 109);
        border: 1px, solid, black;
        table-layout: fixed;
        width: 70%;
        text-align: center;
        text-justify: auto;
      }

      .name-heading {
        width: 200px;
        font-family: "Rockwell";
        font-size: 22px;
      }
      .email-heading {
        width: 300px;
        font-family: "Rockwell";
        font-size: 22px;
      }
      .fb-heading {
        width: 500px;
        font-family: "Rockwell";
        font-size: 22px;
      }
      .rating-heading {
        width: 100px;
        font-family: "Rockwell";
        font-size: 22px;
      }
      td {
        background: #55efc4;
        width: 100px;
        height: fit-content;
        font-family: "Calibri";
        font-size: 18px;
      }

      .title {
        text-decoration: underline;
        text-align: center;
      }

      .title-container {
        width: 300px;
        height: 70px;
        font-size: 25px;
        background-color: rgb(6, 78, 50);
        font-family: "Agency FB";
        color: azure;
        border-radius: 6px;
        text-align: center;
        margin-left: 530px;
      }

      .container {
        padding-bottom: 10px;
        background-color: azure;
        border-radius: 10px;
        width: 90%;
      }
      .deltile {
        font-family: "Calibri";
        font-size: 30px;
      }
      .container .delInput input {
        margin-top: 0;
        font-family: "Calibri";
        font-size: 25px;
      }

      #logout {
        position: absolute;
        margin-left: 1250px;
        text-align: center;
        font-family: 'Times New Roman';
        font-size: 25px;
      }

      #email {
        width: 400px;
      }

    </style>
  </head>
  <body>
    <form action="">
      <input type="submit" id="logout" onclick="return confirm('Are you sure you want to logout?');" name="btnLogout" value="Logout">
    </form>
    
    <div class="title-container">
      <div class="title">
        <h1>Admin View</h1>
      </div>
    </div>


    <center>
      <div class="container">
        <div class="deltile">
          <h3>Delete Feedback Record</h3>
        </div>
        <form method="post">
          <div class="delInput">
            <input type="text" name="name" placeholder="Enter Name" required autocomplete="off"> 
            <input type="text" id="email" name="email" placeholder="Enter Email" required autocomplete="off">
            <input type="submit" name="btnDel" onclick="return confirm('Are you sure you want to delete this feedback ?');" value="Delete Feedback"/>
          </div>
        </form>
        
        <% 
          String username = (String)session.getAttribute("username");
          if(username == null)
          {
              response.sendRedirect("admin.jsp");
              session.invalidate();
          }
        %>

    </center>
    
      <div class="recordTile">
        <h1>Feedbacks:</h1>
      </div>
      </div>
     <center>
      <div class="table">
        <table border="3">
            <tr>
              <th class="name-heading">Name</th>
              <th class="email-heading">Email</th>
              <th class="fb-heading">Feedback</th>
              <th class="rating-heading">Rating</th>
            </tr>
            <% 
                try {
                        DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                        String url = "jdbc:mysql://localhost:3306/kc_project_feedback";
                        Connection con = DriverManager.getConnection(url, "root", "abc456");
            
                        String sql = "select * from feedback_records";
                        PreparedStatement pst =  con.prepareStatement(sql);
                        ResultSet rs =  pst.executeQuery();
                        while(rs.next()){
            %>
                            
                            <tr>
                                <td><%= rs.getString(1) %></td>
                                <td><%= rs.getString(2) %></td>
                                <td><%= rs.getString(3) %></td>
                                <td><%= rs.getString(4) %></td>
                            </tr>
            
            <%
                        
                        }
                        con.close();
                    } catch (SQLException e) {
                            out.println("issue "+ e);
                    }

                    if (request.getParameter("btnLogout") != null)
                    {
                      response.sendRedirect("admin.jsp");
                      session.invalidate();
                    }

                    if (request.getParameter("btnDel") != null)
                    {
                      String name = request.getParameter("name");
                      name = name.trim(); 
                      String email = request.getParameter("email");
                      email = email.trim();

                      if(name.matches("[A-Za-z ]+") && email.matches("^[a-zA-Z0-9_!#$%&'*+/=?``{|}~^.-]+@[a-zA-Z0-9.-]+$"))
                      {
                        try {

                          DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                            
                          String url = "jdbc:mysql://localhost:3306/database_name";
                          Connection con = DriverManager.getConnection(url, mysql_username, mysql_password);
  
                          String check = "select * from table_name where name=? and email=?";
                          PreparedStatement p = con.prepareStatement(check);
                          p.setString(1, name);
                          p.setString(2, email);
                          ResultSet rs = p.executeQuery();
                          
                          if(rs.next())
                          {
                              String sql = "delete from table_name where name=? and email=?";
                              PreparedStatement pst = con.prepareStatement(sql);
  
                              pst.setString(1, name);
                              pst.setString(2, email);
                              pst.executeUpdate();
                              con.close();
                              %>
                              <script>
                                  let delAlert = "Record Successfully Deleted";
                                  alert(delAlert);
                              </script>
                              <%
                              response.sendRedirect("view.jsp");
                          }
                          else {
                              %>
                              <script>
                                  let errAlert = "No record under these credentials";
                                  alert(errAlert);
                              </script>
                              <%
                          }
                        } catch (SQLException e) {
                          %>
                                      <script>
                                          let edAlert = "Issue: " + "<%= e %>";
                                          alert(eAlert);
                                      </script>
                          <%
                        } 
                      } else {
                        %>
                        <script>
                            let errorAlert = "Invalid inputs";
                            alert(errorAlert);
                        </script>
                        <%
                      }
                    }
            %>
            </table>
      </div>
     </center>



  </body>
</html>
