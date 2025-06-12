<%-- 
    Document   : UsuarioAlterarView
    Created on : 25 de mai. de 2025, 05:15:33
    Author     : thiagosilva
--%>
<%@page import="Controller.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Enuns.Acesso"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterar Dados do Usuário - Bereth</title>
        <link rel="icon" type="image/x-icon" href="assets/img/antonios-logo.png">
        <link rel="stylesheet" href="assets/style/index.css"/>
        <link rel="stylesheet" href="assets/style/VeiculoCadastroView.css"/>
    </head>
    <body>
        <header>
            <nav class="navbar">
                <div class="logo">
                    <img src="assets/img/antonios-logo.png" alt="logotipo" width="50px" height="50px" /> <%-- Adicionado a imagem do logo que faltava --%>
                    <a href="index.jsp">Bereth</a>
                </div>
                <ul class="nav-links">
                    <li><a href="index.jsp">Início</a></li>
                    <li><a href="ListaVeiculo">Catálogo</a></li> <%-- Mudei para ListaVeiculo, que parece ser o Servlet para o catálogo --%>
                    <li><a href="CarrinhoView.jsp">Carrinho</a></li> 
                    <li><a href="PedidosView.jsp">Pedidos</a></li>
                    <li><a href="AltUsuario">Alterar dados</a></li> 
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
                    <h2>Alterar Meus Dados</h2>
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
                    Usuario usuario = (Usuario) request.getAttribute("usuario");

                    String nome = "";
                    String email = "";
                    String cpf = "";
                    String rg = "";
                    int idade = 0;
                    String nascimentoStr = ""; // Para o formato yyyy-MM-dd esperado pelo input type="date"
                    String acesso = ""; // Para o nome do ENUM (Administrador/Cliente)

                    if (usuario != null) {
                        nome = usuario.getNome() != null ? usuario.getNome() : "";
                        email = usuario.getEmail() != null ? usuario.getEmail() : "";
                        cpf = usuario.getCpf() != null ? usuario.getCpf() : "";
                        rg = usuario.getRg() != null ? usuario.getRg() : "";
                        idade = usuario.getIdade();

                        // Formata a data de nascimento
                        if (usuario.getNascimento() != null) {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            nascimentoStr = sdf.format(usuario.getNascimento());
                        }
                        acesso = usuario.getAcesso() != null ? usuario.getAcesso().name() : "";
                    }
                %>

                <form action="AltUsuario" method="post" class="cadastro-form">
                    <% if (usuario != null) {%>

                    <input type="hidden" name="idUsuario" value="<%= usuario.getIdUsuario()%>">
                    <% }%>

                    <div class="textfield">
                        <label for="nome">Nome Completo:</label>

                        <input type="text" id="nome" name="nome" value="<%= nome%>" placeholder="Seu nome completo" required>
                    </div>

                    <div class="textfield">
                        <label for="email">Email:</label>

                        <input type="email" id="email" name="email" value="<%= email%>" placeholder="seuemail@exemplo.com" required>
                    </div>

                    <div class="textfield">
                        <label for="cpf">CPF:</label>

                        <input type="text" id="cpf" name="cpf" value="<%= cpf%>" placeholder="000.000.000-00" title="Formato: 000.000.000-00" required>
                    </div>

                    <div class="textfield">
                        <label for="rg">RG:</label>

                        <input type="text" id="rg" name="rg" value="<%= rg%>" placeholder="00.000.000-0" title="Formato: 00.000.000-0" required>
                    </div>

                    <div class="textfield">
                        <label for="idade">Idade:</label>

                        <input type="number" id="idade" name="idade" value="<%= idade > 0 ? idade : ""%>" placeholder="Sua idade" min="0" required>
                    </div>

                    <div class="textfield">
                        <label for="nascimento">Data de Nascimento:</label>

                        <input type="date" id="nascimento" name="nascimento" value="<%= nascimentoStr%>" required>
                    </div>

                    <div class="textfield">
                        <label>Tipo de Acesso:</label>
                        <div class="radio-options">

                            <input type="radio" id="acesso_cliente" name="acesso" value="Cliente" <%= "Cliente".equals(acesso) ? "checked" : ""%>>
                            <label for="acesso_cliente">Cliente</label>

                            <input type="radio" id="acesso_administrador" name="acesso" value="Administrador" <%= "Administrador".equals(acesso) ? "checked" : ""%>>
                            <label for="acesso_administrador">Administrador</label>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Salvar Alterações</button>
                        <button type="button" class="btn btn-secondary" onclick="window.location.href = 'index.jsp'">Cancelar</button>
                    </div>
                </form>
            </div>
        </main>

        <footer>
            <p>&copy; 2025 Agiliza Veículos. Todos os direitos reservados.</p>
        </footer>
    </body>
</html>