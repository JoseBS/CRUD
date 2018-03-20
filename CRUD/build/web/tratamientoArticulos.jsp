<%@page import="java.sql.SQLException"%>
<!DOCTYPE html>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="java.util.*, java.io.*" %>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="java.io.File"%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
  String UPDATE_ART = "UPDATE ARTICULO SET descArt = ?, precArt = ?, imgArt = ? WHERE codArt = ?";
  String DELETE_ART = "DELETE FROM articulo WHERE codArt = ?";
  String INSERT_ART = "INSERT INTO articulo VALUES (?, ?, ?, ?)";

  request.setCharacterEncoding("UTF-8");
  Class.forName("com.mysql.jdbc.Driver");
  Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3307/proyectoarduino", "root", "");

  PreparedStatement sentencia = null;

  int resultado = 0;
  String codigo = "";
  String descripcion = "";
  String precio = "";
  String peticion = "";

  String ImageFile = "";
  String itemName = "";

  //GUARDADO DE IMAGEN Y ANALISIS DE LOS DATOS DEL FORMULARIO
  try {

    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if (!isMultipart) {
    } else {
      FileItemFactory factory = new DiskFileItemFactory();
      ServletFileUpload upload = new ServletFileUpload(factory);
      List items = null;
      try {
        items = upload.parseRequest(request);
      } catch (FileUploadException e) {
        e.getMessage();
      }

      // EXAMINAMOS LOS CAMPOS DEL FORMULARIO
      Iterator itr = items.iterator();
      while (itr.hasNext()) {
        FileItem item = (FileItem) itr.next();

        if (item.isFormField()) {
          String name = item.getFieldName();
          String value = item.getString("UTF-8");

          if (name.equals("img")) {
            ImageFile = value;
          } else if (name.equals("codigo")) {
            codigo = value;
          } else if (name.equals("descripcion")) {
            descripcion = value;
          } else if (name.equals("peticion")) {
            peticion = value;
          } else if (name.equals("precio")) {
            precio = value;
          }
        } else {
          try {
            itemName = item.getName();
            File savedFile = new File(config.getServletContext().getRealPath("\\") + "img\\" + itemName);
            item.write(savedFile);
          } catch (Exception e) {
            //out.println("Error" + e.getMessage()); //MUESTRA EN HTML EL ERROR DE FICHERO NO GUARDADO
             e.printStackTrace();
          }
        }
      }

    }
  } catch (Exception e) {
    out.println(e.getMessage());
  }
  //FIN DE GUARDADO IMAGEN

  //EJECUCION DE CONSULTAS CORRESPONDIENTES
  if (peticion.equals("modArt")) {
    if (precio.isEmpty() || Double.valueOf(precio) <= 0.00
      || descripcion.isEmpty() || descripcion.toLowerCase().equals("null")) {
      resultado = -1;
    } else {
      try {
        sentencia = conexion.prepareStatement(UPDATE_ART);
        sentencia.setString(1, descripcion);
        sentencia.setDouble(2, Double.valueOf(precio));
        if (itemName.equals("") || itemName.isEmpty()) {
          sentencia.setString(3, null);
        } else {
          sentencia.setString(3, itemName);
        }
        sentencia.setInt(4, Integer.valueOf(codigo));
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
      sentencia = conexion.prepareStatement(DELETE_ART);
      sentencia.setInt(1, Integer.valueOf(codigo));
      resultado = sentencia.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      sentencia.close();
      conexion.close();
    }

  } else if (peticion.equals("insArt")) {
    if (precio.isEmpty() || Double.valueOf(precio) <= 0.00
      || descripcion.isEmpty() || descripcion.toLowerCase().equals("null") || codigo.isEmpty() || codigo.toLowerCase().equals("null")) {
      resultado = -1;
    } else {
      try {
        sentencia = conexion.prepareStatement(INSERT_ART);
        sentencia.setInt(1, Integer.valueOf(codigo));
        sentencia.setString(2, descripcion);
        sentencia.setDouble(3, Double.valueOf(precio));
        if (itemName.equals("") || itemName.isEmpty()) {
          sentencia.setString(4, null);
        } else {
          sentencia.setString(4, itemName);
        }

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




<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

  </head>
  <body>
    <input type="hidden" value="<%=peticion%>" id="peticion">
    <input type="hidden" value="<%=resultado%>" id="resultado">

   <!-- <h1><%=peticion%></h1>
    <h1><%=codigo%></h1>
    <h1><%=descripcion%></h1>
    <h1><%=precio%></h1>  
   <h1><%=itemName%></h1>-->
    <script>
      var p = document.getElementById('peticion').value;
      var r = document.getElementById('resultado').value;
      document.location = "articulos.jsp?r=" + r + "&p=" + p;</script>
  </body>
</html>
