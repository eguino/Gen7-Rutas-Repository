<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="com.eguino.app.rutas.models.*" %>

<%
//recuperamos la lista de camiones que seteamos en el request desde el servlet
List<Camion> camiones =  (List<Camion>) request.getAttribute("camiones");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-2.2.4.min.js"
        integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
        crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</head>
<body>
    <nav class="navbar navbar-inverse">
       <div class="container-fluid">
           <!-- Brand and toggle get grouped for better mobile display -->
           <div class="navbar-header" id="div1">
               <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                   data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                   <span class="sr-only">Toggle navigation</span>
                   <span class="icon-bar"></span>
                   <span class="icon-bar"></span>
                   <span class="icon-bar"></span>
               </button>
               <a class="navbar-brand" href="#" id="enlace1">Rutas App</a>
           </div>

           <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
               <ul class="nav navbar-nav">
                   <li class="dropdown">
                       <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                           aria-haspopup="true" aria-expanded="false">Choferes<span
                               class="caret"></span></a>
                       <ul class="dropdown-menu">
                           <li><a href="<%=request.getContextPath()%>/choferes/listar">Lista Choferes</a></li>
                           <li><a href="<%=request.getContextPath()%>/choferes/alta">Alta Chofer</a></li>
                       </ul>
                   </li>

                   <li class="dropdown">
                       <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                           aria-haspopup="true" aria-expanded="false">Camiones<span
                               class="caret"></span></a>
                       <ul class="dropdown-menu">
                           <li><a href="<%=request.getContextPath()%>/camiones/listar">Lista Camiones</a></li>
                           <li><a href="<%=request.getContextPath()%>/camiones/alta">Alta Camion</a></li>
                       </ul>
                   </li>

                   <li class="dropdown">
                       <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                           aria-haspopup="true" aria-expanded="false">Rutas<span
                               class="caret"></span></a>
                       <ul class="dropdown-menu">
                           <li><a href="<%=request.getContextPath()%>/rutas/alta">Alta Ruta</a></li>
                       </ul>
                   </li>
               </ul>
           </div><!-- /.navbar-collapse -->
       </div><!-- /.container-fluid -->
    </nav>

    <div class="container">
        <div class="row">
            <div class="col-6">
                <h2>Listado de Camiones</h2>
            </div>

            <div class="col-6">
                <a href="<%=request.getContextPath()%>/camiones/alta"
                    class="btn btn-success">Alta Camión</a>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="table-responsive">
                    <table class="table table-bordered table-striped" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Maticula</th>
                                <th>Tipo de Camión</th>
                                <th>Modelo</th>
                                <th>Marca</th>
                                <th>Capacidad</th>
                                <th>Kilometraje</th>
                                <th></th>
                                <th></th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for(Camion c: camiones) { %>
                                <tr>
                                    <td><%=c.getId()%></td>
                                    <td><%=c.getMatricula()%></td>
                                    <td><%=c.getTipoCamion()%></td>
                                    <td><%=c.getModelo()%></td>
                                    <td><%=c.getMarca()%></td>
                                    <td><%=c.getCapacidad()%></td>
                                    <td><%=c.getKilometraje()%></td>
                                    <td>
                                        <a href="<%=request.getContextPath()%>/camiones/detalle?id=<%=c.getId()%>" class="btn btn-success">Detalle</a>
                                    </td>
                                    <td>
                                        <a href="<%=request.getContextPath()%>/camiones/editar?id=<%=c.getId()%>" class="btn btn-primary">Editar</a>
                                    </td>
                                    <td>
                                        <a href="<%=request.getContextPath()%>/camiones/eliminar?id=<%=c.getId()%>" class="btn btn-danger">Eliminar</a>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>