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
    <link rel="icon" type="image/ico" href="img/favicon.ico" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
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

    <div class="container btn-add" style="margin-top: 25px; text-align: center;">
      <button class="btn btn-default btn-info" title="Insertar artículo" data-toggle="modal" data-target="#insertarArticulo">
        <i class="far fa-plus-square"></i>&nbsp;&nbsp;Añadir un artículo</button>
    </div>



    <%
      Class.forName("com.mysql.jdbc.Driver");
      Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3307/proyectoarduino", "root", "");
      PreparedStatement s = conexion.prepareStatement("SELECT codArt, descArt, precArt, imgArt FROM ARTICULO");

      // request.setCharacterEncoding("UTF-8");
      ResultSet listado = s.executeQuery();
    %>


    <div class="container ">
      <div class="table-responsive-sm " >

        <!-- TABLA LISTADO-->
        <table class="table table-striped " style="margin-top: 50px;">
          <!-- CABECERA-->
          <thead class="thead-dark">
          <th scope="col" style="text-align: center;">Código</th>
          <th scope="col">Descripción</th>
          <th scope="col">Precio</th>
          <th scope="col">Imagen</th>
          <th scope="col" colspan="2" style="text-align: center;">Gestionar</th>
          </thead>
          <%
            int cont = 1;
            while (listado.next()) {
          %>
          <!-- FILA-->
          <tr>
            <th scope="row" style="text-align: center;"><%=listado.getString("codArt")%></th>
            <td><%=listado.getString("descArt")%></td>
            <td><%=listado.getString("precArt")%> €</td>


            <%
              if (listado.getString("imgArt") == null || listado.getString("imgArt").toLowerCase().equals("null") || listado.getString("imgArt").isEmpty()) {

            %>

            <td><img class="img-fluid" src="img/noimagen.png" width="50" height="50"></td>

            <%              } else {
            %>

            <td><img class="img-fluid" src="img/<%=listado.getString("imgArt")%>" width="75" height="75"></td>

            <%
              }
            %>

            <td style="text-align: center;">
              <!-- Modal para MODIFICAR-->
              <div class="modal fade" id="modificarArticulo<%=cont%>">
                <div class="modal-dialog">
                  <div class="modal-content" style="text-align: left;">


                    <div class="modal-header"> <!-- Modal Header -->
                      <h4 class="modal-title">Modificar Artículo</h4>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div> <!-- Fin Modal Header -->
                    <div class="modal-body"><!-- Modal body -->
                      <form method="post" action="tratamientoArticulos.jsp" id="formModificar<%=cont%>" enctype="multipart/form-data" ><!-- Form modal Modificar -->
                        <div class="form-row">
                          <div class="form-group col-md-6">
                            <label for="codigo">Codigo</label>
                            <input class="form-control" id="codigo" type="text" name="codigo" value="<%=listado.getString("codArt")%>" readonly>
                          </div>
                          <div class="form-group col-md-6">
                            <label for="descripcion">Descripcion</label>
                            <input class="form-control" id="descripcion" type="text" name="descripcion" value="<%=listado.getString("descArt")%>">
                          </div>
                        </div>
                        <div class="form-row">
                          <div class="form-group col-md-6">
                            <label for="precio">Precio</label>
                            <input class="form-control" id="precio" type="number" min="0.00"  step="0.50" name="precio" value="<%=listado.getString("precArt")%>">
                          </div>
                          <div class="form-group col-md-6">
                            <label for="imagen">Imagen</label>
                            <input class="form-control" id="img" type="file" name="img" value="<%=listado.getString("imgArt")%>">
                            <small id="fileHelp" class="form-text text-muted">Máximo 2MB (*.png, *.jpg, *.bmp)</small>
                          </div>


                          <input id="peticion" name="peticion" type="hidden" value="modArt">
                        </div>
                      </form>
                    </div><!-- Fin Modal body -->
                    <div class="modal-footer"><!-- Modal footer -->
                      <button type="button" class="btn btn-success" onclick="enviaFormulario('formModificar<%=cont%>')">Modificar</button>
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    </div>
                  </div><!-- Fin Modal footer -->
                </div><!-- Fin Modal Container -->
              </div> <!-- FIN VENTANA EMERGENTE -->

              <button class="btn btn-warning btn-lg btn-default" name="editar" title="Modificar artículo" data-toggle="modal" data-target="#modificarArticulo<%=cont%>">
                <i class="far fa-edit"></i>
              </button>

            </td>
            <td style="text-align: center;">

              <!-- Modal para Borrar -->
              <div class="modal fade" id="borrarArticulo<%=cont%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title" id="exampleModalLabel">Eliminar Artículo</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                      </button>
                    </div>
                    <div class="modal-body"
                         <p>¿Seguro que quieres eliminar el artículo?</p> <p>Eliminar: <b><%=listado.getString("descArt")%></b></p>

                      <form method="post" action="tratamientoArticulos.jsp" id="formBorrar<%=cont%>"enctype="multipart/form-data"><!-- Form modal Borrar -->
                        <input type="hidden" name="codigo" value="<%=listado.getString("codArt")%>">
                        <input id="peticion" name="peticion" type="hidden" value="delArt">
                      </form>

                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-danger" onclick="enviaFormulario('formBorrar<%=cont%>')">Borrar</button>
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    </div>
                  </div>
                </div>
              </div>
              <!-- Fin Modal para Borrar -->
              <button class="btn btn-danger btn-lg btn-default" type="submit" name="borrar" title="Borrar artículo" data-toggle="modal" data-target="#borrarArticulo<%=cont%>">
                <i class="fas fa-eraser"></i>
              </button>
            </td>
          </tr>  <!-- FIN FILA-->

          <%
              cont++;
            }
          %>

        </table>  

      </div>
    </div>


    <!-- Modal para INSERTAR-->
    <div class="modal fade" id="insertarArticulo">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header"> <!-- Modal Header -->
            <h4 class="modal-title">Insertar Artículo</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
          </div> <!-- Fin Modal Header -->
          <div class="modal-body"><!-- Modal body -->

            <form method="post" action="tratamientoArticulos.jsp" id="formInsertar" enctype="multipart/form-data"><!-- Form modal Insertar -->
              <div class="form-row">
                <div class="form-group col-md-6">
                  <label for="codigo">Codigo</label>
                  <input class="form-control" id="codigo" type="number" min="0"  step="1" name="codigo" placeholder="Código">
                </div>
                <div class="form-group col-md-6">
                  <label for="descripcion">Descripcion</label>
                  <input class="form-control" id="descripcion" type="text" name="descripcion" placeholder="Descripción o nombre">
                </div>
              </div>
              <div class="form-row">
                <div class="form-group col-md-6">
                  <label for="precio">Precio</label>
                  <input class="form-control" id="precio" type="number" min="0.00"  step="0.50" name="precio" placeholder="0.00">
                </div>
                <div class="form-group col-md-6">
                  <label for="imagen">Imagen</label>
                  <input class="form-control" id="img" type="file" name="img" placeholder="imagen.jpg">
                </div>
                <input id="peticion" name="peticion" type="hidden" value="insArt">
              </div>
            </form>


          </div><!-- Fin Modal body -->
          <div class="modal-footer"><!-- Modal footer -->
            <button type="button" class="btn btn-success" onclick="enviaFormulario('formInsertar')">Insertar</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
          </div>
        </div><!-- Fin Modal footer -->
      </div><!-- Fin Modal Container -->
    </div> <!-- FIN VENTANA EMERGENTE -->


    <script>
      function enviaFormulario(id) {
        document.getElementById(id).submit();
      }


      var url_get = window.location.href; //window.location.href
      var url = new URL(url_get);
      var r = url.searchParams.get("r");
      var p = url.searchParams.get("p").toString();
      var m = "modArt";
      var d = "delArt";
      var i = "insArt";

      if (p === m && r == 1) {
        //activa alert de modificacion
        $("<div class=\"container alert alert-success alert-dismissible fade show\" role=\"alert\" style=\"margin-top: 25px; text-align: center; margin-bottom: 25px;\">  <strong>Modificación realizada correctamente.</strong>&nbsp;&nbsp;<i class=\"fas fa-check\"></i> <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">    <span aria-hidden=\"true\">&times;</span>  </button></div>").insertAfter(".btn-add");
      } else if (p === m && r != 1) {
        $("<div class=\"container alert alert-danger alert-dismissible fade show\" role=\"alert\" style=\"margin-top: 25px; text-align: center; margin-bottom: 25px;\">  <strong>La modificación no se ha realizado.</strong>&nbsp;&nbsp;<i class=\"fas fa-times\"></i> <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">    <span aria-hidden=\"true\">&times;</span>  </button></div>").insertAfter(".btn-add");
      }

      if (p === d && r == 1) {
        //activa alert de borrado
        $("<div class=\"container alert alert-success alert-dismissible fade show\" role=\"alert\" style=\"margin-top: 25px; text-align: center; margin-bottom: 25px;\">  <strong>Artículo borrado.</strong>&nbsp;&nbsp;<i class=\"fas fa-check\"></i> <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">    <span aria-hidden=\"true\">&times;</span>  </button></div>").insertAfter(".btn-add");
      }
      if (p === i && r == 1) {
        //activa alert de modificacion
        $("<div class=\"container alert alert-success alert-dismissible fade show\" role=\"alert\" style=\"margin-top: 25px; text-align: center; margin-bottom: 25px;\">  <strong>Artículo guardado correctamente.</strong>&nbsp;&nbsp;<i class=\"fas fa-check\"></i> <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">    <span aria-hidden=\"true\">&times;</span>  </button></div>").insertAfter(".btn-add");
      } else if (p === i && r != 1) {
        $("<div class=\"container alert alert-danger alert-dismissible fade show\" role=\"alert\" style=\"margin-top: 25px; text-align: center; margin-bottom: 25px;\">  <strong>No se ha guardado el artículo, revisa los campos.</strong>&nbsp;&nbsp;<i class=\"fas fa-times\"></i> <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">    <span aria-hidden=\"true\">&times;</span>  </button></div>").insertAfter(".btn-add");
      }

    </script>

  </body>
</html>
