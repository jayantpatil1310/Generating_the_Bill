<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Generated Bill</title>
    <style>
        body { font-family: Arial; margin: 40px; }
        h2, h3 { color: #333; }
        table { border-collapse: collapse; width: 80%; margin-bottom: 30px; }
        th, td { border: 1px solid #888; padding: 8px 12px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>

<%
ResultSet buyer = (ResultSet) request.getAttribute("buyerDetails");
ResultSet items = (ResultSet) request.getAttribute("productDetails");
int tid = (int) request.getAttribute("tid");
float subtotal = 0;

if (buyer.next()) {
%>

<h2>Buyer Details</h2>
<p>
    <strong>Name:</strong> <%= buyer.getString("name") %><br>
    <strong>Address:</strong> <%= buyer.getString("address") %><br>
    <strong>Phone:</strong> <%= buyer.getString("phone") %><br>
    <strong>Email:</strong> <%= buyer.getString("email") %><br>
</p>

<h2>Product Details</h2>
<table>
    <tr>
        <th>Product Name</th>
        <th>Quantity</th>
        <th>Unit Price</th>
        <th>Total Price</th>
    </tr>
<%
    while (items.next()) {
        float total = items.getFloat("total");
        subtotal += total;
%>
    <tr>
        <td><%= items.getString("name") %></td>
        <td><%= items.getInt("quantity") %></td>
        <td>₹<%= items.getFloat("unit_price") %></td>
        <td>₹<%= total %></td>
    </tr>
<% } %>
</table>

<h3>Subtotal: ₹<%= subtotal %></h3>
<h3>Final Total: ₹<%= subtotal %></h3>

<h2>Transaction Details</h2>
<p>
    <strong>Transaction ID:</strong> <%= tid %><br>
    <strong>Purchase Date:</strong> <%= buyer.getString("date") %><br>
    <strong>Payment Method:</strong> <%= buyer.getString("payment_method") %><br>
</p>

<% } %>

</body>
</html>
