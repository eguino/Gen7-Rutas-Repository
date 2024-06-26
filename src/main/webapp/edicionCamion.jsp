<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="com.eguino.app.rutas.models.*" %>
<%@page import="com.eguino.app.rutas.models.enums.*" %>
<%@page import="java.time.format.*" %>

<%
    Map<String, String> errores = (Map<String,String>) request.getAttribute("errores");
    Camion camion = (Camion) request.getAttribute("camion");
    List<Tipos> tiposCamion = (List<Tipos>) request.getAttribute("tiposCamion");
    List<Marcas> marcasCamion = (List<Marcas>) request.getAttribute("marcasCamion");
    Integer minimo = (Integer) request.getAttribute("minimo");
    Integer maximo = (Integer) request.getAttribute("maximo");

    Boolean estado = camion.getDisponibilidad();
    String disponible = estado ? "Checked" : "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Camión</title>
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
            <div class="col-12">
                <h2>Editar Camión <%=camion.getId()%></h2>
            </div>
        </div>

        <br>
        <% if(errores != null && errores.size()>0){ %>
            <ul class="alert alert-danger mx-5 px5">
                <% for(String error: errores.values()){ %>
                    <li><%=error%></li>
                <% } %>
            </ul>
        <% } %>

        <div class="row">
            <form action="<%=request.getContextPath()%>/camiones/editar" method="post">
                <input type="hidden" name="id" value="<%=camion.getId()%>">
                <div class="col-md-12">
                    <div class="form-group">
                        <label for="matricula">Matricula</label>
                        <input type="text" name="matricula" id="matricula"
                            class="form-control"
                            value="<%=camion.getMatricula() != null ? camion.getMatricula() : ""%>">
                            <%
                                if(errores != null && errores.containsKey("matricula")){
                                    out.println("<span class='text-danger'>" + errores.get("matricula") + "</span>");
                                }
                            %>
                    </div>

                    <div class="form-group">
                        <label for="tipoCamion">Tipo</label>
                        <select name="tipoCamion" id="tipoCamion" class="form-control">
                            <option value="0">---Seleccionar---</option>
                            <% if (tiposCamion != null) { %>
                                <% for(Tipos tipo : tiposCamion) { %>
                                    <option value="<%= tipo.name() %>" <%= tipo.equals(camion.getTipoCamion()) ? "selected" : "" %>><%= tipo %></option>
                                <% } %>
                            <% } %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="modelo">Modelo</label>
                        <select name="modelo" id="modelo" class="form-control">
                            <option value="0">---Seleccionar---</option>
                            <% if (minimo != null && maximo != null) { %>
                                <% for(int x = minimo; x <= maximo; x++) { %>
                                    <option value="<%= x %>" <%= x == camion.getModelo() ? "selected" : "" %>><%= x %></option>
                                <% } %>
                            <% } %>
                         </select>
                    </div>

                    <div class="form-group">
                        <label for="marca">Marca</label>
                        <select name="marca" id="marca" class="form-control">
                            <option value="0">---Seleccionar---</option>
                            <% if (marcasCamion != null) { %>
                                <% for(Marcas marca : marcasCamion) { %>
                                    <option value="<%= marca.name() %>" <%= marca.equals(camion.getMarca()) ? "selected" : "" %>><%= marca %></option>
                                <% } %>
                            <% } %>
                         </select>
                    </div>

                    <div class="form-group">
                        <label for="capacidad">Capacidad</label>
                        <input type="text" name="capacidad" id="capacidad"
                            class="form-control"
                            value="<%=camion.getCapacidad() != null ? camion.getCapacidad() : ""%>">
                            <%
                                if(errores != null && errores.containsKey("capacidad")){
                                    out.println("<span class='text-danger'>" + errores.get("capacidad") + "</span>");
                                }
                            %>
                    </div>

                    <div class="form-group">
                        <label for="kilometraje">Kilometraje</label>
                        <input type="text" name="kilometraje" id="kilometraje"
                            class="form-control"
                                value="<%=camion.getKilometraje() != 0 ? camion.getKilometraje() : ""%>">
                                    <%
                                        if(errores != null && errores.containsKey("kilometraje")){
                                            out.println("<span class='text-danger'>" + errores.get("kilometraje") + "</span>");
                                        }
                                     %>
                    </div>

                    <div class="form-group">
                        <label for="disponibilidad">Disponibilidad</label>
                        <input type="checkbox" name="disponibilidad" id="disponibilidad"
                            class="form-check-input" value="1" <%=disponible%> >
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn btn-success">Guardar</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
