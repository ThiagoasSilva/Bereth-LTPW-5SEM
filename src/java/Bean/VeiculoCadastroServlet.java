package Bean;

import Controller.Veiculo;
import Enuns.CategoriaVeiculo;
import Model.ManterVeiculo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.nio.file.Paths;
import java.util.UUID;

// Define um diretório temporário para uploads.
// ESTE DIRETÓRIO DEVE EXISTIR E TER PERMISSÕES DE ESCRITA PARA O GLASSFISH.
// Ex: C:\\temp\\uploads (no Windows)
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50,   // 50MB
                 location = "C:\\temp\\uploads") // <--- MANTENHA ESTE CAMINHO DO DIRETÓRIO TEMPORÁRIO AQUI
public class VeiculoCadastroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Criar objeto Veiculo (mesma lógica)
        Veiculo v = new Veiculo();
        String categoriaParam = request.getParameter("categoriaVeiculo");
        if (categoriaParam != null && !categoriaParam.trim().isEmpty()) {
            v.setCategoriaVeiculo(CategoriaVeiculo.fromString(categoriaParam));
        } else {
            request.setAttribute("mensagemErro", "A categoria do veículo é obrigatória.");
            request.getRequestDispatcher("VeiculoCadastroView.jsp").forward(request, response);
            return;
        }

        v.setMarca(request.getParameter("marca"));
        v.setModelo(request.getParameter("modelo"));
        v.setCor(request.getParameter("cor"));

        try {
            v.setRodas(Integer.parseInt(request.getParameter("rodas")));
            v.setMotorizacao(Float.parseFloat(request.getParameter("motorizacao")));
            v.setPesoKg(Float.parseFloat(request.getParameter("pesoKg")));
            v.setCapacidadeTanque(Float.parseFloat(request.getParameter("capacidadeTanque")));
            v.setAssentos(Integer.parseInt(request.getParameter("assentos")));
            v.setAnoFabricacao(Integer.parseInt(request.getParameter("anoFabricacao")));
            v.setAnoModelo(Integer.parseInt(request.getParameter("anoModelo")));
            v.setPreco(Double.parseDouble(request.getParameter("preco")));
        } catch (NumberFormatException e) {
            request.setAttribute("mensagemErro", "Erro de formato numérico em um dos campos: " + e.getMessage());
            request.getRequestDispatcher("VeiculoCadastroView.jsp").forward(request, response);
            return;
        }
        v.setPlaca(request.getParameter("placa"));
        v.setChassi(request.getParameter("chassi"));

        // 2. Capturar upload e salvar a imagem
        Part imagemPart = request.getPart("imagem");
        String fileName = Paths.get(imagemPart.getSubmittedFileName()).getFileName().toString();
        String uniqueName = UUID.randomUUID().toString() + "_" + fileName;

        // O arquivo será salvo automaticamente no 'location' definido em @MultipartConfig
        // por isso, Part.write() precisa apenas do nome do arquivo.
        // O Part.write() DEVE APENAS receber o nome do arquivo, e ele o salvará no diretório temporário configurado.
        try {
            // AQUI É A MUDANÇA CRÍTICA: passe APENAS o nome do arquivo
            imagemPart.write(uniqueName); // <--- AQUI! Ele salvará no C:\temp
        } catch (IOException e) {
            e.printStackTrace();
            request.setAttribute("mensagemErro", "Erro ao salvar a imagem temporariamente: " + e.getMessage());
            request.getRequestDispatcher("VeiculoCadastroView.jsp").forward(request, response);
            return;
        }

        // Agora, construa o caminho completo para o arquivo temporário
        // Usamos getPart().getSubmittedFileName() para obter o nome original
        // e, como Part.write(uniqueName) salvou no diretório temporário,
        // precisamos saber onde ele está para movê-lo.
        // O diretório temporário é o 'location' da anotação MultipartConfig.
        String tempUploadLocation = getServletContext().getRealPath("/WEB-INF/temp-uploads"); // <--- AQUI FOI O ERRO, AGORA ONDE O PART.WRITE() REALMENTE SALVA O ARQUIVO
        // CORREÇÃO: O local é o que foi configurado no @MultipartConfig!
        File tempFile = new File("C:\\temp\\uploads", uniqueName); // <--- Correção aqui! Use o mesmo location da anotação.

        // Agora, mova o arquivo do diretório temporário para o diretório final de assets
        String finalUploadPath = getServletContext().getRealPath("/assets/img/veiculos");
        File finalUploadDir = new File(finalUploadPath);
        if (!finalUploadDir.exists()) {
            finalUploadDir.mkdirs();
        }

        File finalDestFile = new File(finalUploadDir, uniqueName);

        try {
            // Agora sim, move o arquivo do tempFile (que está em C:\te) para o destino final.
            Files.copy(tempFile.toPath(), finalDestFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            // Opcional: deletar o arquivo temporário após a cópia
            tempFile.delete();
        } catch (IOException e) {
            e.printStackTrace();
            request.setAttribute("mensagemErro", "Erro ao mover a imagem para o diretório final: " + e.getMessage());
            request.getRequestDispatcher("VeiculoCadastroView.jsp").forward(request, response);
            return;
        }

        // Salva o caminho relativo para o banco de dados
        v.setImagem("assets/img/veiculos/" + uniqueName);

        // 3. Persistir no banco
        ManterVeiculo dao = new ManterVeiculo();
        try {
            boolean ok = dao.inserirVeiculo(v);
            if (ok) {
                request.setAttribute("mensagemSucesso", "Veículo cadastrado com sucesso!");
            } else {
                request.setAttribute("mensagemErro", "Erro ao cadastrar veículo no banco de dados.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensagemErro", "Erro ao cadastrar veículo: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("VeiculoCadastroView.jsp").forward(request, response);
        }
    }
}