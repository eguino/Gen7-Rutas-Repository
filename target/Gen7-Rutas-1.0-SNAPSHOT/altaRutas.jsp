<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="com.eguino.app.rutas.models.*" %>

<%
    //recuperamos la lista de choferes que seteamos en el request desde el servlet
    List<Chofer> choferes =  (List<Chofer>) request.getAttribute("choferes");
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
    <style>
        .loader {
            position: fixed;
            left: 0px;
            top: 0px;
            width: 100%;
            height: 100%;
            z-index: 9999;
            background: url('https://www.slashcoding.com/wp-content/uploads/2014/03/page-loader.gif') 50% 50% no-repeat rgb(249,249,249);
            opacity: .8;
        }
    </style>
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

    <div class="container body-content">
        <script src="//maps.googleapis.com/maps/api/js?key=AIzaSyCWeeateTaYGqsHhNcmoDfT7Us-vLDZVPs&amp;sensor=false&amp;language=en"></script>


        <div class="row">
            <div class="col-md-12">
                <h2>Iniciar Ruta</h2>
            </div>
            <div style="display: block;"><input type="hidden" name="" id="txtEsOD"></div>
        </div>
        <form id="formRuta" action="<%=request.getContextPath()%>/rutas/alta" method="post">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="">Chofer</label>
                        <select name="chofer" id="chofer" class="form-control">
                            <option value="">Seleccionar</option>
                            <% for (Chofer c: choferes) { %>
                                <option value="<%=c.getId()%>"><%=c.getNombre()%></option>
                            <% } %>
                        </select>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-9">
                                <label for="">Origen</label>
                                <input type="text" name="origen" id="origen" class="form-control">
                                <input type="hidden" name="idOrigen" id="idOrigen" class="form-control">
                            </div>

                            <!-- <div class="col-md-3">
                                <button class="btn btn-primary btn-xs" style="margin-top: 30px;"
                                    onclick="getDireccion(1)">Obtener Datos</button>
                            </div> -->
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-9">
                                <label for="">Seleccionar Origen</label>
                                <select name="origenSelect" id="origenSelect" class="form-control">
                                    <option value="">---Seleccionar---</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="">Fecha Salida</label>
                        <div class="input-group date">
                            <input type="text" name="FSalida" id="FSalida" class="form-control" value="${param.FSalida}">
                            <div class="input-group-addon">
                                <span class="glyphicon glyphicon-th"></span>
                            </div>
                        </div>
                        <!-- <input type="date" name="FSalida" id="FSalida"
                        class="form-control" onkeydown="return false"> -->
                    </div>

                    <div class="form-group">
                        <label for="">Distancia</label>
                        <input type="text" name="distancia" id="distancia" class="form-control">
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label for="">Camion</label>
                        <select name="camion" id="camion" class="form-control">
                            <option value="">Seleccionar</option>
                            <% for (Camion c: camiones) { %>
                                <option value="<%=c.getId()%>"><%=c.getMatricula()%></option>
                            <% } %>
                        </select>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-9">
                                <label for="">Destino</label>
                                <input type="text" name="destino" id="destino" class="form-control">
                                <input type="hidden" name="idDestino" id="idDestino" class="form-control">
                            </div>

                            <!-- <div class="col-md-3">
                                <button class="btn btn-primary btn-xs" style="margin-top: 30px;"
                                    onclick="getDireccion(2)">Obtener Datos</button>
                            </div> -->
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-9">
                                <label for="">Seleccionar Destino</label>
                                <select name="destinoSelect" id="destinoSelect" class="form-control">
                                    <option value="">Seleccionar</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="">Fecha Estimada de Llegada</label>
                        <div class="input-group date">
                            <input type="text" name="FELlegada" id="FELlegada" class="form-control" value="${param.FELlegada}">
                            <div class="input-group-addon">
                                <span class="glyphicon glyphicon-th"></span>
                            </div>
                        </div>
                        <!-- <input type="date" name="FELlegada" id="FELlegada"
                        class="form-control" onkeydown="return false"> -->
                    </div>

                    <div class="form-group">
                        <label for="">Capacidad Camión</label>
                        <input type="text" name="capCamion" id="capCamion" class="form-control">
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <input type="hidden" name="duracion" id="duracion" class="form-control">
                        </div>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn btn-success">Iniciar Ruta</button>
                    </div>
                </div>
            </div>
            <input type="hidden" name="cargamentos" id="cargamentos">
        </form>


        <div class="row">
            <div class="col-md-12">
                <h3>Cargamento</h3>
                <div class="form-group">
                    <label for="descripcion">Descripción</label>
                    <input type="text" id="descripcion" class="form-control">
                </div>
                <div class="form-group">
                    <label for="peso">Peso</label>
                    <input type="number" id="peso" class="form-control">
                </div>
                <button class="btn btn-primary" onclick="agregarCargamento()">Agregar</button>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <h4>Lista de Cargamento</h4>
                <table class="table table-bordered" id="tablaCargamento">
                    <thead>
                        <tr>
                            <th>Descripción</th>
                            <th>Peso</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="modal fade" id="myModal" role="dialog">
    <<div class="loader"></div>>
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="row">
                        <div class="col-md-12">
                            <h4>Guardar Direccion</h4>
                        </div>
                    </div>
                </div>

                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="">Calle</label>
                                <input type="text" name="Calle" id="Calle" class="form-control">
                            </div>

                            <div class="form-group">
                                <label for="">Numero</label>
                                <input type="text" name="Numero" id="Numero" class="form-control">
                            </div>

                            <div class="form-group">
                                <label for="">Colonia</label>
                                <input type="text" name="Colonia" id="Colonia" class="form-control">
                            </div>

                            <div class="form-group">
                                <label for="">Ciudad</label>
                                <input type="text" name="Ciudad" id="Ciudad" class="form-control">
                            </div>

                            <div class="form-group">
                                <label for="">Estado</label>
                                <input type="text" name="Estado" id="Estado" class="form-control">
                            </div>

                            <div class="form-group">
                                <label for="">CP</label>
                                <input type="text" name="CP" id="CP" class="form-control">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-10 col-md-offset-1">
                            <div class="col-md-4">
                                <button class="btn btn-success" onclick="btnGuardarDir()">Guardar</button>
                            </div>

                            <div class="col-md-4 col-md-offset-2">
                                <button class="btn btn-default" data-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            $('#FSalida').datepicker({
                format: 'dd/mm/yyyy', // Formato de fecha deseado
                autoclose: true,
                todayHighlight: true,
                language: 'es', // Opcional: idioma español
            });

            $('#FELlegada').datepicker({
                format: 'dd/mm/yyyy', // Formato de fecha deseado
                autoclose: true,
                todayHighlight: true,
                language: 'es', // Opcional: idioma español
            });

            // Función para cargar las direcciones en los select al cargar la página
        	cargarDirecciones();

        	// Función para obtener y cargar las direcciones desde el servidor
        	function cargarDirecciones() {
                    $.ajax({
                        type: 'GET',
                        url: "http://localhost:8080/Gen7-API/api/direcciones",
                        success: function(data) {
                            // Llenar select de origen
                            var selectOrigen = $("#origenSelect");
                            selectOrigen.empty();
                            selectOrigen.append('<option value="">Seleccionar</option>');
                            $.each(data, function(index, direccion) {
                                selectOrigen.append('<option value="' + direccion.id + '">' + direccion.calle + ' ' + direccion.numero + ', ' + direccion.colonia + ', '  + direccion.ciudad + ', ' + direccion.estado + ', ' + direccion.cp + '</option>');
                            });

                            // Llenar select de destino
                            var selectDestino = $("#destinoSelect");
                            selectDestino.empty();
                            selectDestino.append('<option value="">Seleccionar</option>');
                            $.each(data, function(index, direccion) {
                                selectDestino.append('<option value="' + direccion.id + '">' + direccion.calle + ' ' + direccion.numero + ', ' + direccion.colonia + ', '  + direccion.ciudad + ', ' + direccion.estado + ', ' + direccion.cp + '</option>');
                            });
                        },
                        error: function(xhr, status, error) {
                            console.error("Error al cargar direcciones: " + error);
                        }
                    });
                }

                // Función para manejar el cambio de opción en el select de origen
                        $("#origenSelect").change(function() {
                            var textOption = $(this).children("option:selected").text();
                            $("#origen").val(textOption);
                            var selectedOption = $(this).children("option:selected").val();
                            $("#idOrigen").val(selectedOption);
                        });

                        // Función para manejar el cambio de opción en el select de destino
                        $("#destinoSelect").change(function() {
                            var textOption = $(this).children("option:selected").text();
                            $("#destino").val(textOption);
                            var selectedOption = $(this).children("option:selected").val();
                            $("#idDestino").val(selectedOption);
                        });

                $("#origen").change(function() {
                    getDireccion(1);
                });

                $("#destino").change(function() {
                    getDireccion(2);
                });

                $("#camion").change(function() {
                    var selectedOption = $(this).val();
                    if (selectedOption) {
                        $.ajax({
                            url: "http://localhost:8080/Gen7-Rutas/capacidadCamion",
                            type: "POST",
                            data: { idCamion: selectedOption },
                            success: function(response) {
                                $("#capCamion").val(response.capacidad);
                            }
                        });
                    } else {
                        $("#capCamion").val('');
                    }
                });

                $("#origen, #destino, #origenSelect, #destinoSelect, #FSalida").change( function() {
                    calculateDistance();
                });

                function calculateDistance() {
                    var origen = $("#origen").val();
                    var destino = $("#destino").val();

                    if (origen && destino) {
                        var service = new google.maps.DistanceMatrixService();
                        service.getDistanceMatrix(
                            {
                                origins: [origen],
                                destinations: [destino],
                                travelMode: 'DRIVING',
                            }, callback);

                        function callback(response, status) {
                            if (status == 'OK') {
                                var origins = response.originAddresses;
                                var destinations = response.destinationAddresses;
                                for (var i = 0; i < origins.length; i++) {
                                    var results = response.rows[i].elements;
                                    for (var j = 0; j < results.length; j++) {
                                        var element = results[j];
                                        var distance = element.distance.text;
                                        var duration = element.duration.text;
                                        $("#distancia").val(distance);
                                        $("#duracion").val(duration);
                                        calculateArrivalDate(duration);
                                    }
                                }
                            } else {
                                alert("Error al calcular la distancia: " + status);
                            }
                        }
                    }
                }

                function calculateArrivalDate(duration) {
                    var startDate = $("#FSalida").val();
                    if (startDate && duration) {
                        var durationParts = duration.split(" ");
                        var hours = 0, minutes = 0;
                        for (var i = 0; i < durationParts.length; i++) {
                            if (durationParts[i].includes("hour") || durationParts[i].includes("hours")) {
                                hours = parseInt(durationParts[i-1]);
                            }
                            if (durationParts[i].includes("min") || durationParts[i].includes("minutes")) {
                                minutes = parseInt(durationParts[i-1]);
                            }
                        }
                        var dateParts = startDate.split("/");
                        var dateObject = new Date(dateParts[2], dateParts[1] - 1, dateParts[0]);

                        var now = new Date();
                        dateObject.setHours(now.getHours());
                        dateObject.setMinutes(now.getMinutes());

                        dateObject.setHours(dateObject.getHours() + hours);
                        dateObject.setMinutes(dateObject.getMinutes() + minutes);

                        var dd = String(dateObject.getDate()).padStart(2, '0');
                        var mm = String(dateObject.getMonth() + 1).padStart(2, '0'); // Enero es 0
                        var yyyy = dateObject.getFullYear();
                        var hh = String(dateObject.getHours()).padStart(2, '0');
                        var min = String(dateObject.getMinutes()).padStart(2, '0');

                        var formattedDate = dd + '/' + mm + '/' + yyyy;
                        $("#FELlegada").val(formattedDate);
                    }
                }

        });


        function LimpiarDatos() {
            $("#Calle").val("");
            $("#Numero").val("");
            $("#Colonia").val("");
            $("#Estado").val("");
            $("#CP").val("");
        }

        function getDireccion(fuente) {
            LimpiarDatos();
            $("#myModal").modal('show');
            var direccion = "";
            if (fuente == 1) {
                direccion = $("#origen").val();
            } else {
                direccion = $("#destino").val();
            }
            $("#txtEsOD").val(fuente);

            if (direccion != "") {
                var geocoder = new google.maps.Geocoder();
                geocoder.geocode({ 'address': direccion }, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        var numresults = results[0].address_components.length;
                        for (var indice = 0; indice < numresults; indice++) {
                            var numresultstypes = results[0].address_components[indice].types.length;

                            for (var propiedad = 0; propiedad < numresultstypes; propiedad++) {
                                var Tipo = results[0].address_components[indice].types[propiedad];
                                var Descripcion = results[0].address_components[indice].long_name;
                                switch (Tipo) {
                                    case "route":
                                        $("#Calle").val(Descripcion);
                                        break;
                                    case "street_number":
                                        $("#Numero").val(Descripcion);
                                        break;
                                    case "sublocality_level_1":
                                        $("#Colonia").val(Descripcion);
                                        break;
                                    case "locality":
                                        $("#Ciudad").val(Descripcion);
                                        break;
                                    case "administrative_area_level_1":
                                        $("#Estado").val(Descripcion);
                                        break;
                                    case "postal_code":
                                        $("#CP").val(Descripcion);
                                        break;
                                }
                            }
                        }

                        console.log(results);
                        if (results[0].address_components.length > 0) {
                            if (fuente == 1) {
                                $("#origen").val(results[0].formatted_address);
                            } else {
                                $("#destino").val(results[0].formatted_address);
                            }
                        }
                    } else {
                        alert("Google no obtuvo datos");
                    }
                });
            } else {
                alert("No podemos obtener datos si no proporciona una dirección");
                $("#myModal").modal('hide');
            }
        }

        function btnGuardarDir(){
            $(".loader").fadeIn("slow");
            var calle = $("#Calle").val();
            var numero = $("#Numero").val();
            var colonia = $("#Colonia").val();
            var ciudad = $("#Ciudad").val();
            var estado = $("#Estado").val();
            var CP = $("#CP").val();

            var mensaje;

            $.ajax({
                type: 'POST',
                url: "http://localhost:8080/Gen7-API/api/direcciones",
                data: {"calle": calle, "numero": numero, "colonia": colonia, "ciudad": ciudad,
                    "estado":estado, "cp": CP
                },
                success: function(resp){
                    console.log("Response:", resp);
                    resp = JSON.parse(resp);
                    var mensaje = resp.message;
                    $("#myModal").modal('hide');
                    if($("#txtEsOD").val() == 1){
                        $("#idOrigen").val(resp.message);  // Aquí cambias 'idOrien' a 'idOrigen'
                    } else {
                        $("#idDestino").val(resp.message);
                    }
                    $(".loader").fadeOut("slow");
                }
            });

            if (fuente == 1) {
                $("#idOrigen").val(mensaje);
            } else {
                $("#idDestino").val(mensaje);
            }
        }

        function agregarCargamento() {
            var descripcion = document.getElementById("descripcion").value;
            var peso = document.getElementById("peso").value;

            if (descripcion !== "" && peso !== "") {
                var tabla = document.getElementById("tablaCargamento").getElementsByTagName('tbody')[0];
                var nuevaFila = tabla.insertRow();

                var celdaDescripcion = nuevaFila.insertCell(0);
                var celdaPeso = nuevaFila.insertCell(1);

                celdaDescripcion.innerHTML = descripcion;
                celdaPeso.innerHTML = peso;

                document.getElementById("descripcion").value = "";
                document.getElementById("peso").value = "";
            } else {
                alert("Por favor, complete ambos campos.");
            }
        }

        function prepararEnvio() {
            var cargamentos = [];
            var filas = document.getElementById("tablaCargamento").getElementsByTagName('tbody')[0].getElementsByTagName('tr');

            for (var i = 0; i < filas.length; i++) {
                var descripcion = filas[i].cells[0].innerText;
                var peso = filas[i].cells[1].innerText;
                cargamentos.push({ descripcion: descripcion, peso: peso });
            }

            document.getElementById("cargamentos").value = JSON.stringify(cargamentos);

            console.log("Cargamentos JSON:", cargamentosJson);
        }

        document.getElementById("formRuta").addEventListener("submit", prepararEnvio);
    </script>

    <script src="https://code.jquery.com/jquery-2.2.4.min.js"
                    integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
                    crossorigin="anonymous"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


            <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>

    <script type="text/javascript">
        $(".loader").fadeOut("slow");
    </script>

</body>
</html>