<%-- 
    Document   : VeiculoAlterarView
    Created on : 1 de jun. de 2025, 20:26:03
    Author     : thiagosilva
--%>

<%@page import="Controller.Veiculo"%>
<%@page import="Enuns.CategoriaVeiculo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Alterar Dados do Veículo - Bereth</title>
        <link rel="icon" type="image/x-icon" href="assets/img/antonios-logo.png">
        <link rel="stylesheet" href="assets/style/index.css"/>
        <link rel="stylesheet" href="assets/style/VeiculoCadastroView.css"/>
    </head>
    <body>
        <header>
            <nav class="navbar">
                <div class="logo">
                    <img src="assets/img/antonios-logo.png" alt="logotipo" width="50px" height="50px" />
                    <a href="index.jsp">Bereth</a>
                </div>
                <ul class="nav-links">
                    <li><a href="index.jsp">Início</a></li>
                    <li><a href="ListaVeiculo">Catálogo</a></li>
                    <li><a href="CarrinhoView.jsp">Carrinho</a></li> 
                    <li><a href="PedidosView.jsp">Pedidos</a></li>
                    <li><a href="AltVeiculo">Alterar dados</a></li> 
                </ul>
                <div class="nav-auth-buttons">
                    <%
                        boolean logado = session.getAttribute("nome") != null;
                    %>
                    <% if (logado) { %>
                    <a href="DeslogarUsuario" class="btn btn-logout">Sair</a>
                    <% } else { %>
                    <a href="UsuarioLoginView.jsp" class="btn btn-login-nav">Login</a>
                    <a href="UsuarioCadastroView.jsp" class="btn btn-secondary btn-register-nav">Cadastre-se</a>
                    <% } %>
                </div>
            </nav>
        </header>

        <main class="content-wrapper">
            <div class="form-container">
                <div class="form-header">
                    <h2>Alterar Dados do Veículo</h2>
                </div>

                <%
                    String mensagemErro = (String) request.getAttribute("mensagemErro");
                    String mensagemSucesso = (String) request.getAttribute("mensagemSucesso");
                %>
                <% if (mensagemErro != null) {%>
                <div class="info-message error-message"><%= mensagemErro%></div>
                <% } else if (mensagemSucesso != null) {%>
                <div class="info-message success-message"><%= mensagemSucesso%></div>
                <% } %>

                <%
                    Veiculo veiculo = (Veiculo) request.getAttribute("veiculo");

                    int idVeiculo = veiculo != null ? veiculo.getIdVeiculo() : 0;
                    String categoria = veiculo != null && veiculo.getCategoriaVeiculo() != null ? veiculo.getCategoriaVeiculo().name() : "";
                    String marca = veiculo != null ? veiculo.getMarca() : "";
                    String modelo = veiculo != null ? veiculo.getModelo() : "";
                    String cor = veiculo != null ? veiculo.getCor() : "";
                    String rodas = veiculo != null ? String.valueOf(veiculo.getRodas()) : "";
                    String motorizacao = veiculo != null ? String.valueOf(veiculo.getMotorizacao()) : "";
                    String pesoKg = veiculo != null ? String.valueOf(veiculo.getPesoKg()) : "";
                    String capacidadeTanque = veiculo != null ? String.valueOf(veiculo.getCapacidadeTanque()) : "";
                    String assentos = veiculo != null ? String.valueOf(veiculo.getAssentos()) : "";
                    String anoFabricacao = veiculo != null ? String.valueOf(veiculo.getAnoFabricacao()) : "";
                    String anoModelo = veiculo != null ? String.valueOf(veiculo.getAnoModelo()) : "";
                    String placa = veiculo != null ? veiculo.getPlaca() : "";
                    String chassi = veiculo != null ? veiculo.getChassi() : "";
                %>

                <form action="AltVeiculo" method="post" class="cadastro-form">
                    <input type="hidden" name="idVeiculo" value="<%= idVeiculo%>">

                    <div class="textfield">
                        <label for="categoriaVeiculo">Categoria do Veículo:</label>
                        <select id="categoriaVeiculo" name="categoriaVeiculo" required>
                            <option value="">Selecione a Categoria</option>
                            <option value="CARRO" <%= "CARRO".equals(categoria) ? "selected" : ""%>>Carro</option>
                            <option value="MOTO" <%= "MOTO".equals(categoria) ? "selected" : ""%>>Moto</option>
                        </select>
                    </div>

                    <div class="textfield">
                        <label for="marca">Marca:</label>
                        <input type="text" id="marca" name="marca" value="<%= marca%>" required>
                    </div>

                    <div class="textfield">
                        <label for="modelo">Modelo:</label>
                        <input type="text" id="modelo" name="modelo" value="<%= modelo%>" required>
                    </div>

                    <div class="textfield">
                        <label for="cor">Cor:</label>
                        <input type="text" id="cor" name="cor" value="<%= cor%>" required>
                    </div>

                    <div class="textfield">
                        <label for="rodas">Número de Rodas:</label>
                        <input type="number" id="rodas" name="rodas" value="<%= rodas%>" min="1" required>
                    </div>

                    <div class="textfield">
                        <label for="motorizacao">Motorização (Litros):</label>
                        <input type="number" id="motorizacao" name="motorizacao" step="0.1" value="<%= motorizacao%>" required>
                    </div>

                    <div class="textfield">
                        <label for="pesoKg">Peso (Kg):</label>
                        <input type="number" id="pesoKg" name="pesoKg" value="<%= pesoKg%>" required>
                    </div>

                    <div class="textfield">
                        <label for="capacidadeTanque">Capacidade do Tanque (Litros):</label>
                        <input type="number" id="capacidadeTanque" name="capacidadeTanque" step="0.1" value="<%= capacidadeTanque%>" required>
                    </div>

                    <div class="textfield">
                        <label for="assentos">Número de Assentos:</label>
                        <input type="number" id="assentos" name="assentos" value="<%= assentos%>" required>
                    </div>

                    <div class="textfield">
                        <label for="anoFabricacao">Ano de Fabricação:</label>
                        <input type="number" id="anoFabricacao" name="anoFabricacao" value="<%= anoFabricacao%>" min="1900" max="<%= java.time.Year.now().getValue()%>" required>
                    </div>

                    <div class="textfield">
                        <label for="anoModelo">Ano do Modelo:</label>
                        <input type="number" id="anoModelo" name="anoModelo" value="<%= anoModelo%>" min="1900" max="<%= java.time.Year.now().getValue() + 1%>" required>
                    </div>

                    <div class="textfield">
                        <label for="placa">Placa:</label>
                        <input type="text" id="placa" name="placa" value="<%= placa%>" maxlength="7" pattern="[A-Z]{3}[0-9][0-9A-Z][0-9]{2}" required>
                    </div>

                    <div class="textfield">
                        <label for="chassi">Número do Chassi:</label>
                        <input type="text" id="chassi" name="chassi" value="<%= chassi%>" maxlength="17" required>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Salvar Alterações</button>
                        <button type="button" class="btn btn-secondary" onclick="window.location.href = 'ListaVeiculo'">Cancelar</button>
                    </div>
                </form>
            </div>
        </main>

        <footer>
            <p>&copy; 2025 Agiliza Veículos. Todos os direitos reservados.</p>
        </footer>
    </body>
</html>
