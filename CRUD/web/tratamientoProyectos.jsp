<%@page import="java.sql.Date"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="icon" type="image/ico" href="favicon.ico" />
  </head>
  <body>
    <%
      String UPDATE_PRO = "UPDATE PROYECTO SET nomPro = ?, descPro = ?, fecEntrega = ? WHERE codPro = ?";
      String DELETE_PRO = "DELETE FROM proyecto WHERE codPro = ?";
      String INSERT_PRO = "INSERT INTO proyecto VALUES (?, ?, ?, ?)";
      
      request.setCharacterEncoding("UTF-8");
      
      Class.forName("com.mysql.jdbc.Driver");
      Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3307/proyectoarduino", "root", "");
      
      PreparedStatement sentencia = null;
      String peticion = request.getParameter("peticion");
      int resultado = 0;
      
      if (peticion.equals("modPro")) {
        if (request.getParameter("codigo").isEmpty() || request.getParameter("nombre").isEmpty() || request.getParameter("nombre").toLowerCase().equals("null")
          || request.getParameter("descripcion").isEmpty() || request.getParameter("descripcion").toLowerCase().equals("null") || request.getParameter("fecEntrega").isEmpty()) {
          resultado = -1;
        } else {
          try {
            sentencia = conexion.prepareStatement(UPDATE_PRO);
            sentencia.setString(1, request.getParameter("nombre"));
            sentencia.setString(2,request.getParameter("descripcion"));
            sentencia.setDate(3, Date.valueOf(request.getParameter("fecEntrega")));
            sentencia.setInt(4, Integer.valueOf(request.getParameter("codigo")));
            resultado = sentencia.executeUpdate();
            
          } catch (SQLException e) {
            e.printStackTrace();
          } finally {
            sentencia.close();
            conexion.close();
          }
          
          sentencia.close();
        }
      } else if (peticion.equals("delPro")) {
        try {
          sentencia = conexion.prepareStatement(DELETE_PRO);
          sentencia.setInt(1, Integer.valueOf(request.getParameter("codigo")));
          resultado = sentencia.executeUpdate();
        } catch (SQLException e) {
          e.printStackTrace();
        } finally {
          sentencia.close();
          conexion.close();
        }
        
      } else if (peticion.equals("insPro")) {
        if (request.getParameter("codigo").isEmpty() || request.getParameter("nombre").isEmpty() || request.getParameter("nombre").toLowerCase().equals("null")
          || request.getParameter("descripcion").isEmpty() || request.getParameter("descripcion").toLowerCase().equals("null") || request.getParameter("fecEntrega").isEmpty()) {
          resultado = -1;
        } else {
          try {
            sentencia = conexion.prepareStatement(INSERT_PRO);
            sentencia.setInt(1, Integer.valueOf(request.getParameter("codigo")));
            sentencia.setString(2, request.getParameter("nombre"));
            sentencia.setString(3,request.getParameter("descripcion"));
            sentencia.setDate(4, Date.valueOf(request.getParameter("fecEntrega")));
            
            resultado = sentencia.executeUpdate();
          } catch (SQLException e) {
            e.printStackTrace();
          } finally {
            sentencia.close();
            conexion.close();
          }
        }
      }

    %>  
    <input type="hidden" value="<%=peticion%>" id="peticion">
    <input type="hidden" value="<%=resultado%>" id="resultado">

  

    <script>
      var p = document.getElementById('peticion').value;
      var r = document.getElementById('resultado').value;
      document.location = "proyectos.jsp?r=" + r + "&p=" + p;</script>
  </body>
</html>
