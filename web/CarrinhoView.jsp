<%-- 
    Document   : produtos
    Created on : May 12, 2025, 8:22:27 PM
    Author     : bryan
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Controller.ItemCarrinho" %>
<%@ page import="Controller.Carrinho" %>
<%@ page import="Model.ManterCarrinho" %>

<%
    // Recupera o ID do cliente da sessão
    Integer idUsuario = (Integer) session.getAttribute("idUsuario");

    ArrayList<ItemCarrinho> listaCarrinho = new ArrayList<>();

    if (idUsuario != null) {
        Carrinho carrinho = new Carrinho();
        carrinho.setIdUsuario(idUsuario);

        ManterCarrinho carrinhoDAO = new ManterCarrinho();
        listaCarrinho = (ArrayList<ItemCarrinho>) carrinhoDAO.listarCarrinho(carrinho);
    } else {
        response.sendRedirect("UsuarioLoginView.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bereth - Carrinho de Compras</title>
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
            
            <h1>Carrinho de Compras</h1>
            <section class="lista-carrinho">
                <%
                    double total = 0.0;
                    // Laço para iterar pelos produtos e exibi-los
                    for (ItemCarrinho itemcarrinho : listaCarrinho) {
                    double subtotal = itemcarrinho.getSubtotal();
                    total += subtotal;
                %>
                    <div class="item">
                        <%-- Altere o src abaixo para utilizar a imagem real, se a classe possuir essa informação --%>
                        <img class="imgProduto" src="<%= itemcarrinho.getVeiculo().getImagem() %>" alt="Imagem do Produto">
                        <%-- <h3>ID: <%= produto.getId() %></h3> --%>
                        <h3>Nome: <%= itemcarrinho.getVeiculo().getModelo() %></h3>
                        <p>Preço: R$<%= itemcarrinho.getVeiculo().getPreco() %></p>
                        <p>Quantidade: <%= itemcarrinho.getQuantidade() %></p>
                        <p>Subtotal: R$<%= String.format("%.2f", subtotal) %></p>
                        <%-- Link para efetuar a compra/pedido do produto (ajuste o caminho conforme sua estrutura) --%>
                        <a href="AdicionarCarrinho?idVeiculo=<%= itemcarrinho.getVeiculo().getIdVeiculo() %>&quantidade=1" class="comprarButton">
                                <img src="assets/img/mais.png" alt="Adicionar" style="width: 32px; height: 32px;">
                        </a>
                        <% if(itemcarrinho.getQuantidade() > 1){ %>
                        <a href="DiminuirProdutoCarrinho?idVeiculo=<%= itemcarrinho.getVeiculo().getIdVeiculo() %>&quantidade=1" class="comprarButton">
                                <img src="assets/img/menos.png" alt="Diminuir" style="width: 32px; height: 32px;">
                        </a>        
                        <% }else{ %>
                        <a href="ExcluirProdutoCarrinho?idVeiculo=<%= itemcarrinho.getVeiculo().getIdVeiculo() %>&quantidade=1" class="comprarButton">
                                <img src="assets/img/lixeira.png" alt="Excluir" style="width: 32px; height: 32px;">
                        </a>  
                        <% } %>
                        
                        
                        
                    </div>
                <%
                    }
                %>
            </section>
            <!-- SEÇÃO DE TOTAL E FINALIZAÇÃO -->
            <section class="total-carrinho">
                <h2>Total da Compra: R$<%= String.format("%.2f", total) %></h2>

                <form action="pagamento" method="post">
                    <button type="submit" class="finalizarButton">
                        Finalizar Compra
                    </button>
                </form>
            </section>

        </div>
    </main>

    <footer>
            <p>&copy; 2025 Bereth. Todos os direitos reservados.</p>
        </footer>
</body>
</html>
