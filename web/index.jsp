<%-- 
    Document   : index
    Created on : 21 de mai. de 2025, 22:42:03
    Author     : thiagosilva
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link rel="icon" type="image/x-icon" href="assets/img/antonios-logo.png">
        <link rel="stylesheet" href="assets/style/index.css"/>
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
                    <li><a href="AltUsuario">Alterar dados</a></li>
                </ul>
                <div class="nav-auth-buttons">
                    <%
                        boolean logado = session.getAttribute("nome") != null;
                        Enuns.Acesso acessoUsuario = (Enuns.Acesso) session.getAttribute("acesso");

                        // Verifica se é afmin
                        boolean isAdmin = logado && (acessoUsuario == Enuns.Acesso.Administrador);
                    %>

                    <% if (logado) {%>
                    <a href="DeslogarUsuario" class="btn btn-logout">Sair</a>
                    <%} else {%>
                    <a href="UsuarioLoginView.jsp" class="btn btn-login-nav">Login</a>
                    <a href="UsuarioCadastroView.jsp" class="btn btn-secondary btn-register-nav">Cadastre-se</a>
                    <%}%>
                </div>
            </nav>
        </header>

        <main class="content-wrapper"> 
            <% if (logado) {%>
            <div class="user-info-section">
                <p class="welcome-message success-message">Bem vindo, <strong><%=session.getAttribute("acesso")%></strong>!</p>

                <% if (isAdmin) {%>
                <a href="VeiculoCadastroView.jsp" data-toggle="modal" data-target="#modalCadastrar" class="btn btn-primary btn-add-news">Cadastrar Veículo</a>
                <% } %>
            </div>
            <% } else {%>
            <div class="user-info-section">
                <div class="info-message error-message">
                    Autentique-se para ver mais opções!
                </div>
            </div>
            <% }%>

            <section class="hero-section">
                <h1>Encontre o seu veículo ideal</h1>
                <p>A maior variedade de carros novos e seminovos para você!</p>
                <a href="ListaVeiculo" class="btn btn-primary">Ver Catálogo</a>
            </section>

            <section class="featured-cars">
                <h2>Carros em Destaque</h2>
                <div class="car-grid">
                    <div class="car-item">
                        <img src="img/carro_exemplo.jpg" alt="Carro Exemplo">
                        <h3>Nome do Carro</h3>
                        <p>Preço: R$ XXXXX</p>
                        <a href="#" class="btn btn-view-details">Ver Detalhes</a>
                    </div>
                    <div class="car-item">
                        <img src="img/carro_exemplo2.jpg" alt="Carro Exemplo 2">
                        <h3>Nome do Carro 2</h3>
                        <p>Preço: R$ YYYYY</p>
                        <a href="#" class="btn btn-view-details">Ver Detalhes</a>
                    </div>
                </div>
            </section>

            <section class="about-promo">
                <h2>Sobre a Bereth</h2>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                <a href="sobre.jsp" class="btn btn-secondary">Saiba Mais</a>
            </section>

        </main>

        <footer>
            <p>&copy; 2025 Bereth. Todos os direitos reservados.</p>
        </footer>
    </body>
</html>