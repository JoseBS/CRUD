<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>

    <link rel="stylesheet" type="text/css" href="css/css.css">


    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>


    <link rel="icon" type="image/ico" href="img/favicon.ico" />
    <title>Proyectos Arduino</title>
  </head>
  <body>
    <nav class="navbar navbar-expand-lg  navbar-dark bg-dark">

      <a class="navbar-brand" href="index.jsp">Gestuino</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="proyectos.jsp">Proyectos <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="articulos.jsp">Artículos <span class="sr-only">(current)</span></a>
          </li>
        </ul>

      </div>
    </nav>
    <%
      request.setCharacterEncoding("UTF-8");

      Class.forName("com.mysql.jdbc.Driver");
      Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3307/proyectoarduino", "root", "");

      PreparedStatement s = conexion.prepareStatement("SELECT proyecto.codPro, proyecto.nomPro, articulo.codArt, articulo.descArt, art_pro.cantidad FROM proyecto LEFT OUTER JOIN art_pro ON (proyecto.codPro = art_pro.codPro) LEFT OUTER JOIN articulo ON (art_pro.codArt = articulo.codArt) WHERE proyecto.codPro=?", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

      PreparedStatement p = conexion.prepareStatement("SELECT codPro, nomPro FROM PROYECTO");

      PreparedStatement a = conexion.prepareStatement("Select codArt, descArt FROM ARTICULO");
      ResultSet articulos = a.executeQuery();
      String listado = "<option value=\"-1\" id=\"codArt\" name=\"codArt\" disabled selected>Selecciona un componente</option>";
      while (articulos.next()) {
        listado += "<option value=\"" + articulos.getString("codArt") + "\" id=\"codArt\" name=\"codArt\">" + articulos.getString("codArt") + " - " + articulos.getString("descArt") + "</option>";
      }
      articulos.close();


    %>
    <div class="container">
      <div class="alertas">

      </div>
    </div>
    <div class="container">
      <div class="bd-example table-responsive-sm " >

        <!-- TABLA LISTADO-->
        <table class="table" style="margin-top: 50px; vertical-align: middle;">
          <!-- CABECERA-->
          <thead class="thead-dark">
          <th scope="col" style="text-align:center;">Nombre Proyecto</th>
          <th scope="col" style="text-align:center;">Componentes</th>
          <th scope="col" colspan="2" style="text-align:center;">Cantidad</th>
          </thead>
          <%            ResultSet proyectos = p.executeQuery();
            ResultSet componentes = null;
            String cebra = "";
            while (proyectos.next()) {

          %>

          <!--Fila -->
          <tbody>

            <tr class="<%=cebra%>">
              <%              s.setInt(1, proyectos.getInt("codPro"));
                componentes = s.executeQuery();

                componentes.last();
                int filas = componentes.getRow();
                componentes.first();
              %>


              <th style="vertical-align: middle; "scope="row" rowspan="<%=filas%>">

                <div class="container"><h3><%=proyectos.getString("nomPro")%></h3></div>
                <div class="container" style="margin-top: 25px;">

                </div>
                <div class="container" id="form<%=proyectos.getString("codPro")%>">
                  <form method="post" action="tratamientoArtPro.jsp" >
                    <div class="form-group row ">
                      <div class="col-8">
                        <select class="form-control" id="codArt" name="codArt">
                          <%=listado%>
                        </select>
                      </div>
                      <div class="col-3">
                        <button type="input" class="btn btn-success col-form" title="Añadir un componente" id="peticion" name="peticion" value="insArt"><i class="fas fa-plus-square"></i></button>
                      </div>
                    </div>
                    <input type="hidden" id="codPro" name="codPro" value="<%=proyectos.getString("codPro")%>">
                  </form>
                </div>

              </th>

              <%

                for (int i = 1; i <= filas; i++) {
                  String articulo = componentes.getString("descArt");
                  if (articulo == null) {
                    articulo = "Vacío";
                  }
              %>

              <td class="<%=cebra%>" style="vertical-align: middle;"><%=articulo%></td>
              <td class="<%=cebra%>" style="vertical-align: middle; ">
                <form method="post" action="tratamientoArtPro.jsp">
                  <%
                    if (articulo.equals("Vacío")) {
                  %>
                  <input readonly style="width: 65px; float: left; margin-right: 15px;" class="form-control" type="number" id="cantidad" name="cantidad" min="1" step="1" placeholder="<%=componentes.getString("cantidad")%>">
                  <button disabled type="input" class="btn btn-warning"><i class="fas fa-sync"></i></button>

                  <%
                  } else {

                  %>
                  <input style="width: 65px; float: left; margin-right: 15px;" class="form-control" type="number" id="cantidad" name="cantidad" min="1" step="1" placeholder="<%=componentes.getString("cantidad")%>">
                  <button type="input" class="btn btn-warning" title="Modificar la cantidad de este componente"><i class="fas fa-sync"></i></button>
                    <%
                      }
                    %>

                  <input type="hidden" id="codPro" name="codPro" value="<%=componentes.getString("codPro")%>">
                  <input type="hidden" id="codArt" name="codArt" value="<%=componentes.getString("codArt")%>">
                  <input type="hidden" id="peticion" name="peticion" value="modArt">
                </form>
              </td>
              <td class="<%=cebra%>" style="vertical-align: middle; ">
                <form method="post" action="tratamientoArtPro.jsp">
                  <%
                    if (articulo.equals("Vacío")) {
                  %>
                  <button disabled type="input" class="btn btn-danger"><i class="fas fa-minus-circle"></i></button>


                  <%
                  } else {

                  %>
                  <button type="input" class="btn btn-danger" title="Eliminar este componente"><i class="fas fa-minus-circle"></i></button>
                    <%                    }
                    %>
                  <input type="hidden" id="codPro" name="codPro" value="<%=componentes.getString("codPro")%>">
                  <input type="hidden" id="codArt" name="codArt" value="<%=componentes.getString("codArt")%>">
                  <input type="hidden" id="peticion" name="peticion" value="delArt">
                </form>
              </td>
            </tr>


            <%
                  componentes.next();
                }
                if (cebra.equals("")) {
                  cebra = "filacebra";
                } else {
                  cebra = "";
                }
                componentes.close();
              }
              proyectos.close();
            %>
          </tbody>
        </table>
      </div>
    </div>


    <script>

      var url_get = window.location.href; //window.location.href
      var url = new URL(url_get);
      var r = url.searchParams.get("r");
      var p = url.searchParams.get("p").toString();
      var m = "modArt";
      var d = "delArt";
      var i = "insArt";

      if (p === m && r == 1) {
        //activa alert de modificacion
        $("<div class=\"container alert alert-success alert-dismissible fade show\" role=\"alert\" style=\"margin-top: 25px; text-align: center; margin-bottom: 25px;\">  <strong>Artículo modificado correctamente.</strong>&nbsp;&nbsp;<i class=\"fas fa-check\"></i> <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">    <span aria-hidden=\"true\">&times;</span>  </button></div>").appendTo(".alertas");
      } else if (p === m && r != 1) {
        $("<div class=\"container alert alert-warning alert-dismissible fade show\" role=\"alert\" style=\"margin-top: 25px; text-align: center; margin-bottom: 25px;\">  <strong>No se han realizado cambios.</strong>&nbsp;&nbsp;<i class=\"fas fa-exclamation-triangle\"></i> <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">    <span aria-hidden=\"true\">&times;</span>  </button></div>").appendTo(".alertas");
      }

      if (p === d && r == 1) {
        //activa alert de borrado
        $("<div class=\"container alert alert-success alert-dismissible fade show\" role=\"alert\" style=\"margin-top: 25px; text-align: center; margin-bottom: 25px;\">  <strong>Artículo borrado.</strong>&nbsp;&nbsp;<i class=\"fas fa-check\"></i> <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">    <span aria-hidden=\"true\">&times;</span>  </button></div>").appendTo(".alertas");
      }

      if (p === i && r == 1) {
        //activa alert de insertar
        $("<div class=\"container alert alert-success alert-dismissible fade show\" role=\"alert\" style=\"margin-top: 25px; text-align: center; margin-bottom: 25px;\">  <strong>Artículo guardado correctamente.</strong>&nbsp;&nbsp;<i class=\"fas fa-check\"></i> <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">    <span aria-hidden=\"true\">&times;</span>  </button></div>").appendTo(".alertas");
      } else if (p === i && r == 0) {
        $("<div class=\"container alert alert-danger alert-dismissible fade show\" role=\"alert\" style=\"margin-top: 25px; text-align: center; margin-bottom: 25px;\">  <strong>Artículo ya existente.</strong>&nbsp;&nbsp;<i class=\"fas fa-times\"></i> <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">    <span aria-hidden=\"true\">&times;</span>  </button></div>").appendTo(".alertas");
      } else if (p === i) {
        $("<div class=\"container alert alert-warning alert-dismissible fade show\" role=\"alert\" style=\"margin-top: 25px; text-align: center; margin-bottom: 25px;\">  <strong>No se ha seleccionado artículo.</strong>&nbsp;&nbsp;<i class=\"fas fa-exclamation-triangle\"></i> <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">    <span aria-hidden=\"true\">&times;</span>  </button></div>").appendTo(".alertas");

      }

    </script>
  </body>
</html>
