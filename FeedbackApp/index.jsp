<%@ page import = "java.sql.*"  %>
<html>
    <head>
        <title>Feedback App by Vishnu</title>
        <style>
            
            
            body {
                background-color: #74b9ff;
                overflow: hidden;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Cambria';
            }

            .container {
                max-width: 440px;
                padding: 0 20px;
                margin: 40px auto;
            }

            .wrapper {
                width: 100%;
                background: #fff;
                border-radius: 5px;
                box-shadow: 0px 4px 10px 1px rgba(0,0,0,0.1);
            }

            .wrapper .title {
                font-family: Cambria;
                height: 90px;
                background: #0984e3;
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
                border-color: #0984e3;
                box-shadow: inset 0px 0px 1px 1px #0984e3;;
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
                background: #0984e3;
                border: 1px solid #0984e3;
                border-radius: 5px 0 0 5px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .container .star-widget input{
                display: none;
            }
                
            .star-widget label{
                font-size: 44px;
                color: #444;
                padding: 10px;
                float: right;
                transition: all 0.2s ease;
                justify-content: center;
            }
            
            input:not(:checked) ~ label:hover,
            input:not(:checked) ~ label:hover ~ label{
                color: #fd4; 
            }
            input:checked ~ label{
                color: #fd4;
            }

            form .textarea {
                height: 100px;
                width: 100%;
                overflow: hidden;
            }

            form .textarea textarea {
                height: 100%;
                width: 100%;
                outline: none;
                border-radius: 5px;
                border: 2px solid lightgrey;
                background: #fff;
                padding: 10px;
                font-size: 17px;
                resize: none;
            }

            form .textarea textarea:focus {
                border-color: #0984e3;
                box-shadow: inset 0px 0px 1px 1px #0984e3;;
            }
            .wrapper form .button input {
                color: #fff;
                font-size: 30px;
                font-weight: 500;
                padding-left: 0px;
                background: #0984e3;
                border: 1px solid #0984e3;
                cursor: pointer;
            }

            .wrapper form .admin-link {
                text-align: center;
                margin-top: 20px;
                font-size: 17px;
            }
            .wrapper form .admin-link a {
                color: #0984e3;
                text-decoration: none;
                font-size: 20px;
            }

            form .admin-link a:hover {
                text-decoration: underline;
            }


        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
    </head>
    <body>
            <div class="container">
                <div class="wrapper">
                    <div class="title"><span>Feedback Form</span></div>

                    <form method="post">

                        <div class="row">
                            <i class="fas fa-user"></i>
                            <input type="text" name="name" id="name" placeholder="Enter your Name" required autocomplete="off">
                        </div>
                        <div class="row">
                            <i class="fas fa-mail-bulk"></i>
                            <input type="text" name="email" id="emails" placeholder="Enter your Email" required autocomplete="off">
                        </div>
                          
                        <h1 style="color: #084f85; text-align: center;">Rate us !!</h1>

                        <div class="star-widget">

                            <input type="radio" name="rate" value="5" id="rate-5">
                            <label for="rate-5" class="fas fa-star"></label>
                            <input type="radio" name="rate" value="4" id="rate-4">
                            <label for="rate-4" class="fas fa-star"></label>
                            <input type="radio" name="rate" value="3" id="rate-3">
                            <label for="rate-3" class="fas fa-star"></label>
                            <input type="radio" name="rate" value="2" id="rate-2">
                            <label for="rate-2" class="fas fa-star"></label>
                            <input type="radio" name="rate" value="1" id="rate-1" checked="true">
                            <label for="rate-1" class="fas fa-star"></label>

                        </div>

                        <div class="textarea">
                            <textarea name="fb" id="fb" cols="30" placeholder="Feedback description"></textarea>
                        </div>
                        <br>
                        <div class="row button">
                            <input type="submit" name="btnSubmit" value="Submit">
                        </div>
                        <div class="admin-link">Click here for <a href="admin.jsp">Admin Login</a></div>
                    </form>

                    <%
                        if (request.getParameter("btnSubmit") != null)
                        {
                            String name = request.getParameter("name");
                            name = name.trim(); 
                            String email = request.getParameter("email");
                            email = email.trim();
                            String fb = request.getParameter("fb");
                            fb = fb.trim();

                            int rating = Integer.parseInt(request.getParameter("rate"));


                            if(name.matches("[A-Za-z ]+") && email.matches("^[a-zA-Z0-9_!#$%&'*+/=?``{|}~^.-]+@[a-zA-Z0-9.-]+$"))
                            {
                                try {
                                    DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                                    String url = "jdbc:mysql://localhost:3306/database_name;
                                    Connection con = DriverManager.getConnection(url, mysql_username, mysql_password);
                        
                                    String sql = "insert into table_name values(?, ?, ?, ?)";
                                    PreparedStatement pst = con.prepareStatement(sql);

                                    pst.setString(1, name);
                                    pst.setString(2, email);
                                    pst.setString(3, fb);
                                    pst.setInt(4, rating);
                                    pst.executeUpdate();
                                    con.close();
                                    %>
                                    <script>
                                        let tyAlert = "Thank you for your feedback " + "<%= name %>";
                                        alert(tyAlert);
                                    </script>
                        <%
                                } catch (SQLException e) {
                            %>
                                        <script>
                                            let sqlAlert = "Issue: " + "<%= e %>";
                                            alert(sqlAlert);
                                        </script>
                            <%
                                } catch (Exception e) {
                            %>
                                        <script>
                                            let eAlert = "Issue: " + "<%= e %>";
                                            alert(eAlert);
                                        </script>
                            <%
                                        }
                            } else { 
                                    %>
                                    <script>
                                        let emailAlert = "Invalid input in name or email";
                                        alert(emailAlert);
                                    </script>
                        <%
                            }
                        }
                    %>


                </div>
            </div>

    </body>
</html>
