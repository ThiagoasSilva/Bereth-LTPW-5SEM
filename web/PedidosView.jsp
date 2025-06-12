<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Model.ManterPedido, Controller.Pedido, Controller.ItemPedido" %>

<%
    Integer idUsuario = (Integer) session.getAttribute("idUsuario");
    List<Pedido> listaPedidos = new ArrayList<>();

    if (idUsuario != null) {
        ManterPedido pedidoDAO = new ManterPedido();
        listaPedidos = pedidoDAO.listarPedidos(idUsuario);
    } else {
        response.sendRedirect("UsuarioLoginView.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>DrogaBryan - Meus Pedidos</title>
    <link rel="stylesheet" href="assets/style/CarrinhoView.css">
    <link rel="icon" type="image/x-icon" href="../design_&_layout/logotipo/drogabryan.png">
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

<main>
    <div>
        <h1>Meus Pedidos</h1>

        <section class="lista-carrinho">
            <% if (listaPedidos.isEmpty()) { %>
                <p>Você ainda não fez nenhum pedido.</p>
            <% } else { 
                for (Pedido pedido : listaPedidos) {
            %>
                <div class="item">
                    <div style="text-align: left;">
                        <h3>Pedido #<%= pedido.getId() %></h3>
                        <p><strong>Data:</strong> <%= pedido.getDataPedido() %></p>
                        <div style="margin-top: 10px;">
                            <% for (ItemPedido item : pedido.getItens()) { %>
                                <p>
                                    <strong><%= item.getModeloVeiculo() %></strong><br>
                                    Quantidade: <%= item.getQuantidade() %><br>
                                    Subtotal: R$<%= String.format("%.2f", item.getSubtotal()) %>
                                </p>
                            <% } %>
                        </div>
                        <p><strong>Total do Pedido:</strong> R$<%= String.format("%.2f", pedido.getValorTotal()) %></p>
                    </div>
                </div>
            <% } } %>
        </section>
    </div>
</main>

<footer>
            <p>&copy; 2025 Bereth. Todos os direitos reservados.</p>
        </footer>
</body>
</html>
