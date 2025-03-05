<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.UserService, model.User, java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Pet Shop</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
<div id="wrap">

       <div class="header">
       		<div class="logo"><a href="index.jsp"><img src="images/logo.gif" alt="" title="" border="0" /></a></div>            
        <div id="menu">
            <ul>                                                                       
            <li><a href="index.jsp">home</a></li>
            <li><a href="about.jsp">about us</a></li>
            <li><a href="category.jsp">pets</a></li>
            <li><a href="specials.jsp">specials pets</a></li>
            <li class="selected"><a href="myaccount.jsp">my account</a></li>
            <li><a href="register.jsp">register</a></li>
            <li><a href="contact.jsp">contact</a></li>
            </ul>
        </div>     
       </div> 
       
       <div class="center_content">
       	<div class="left_content">
            <div class="title"><span class="title_icon"><img src="images/bullet1.gif" alt="" title="" /></span>My account</div>
        
        	<div class="feat_prod_box_details">
            <p class="details">Welcome back to Pet Shop! We're thrilled to have you and your furry friends with us again. Please enter your details below to continue.</p>
            
              	<div class="contact_form">
    <div class="form_subtitle">login into your account</div>
    <style>
    .error_message {
        color: red;
        font-weight: bold;
        margin-bottom: 10px;
    }
</style>
    <% if (request.getAttribute("error") != null) { %>
        <div class="error_message">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
    <form name="login" action="user?action=login" method="post">          
        <div class="form_row">
            <label class="contact"><strong>Username:</strong></label>
            <input type="text" class="contact_input" name="username" required />
        </div>  

        <div class="form_row">
            <label class="contact"><strong>Password:</strong></label>
            <input type="password" class="contact_input" name="password" required />
        </div>                     

        <div class="form_row">
            <div class="terms">
                <input type="checkbox" name="remember" />
                Remember me
            </div>
        </div> 

        <div class="form_row">
            <input type="submit" class="register" value="login" />
        </div>   
    </form>     
</div>  
            </div>	
        <div class="clear"></div>
        </div><!--end of left content-->
        
        <div class="right_content">
            <!-- Right content remains the same as in the original HTML -->
        </div><!--end of right content-->
        
       <div class="clear"></div>
       </div><!--end of center content-->
       
       <div class="footer">
       	<div class="left_footer"><img src="images/footer_logo.gif" alt="" title="" /><br /> <a href="http://csscreme.com/freecsstemplates/" title="free css templates"><img src="images/csscreme.gif" alt="free css templates" border="0" /></a></div>
        <div class="right_footer">
        <a href="#">home</a>
        <a href="#">about us</a>
        <a href="#">services</a>
        <a href="#">privacy policy</a>
        <a href="#">contact us</a>
        </div>
       </div>
</div>
</body>
</html>