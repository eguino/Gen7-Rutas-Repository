<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="com.eguino.app.rutas.models.*" %>

<%
// Recuperamos la lista de camiones que seteamos en el request desde el servlet
List<Ruta> rutas =  (List<Ruta>) request.getAttribute("rutas");
List<Chofer> choferes = (List<Chofer>) request.getAttribute("choferes");
List<Camion> camiones = (List<Camion>) request.getAttribute("camiones");
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
                           aria-haspopup="true" aria-expanded="false">Choferes<span class="caret"></span></a>
                       <ul class="dropdown-menu">
                           <li><a href="<%=request.getContextPath()%>/choferes/listar">Lista Choferes</a></li>
                           <li><a href="<%=request.getContextPath()%>/choferes/alta">Alta Chofer</a></li>
                       </ul>
                   </li>
                   <li class="dropdown">
                       <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                           aria-haspopup="true" aria-expanded="false">Camiones<span class="caret"></span></a>
                       <ul class="dropdown-menu">
                           <li><a href="<%=request.getContextPath()%>/camiones/listar">Lista Camiones</a></li>
                           <li><a href="<%=request.getContextPath()%>/camiones/alta">Alta Camion</a></li>
                       </ul>
                   </li>
                   <li class="dropdown">
                       <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                           aria-haspopup="true" aria-expanded="false">Rutas<span class="caret"></span></a>
                       <ul class="dropdown-menu">
                           <li><a href="<%=request.getContextPath()%>/rutas/alta">Alta Ruta</a></li>
                       </ul>
                   </li>
               </ul>
           </div>
       </div>
    </nav>

    <div class="container">
        <div class="row">
            <div class="col-6">
                <h2>Listado de Rutas</h2>
            </div>
            <div class="col-6">
                <a href="<%=request.getContextPath()%>/rutas/alta" class="btn btn-success">Alta Ruta</a>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="table-responsive">
                    <table class="table table-bordered table-striped" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Camion</th>
                                <th>Chofer</th>
                                <th>Dirección Origen</th>
                                <th>Dirección Destino</th>
                                <th>Fecha Salida</th>
                                <th>Fecha Llegada Est.</th>
                                <th>Fecha Llega Real</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for(int x=0; x < rutas.size(); x++) { %>
                                <tr>
                                    <td><%=rutas.get(x).getId()%></td>
                                    <td><%=camiones.get(x).getMatricula()%></td>
                                    <td><%=choferes.get(x).getNombre() + " " +choferes.get(x).getApPaterno() + " " +choferes.get(x).getApMaterno() %></td>
                                    <td data-id-origen="<%=rutas.get(x).getDireccionOrigenId()%>"></td>
                                    <td data-id-destino="<%=rutas.get(x).getDireccionDestinoId()%>"></td>
                                    <td><%=rutas.get(x).getFechaSalida()%></td>
                                    <td><%=rutas.get(x).getFechaLlegadaEstimada()%></td>
                                    <td><%=rutas.get(x).getFechaLlegadaReal() == null ? "" : rutas.get(x).getFechaLlegadaReal() %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            cargarDirecciones();

            function cargarDirecciones() {
                $.ajax({
                    type: 'GET',
                    url: "http://localhost:8080/Gen7-API/api/direcciones",
                    success: function(data) {
                        var direcciones = Array.isArray(data) ? data : JSON.parse(data);

                        $('tbody tr').each(function() {
                            var origenId = $(this).find('td[data-id-origen]').data('id-origen');
                            var destinoId = $(this).find('td[data-id-destino]').data('id-destino');

                            var origen = buscarDireccion(direcciones, origenId);
                            if (origen) {
                                $(this).find('td[data-id-origen]').text(origen);
                            }

                            var destino = buscarDireccion(direcciones, destinoId);
                            if (destino) {
                                $(this).find('td[data-id-destino]').text(destino);
                            }
                        });
                    },
                    error: function(xhr, status, error) {
                        console.error("Error al cargar direcciones: " + error);
                    }
                });
            }

            function buscarDireccion(direcciones, id) {
                for (var i = 0; i < direcciones.length; i++) {
                    if (direcciones[i].id === parseInt(id)) {
                        return direcciones[i].calle + " " + direcciones[i].numero + ", " + direcciones[i].colonia + ", " + direcciones[i].ciudad;
                    }
                }
                return null;
            }
        });
    </script>
</body>
</html>
