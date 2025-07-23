
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Bill Generator</title>
    <style>
        body {
            font-family: Arial;
            background-color: #f2f2f2;
            padding: 50px;
            text-align: center;
        }
        input[type="text"] {
            padding: 10px;
            width: 200px;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
        }
        .box {
            background: white;
            padding: 30px;
            display: inline-block;
            box-shadow: 0 0 10px #ccc;
        }
    </style>
</head>
<body>
    <div class="box">
        <h2>Enter Transaction ID</h2>
        <form action="GenerateBillServlet" method="get">
            <input type="text" name="tid" placeholder="Transaction ID" required />
            <br><br>
            <input type="submit" value="Generate Bill" />
        </form>
    </div>
</body>
</html>
