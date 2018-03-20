<%@page import="com.mysql.jdbc.Statement"%>
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
    <title>JSP Page</title>
  </head>
  <body>
    <%
      request.setCharacterEncoding("UTF-8");

      Class.forName("com.mysql.jdbc.Driver");
      Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3307/proyectoarduino", "root", "");

      String INSERT = "INSERT INTO ART_PRO (codArt, codPro, cantidad) VALUES (?, ?, 1)";
      String UPDATE = "UPDATE ART_PRO SET cantidad = ? WHERE codArt = ? AND codPro = ?";
      String DELETE = "DELETE FROM ART_PRO WHERE codPro=? AND codArt=?";

      PreparedStatement sentencia = null;
      String peticion = request.getParameter("peticion");
      int resultado = 0;

      if (peticion.equals("modArt")) {
        if (request.getParameter("cantidad").isEmpty() || Integer.valueOf(request.getParameter("cantidad")) < 1) {
          resultado = -1;
        } else {
          try {
            sentencia = conexion.prepareStatement(UPDATE);
            sentencia.setInt(1, Integer.valueOf(request.getParameter("cantidad")));
            sentencia.setInt(2, Integer.valueOf(request.getParameter("codArt")));
            sentencia.setInt(3, Integer.valueOf(request.getParameter("codPro")));
            resultado = sentencia.executeUpdate();

          } catch (SQLException e) {
            e.printStackTrace();
          } finally {
            sentencia.close();
            conexion.close();
          }

          sentencia.close();
        }
      } else if (peticion.equals("delArt")) {
        try {
          sentencia = conexion.prepareStatement(DELETE);
          sentencia.setInt(1, Integer.valueOf(request.getParameter("codPro")));
          sentencia.setInt(2, Integer.valueOf(request.getParameter("codArt")));

          resultado = sentencia.executeUpdate();
        } catch (SQLException e) {
          e.printStackTrace();
        } finally {
          sentencia.close();
          conexion.close();
        }

      } else if (peticion.equals("insArt") && request.getParameter("codArt")!=null) {

        //comprueba si ese producto ya existe
        PreparedStatement s = conexion.prepareStatement("SELECT COUNT(*) FROM ART_PRO WHERE codArt=? AND codPro=?");

        s.setInt(1, Integer.valueOf(request.getParameter("codArt")));
        s.setInt(2, Integer.valueOf(request.getParameter("codPro")));

        ResultSet r = s.executeQuery();
        int consulta = 0;
        while (r.next()) {
          consulta = r.getInt(1);
        }
        if (consulta != 0) {
          resultado = -1;
        } else {
          try {
            sentencia = conexion.prepareStatement(INSERT);
            sentencia.setInt(2, Integer.valueOf(request.getParameter("codPro")));
            sentencia.setInt(1, Integer.valueOf(request.getParameter("codArt")));

            resultado = sentencia.executeUpdate();
          } catch (SQLException e) {
            e.printStackTrace();
          } finally {
            r.close();
            sentencia.close();
            conexion.close();
          }
        }

      }else{
        resultado = -1;
      }


    %>



    <input type="hidden" value="<%=peticion%>" id="peticion">
    <input type="hidden" value="<%=resultado%>" id="resultado">

    <script>
      var p = document.getElementById('peticion').value;
      var r = document.getElementById('resultado').value;
    document.location = "index.jsp?r=" + r + "&p=" + p;</script>
  </body>
</html>
