<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.*" %>

<%
    Map<String, String> errores = (Map<String,String>) request.getAttribute("errores");
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
            <div class="col-12">
                <h2>Formulario Alta Chofer</h2>
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
            <form action="<%=request.getContextPath()%>/choferes/alta" method="post">
                <div class="col-md-12">
                    <div class="form-group">
                        <label for="">Nombre</label>
                        <input type="text" name="nombre" id="nombre"
                            class="form-control" value="${param.nombre}">
                            <%
                                if(errores != null && errores.containsKey("nombre")){
                                    out.println("<span class='text-danger'>" + errores.get("nombre")
                                        + "</span>");
                                }
                            %>
                    </div>

                    <div class="form-group">
                        <label for="">Apellido Paterno</label>
                        <input type="text" name="apPaterno" id="apPaterno"
                            class="form-control" value="${param.apPaterno}">
                            <%
                                if(errores != null && errores.containsKey("apPaterno")){
                                    out.println("<span class='text-danger'>" + errores.get("apPaterno")
                                        + "</span>");
                                }
                            %>
                    </div>

                    <div class="form-group">
                        <label for="">Apellido Materno</label>
                        <input type="text" name="apMaterno" id="apMaterno"
                            class="form-control" value="${param.apMaterno}">
                            <%
                                if(errores != null && errores.containsKey("apMaterno")){
                                    out.println("<span class='text-danger'>" + errores.get("apMaterno")
                                        + "</span>");
                                }
                            %>
                    </div>

                    <div class="form-group">
                        <label for="">Licencia</label>
                        <input type="text" name="licencia" id="licencia"
                            class="form-control" value="${param.licencia}">
                            <%
                                if(errores != null && errores.containsKey("licencia")){
                                    out.println("<span class='text-danger'>" + errores.get("licencia")
                                        + "</span>");
                                }
                            %>
                    </div>

                    <div class="form-group">
                        <label for="">Teléfono</label>
                        <input type="text" name="telefono" id="telefono"
                            class="form-control" value="${param.telefono}">
                            <%
                                if(errores != null && errores.containsKey("telefono")){
                                    out.println("<span class='text-danger'>" + errores.get("telefono")
                                        + "</span>");
                                }
                            %>
                    </div>

                    <div class="form-group">
                        <label for="">Fecha de Nacimiento</label>
                        <input type="text" name="fechaNacimiento" id="fechaNacimiento"
                            class="form-control" value="${param.fechaNacimiento}">
                            <%
                                if(errores != null && errores.containsKey("fechaNacimiento")){
                                    out.println("<span class='text-danger'>" + errores.get("fechaNacimiento")
                                        + "</span>");
                                }
                            %>
                    </div>

                    <div class="form-group">
                        <label for="">Disponibilidad</label>
                        <input type="checkbox" name="disponibilidad" id="disponibilidad"
                            class="form-check-input" value="${param.disponibilidad}">
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