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

    <script src="https://cdn.jsdelivr.net/npm/gijgo@1.8.2/combined/js/gijgo.min.js" type="text/javascript"></script>
    <link href="https://cdn.jsdelivr.net/npm/gijgo@1.8.2/combined/css/gijgo.min.css" rel="stylesheet" type="text/css" />
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

    <div class="container btn-add" style="margin-top: 25px; text-align: center;">
      <button class="btn btn-default btn-info" title="Añadir proyecto" data-toggle="modal" data-target="#insertarProyecto">
        <i class="far fa-plus-square"></i>&nbsp;&nbsp;Crear un proyecto</button>
    </div>



    <%
      Class.forName("com.mysql.jdbc.Driver");
      Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3307/proyectoarduino", "root", "");
      PreparedStatement s = conexion.prepareStatement("SELECT codPro, nomPro, descPro, fecEntrega FROM PROYECTO");

      request.setCharacterEncoding("UTF-8");
      ResultSet listado = s.executeQuery();
    %>


    <div class="container ">
      <div class="table-responsive-sm " >

        <!-- TABLA LISTADO-->
        <table class="table table-striped " style="margin-top: 50px;">
          <!-- CABECERA-->
          <thead class="thead-dark">
          <th scope="col">Código</th>
          <th scope="col" style="text-align:center;">Nombre</th>
          <th scope="col" style="text-align:center;">Descripción</th>
          <th scope="col" style="text-align:center;">Fecha de Entrega</th>
          <th scope="col" colspan="2" style="text-align: center;">Gestionar</th>
          </thead>
          <%
            int cont = 1;
            while (listado.next()) {
          %>
          <!-- FILA-->
          <tr>
            <th class="centrada-vertical" scope="row" style="text-align:center;vertical-align: middle;">#<%=listado.getString("codPro")%></th>
            <td class="centrada-vertical" style="vertical-align: middle;"><%=listado.getString("nomPro")%></td>
            <td class="desc-col" style="vertical-align: middle;"><%=listado.getString("descPro")%> </td>
            <td  class="centrada-vertical" style="text-align:center;vertical-align: middle;"><%=listado.getString("fecEntrega")%></td>

            <td class="centrada-vertical" style="text-align: center;vertical-align: middle;">
              <!-- Modal para MODIFICAR-->
              <div class="modal fade" id="modificarProyecto<%=cont%>">
                <div class="modal-dialog">
                  <div class="modal-content">


                    <div class="modal-header"> <!-- Modal Header -->
                      <h4 class="modal-title">Modificar Proyecto</h4>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div> <!-- Fin Modal Header -->
                    <div class="modal-body" style="text-align: left;"><!-- Modal body -->
                      <div class="ml-auto col-md-10">
                        <form method="post" action="tratamientoProyectos.jsp" id="formModificar<%=cont%>"><!-- Form modal Modificar -->
                          <div class="form-row">
                            <div class="form-group col-md-3">
                              <label for="codigo">Código</label>
                              <input class="form-control" id="codigo" type="text" name="codigo" value="<%=listado.getString("codPro")%>" readonly>
                            </div>
                            <div class="form-group col-md-6">
                              <label for="nombre">Nombre</label>
                              <input class="form-control" id="nombre" type="text" name="nombre" value="<%=listado.getString("nomPro")%>">
                            </div>
                          </div>
                          <div class="form-row">
                            <div class="form-group col-md-9">
                              <label for="fechaEntrega">Fecha de Entrega</label>
                              <input class="form-control" id="fecEntrega<%=cont%>" type="text" name="fecEntrega" readonly value="<%=listado.getString("fecEntrega")%>">

                            </div>
                          </div>
                          <div class="form-row">
                            <div class="form-group col-md-9">
                              <label for="descripcion">Descripción</label>
                              <textarea maxlength="500" id="descripcion" name="descripcion" cols="40" rows="5" required="required" class="form-control" placeholder="<%=listado.getString("descPro")%>"></textarea>


                            </div>
                          </div>
                          <input id="peticion" name="peticion" type="hidden" value="modPro">

                        </form>
                      </div>
                    </div><!-- Fin Modal body -->
                    <div class="modal-footer"><!-- Modal footer -->
                      <button type="button" class="btn btn-success" onclick="enviaFormulario('formModificar<%=cont%>')">Modificar</button>
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    </div>
                  </div><!-- Fin Modal footer -->
                </div><!-- Fin Modal Container -->
              </div> <!-- FIN VENTANA EMERGENTE -->

              <button class="btn btn-warning btn-lg btn-default" name="editar" title="Modificar proyecto" data-toggle="modal" data-target="#modificarProyecto<%=cont%>">
                <i class="far fa-edit"></i>
              </button>

            </td>
            <td class="centrada-vertical" style="text-align: center;vertical-align: middle;">

              <!-- Modal para Borrar -->
              <div class="modal fade" id="borrarProyecto<%=cont%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title" id="exampleModalLabel">Eliminar Proyecto</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                      </button>
                    </div>
                    <div class="modal-body"
                         <p>¿Seguro que quieres eliminar el proyecto?</p> <p>Eliminar: <b><%=listado.getString("nomPro")%></b></p>

                      <form method="post" action="tratamientoProyectos.jsp" id="formBorrar<%=cont%>"><!-- Form modal Borrar -->
                        <input type="hidden" name="codigo" value="<%=listado.getString("codPro")%>">
                        <input id="peticion" name="peticion" type="hidden" value="delPro">
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
              <button class="btn btn-danger btn-lg btn-default" type="submit" name="borrar" title="Borrar proyecto" data-toggle="modal" data-target="#borrarProyecto<%=cont%>">
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
    <div class="modal fade" id="insertarProyecto">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header"> <!-- Modal Header -->
            <h4 class="modal-title">Crear Proyecto</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
          </div> <!-- Fin Modal Header -->
          <div class="modal-body" ><!-- Modal body -->
            <div class="container">
              <form method="post" action="tratamientoProyectos.jsp" id="formInsertar"><!-- Form modal Insertar -->

                <div class="form-group">
                  <div class="form-row">
                    <div class="form-group col-md-5">
                      <label for="codigo">Código</label>
                      <input class="form-control" id="codigo" type="number" min="0"  step="1" name="codigo" placeholder="Código">
                    </div>
                  </div>
                  <div class="form-row">
                    <div class="form-group col-md-5">
                      <label for="fechaEntrega">Fecha de Entrega</label>
                      <input required="required" class="form-control" id="fecEntrega" type="text" readonly name="fecEntrega" placeholder="YYYY-MM-DD">
                    </div>
                  </div>
                  <div class="form-row">
                    <div class="form-group col-md-5">
                      <label for="nombre">Nombre</label>
                      <input required="required" class="form-control" id="nombre" type="text" name="nombre" placeholder="Nombre del proyecto">
                    </div>
                  </div>
                  <div class="form-row">
                    <div class="form-group col-md-10">
                      <label for="descripcion">Descripción</label>
                      <textarea maxlength="150" id="descripcion" name="descripcion" cols="40" rows="5" required="required" class="form-control" placeholder="Descripción del proyecto"></textarea>
                    </div>
                  </div>
                </div>
                <input id="peticion" name="peticion" type="hidden" value="insPro">
              </form>

            </div>
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
      var m = "modPro";
      var d = "delPro";
      var i = "insPro";

      if (p === m && r == 1) {
        //activa alert de modificacion
        $("<div class=\"container alert alert-success alert-dismissible fade show\" role=\"alert\" style=\"margin-top: 25px; text-align: center; margin-bottom: 25px;\">  <strong>Modificación realizada correctamente.</strong>&nbsp;&nbsp;<i class=\"fas fa-check\"></i> <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">    <span aria-hidden=\"true\">&times;</span>  </button></div>").insertAfter(".btn-add");
      } else if (p === m && r != 1) {
        $("<div class=\"container alert alert-danger alert-dismissible fade show\" role=\"alert\" style=\"margin-top: 25px; text-align: center; margin-bottom: 25px;\">  <strong>La modificación no se ha realizado.</strong>&nbsp;&nbsp;<i class=\"fas fa-times\"></i> <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">    <span aria-hidden=\"true\">&times;</span>  </button></div>").insertAfter(".btn-add");
      }

      if (p === d && r == 1) {
        //activa alert de borrado
        $("<div class=\"container alert alert-success alert-dismissible fade show\" role=\"alert\" style=\"margin-top: 25px; text-align: center; margin-bottom: 25px;\">  <strong>Proyecto borrado.</strong>&nbsp;&nbsp;<i class=\"fas fa-check\"></i> <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">    <span aria-hidden=\"true\">&times;</span>  </button></div>").insertAfter(".btn-add");
      }
      if (p === i && r == 1) {
        //activa alert de modificacion
        $("<div class=\"container alert alert-success alert-dismissible fade show\" role=\"alert\" style=\"margin-top: 25px; text-align: center; margin-bottom: 25px;\">  <strong>Proyecto guardado correctamente.</strong>&nbsp;&nbsp;<i class=\"fas fa-check\"></i> <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">    <span aria-hidden=\"true\">&times;</span>  </button></div>").insertAfter(".btn-add");
      } else if (p === i && r != 1) {
        $("<div class=\"container alert alert-danger alert-dismissible fade show\" role=\"alert\" style=\"margin-top: 25px; text-align: center; margin-bottom: 25px;\">  <strong>No se ha guardado el proyecto, revisa los campos.</strong>&nbsp;&nbsp;<i class=\"fas fa-times\"></i> <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">    <span aria-hidden=\"true\">&times;</span>  </button></div>").insertAfter(".btn-add");
      }

    </script>

    <script>
      var elements = document.getElementsByName("fecEntrega");
      for (var i = 0; i < elements.length; i++) {
        addDatePicker(elements[i].id);
      }
      function addDatePicker(id) {
        $('#' + id).datepicker({
          format: 'yyyy-mm-dd',
          uiLibrary: 'bootstrap4'
        });
      }

    </script>

  </body>
</html>
