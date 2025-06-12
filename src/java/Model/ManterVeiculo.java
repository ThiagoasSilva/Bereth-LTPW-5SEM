/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Controller.Veiculo;
import Enuns.CategoriaVeiculo;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author thiagosilva
 */
public class ManterVeiculo extends DAO {

    public boolean inserirVeiculo(Veiculo veiculo) throws Exception {
        try {
            abrirBanco();
            String sql = "INSERT INTO veiculo (categoria, marca, modelo, cor, rodas, motorizacao, pesoKg, capacidadeTanqueL, assentos, anoFabricacao, anoModelo, placa, chassi, preco, imagem) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pst = con.prepareStatement(sql);
            pst.setString(1, veiculo.getCategoriaVeiculo().name());
            pst.setString(2, veiculo.getMarca());
            pst.setString(3, veiculo.getModelo());
            pst.setString(4, veiculo.getCor());
            pst.setInt(5, veiculo.getRodas());
            pst.setFloat(6, veiculo.getMotorizacao());
            pst.setFloat(7, veiculo.getPesoKg());
            pst.setFloat(8, veiculo.getCapacidadeTanque());
            pst.setInt(9, veiculo.getAssentos());
            pst.setInt(10, veiculo.getAnoFabricacao());
            pst.setInt(11, veiculo.getAnoModelo());
            pst.setString(12, veiculo.getPlaca());
            pst.setString(13, veiculo.getChassi());
            pst.setDouble(14, veiculo.getPreco());
            pst.setString(15, veiculo.getImagem());
            System.out.println("Imagem recebida: " + veiculo.getImagem());
            System.out.println("Preço: " + veiculo.getPreco());

            int linhasAfetadas = pst.executeUpdate();

            return linhasAfetadas > 0;
        } catch (Exception e) {
            System.out.println("Erro SQL ao inserir veiculo: " + e.getMessage());
            e.printStackTrace();
            return false;

        } finally {
            try {
                fecharBanco();
            } catch (Exception e) {
                System.out.println("Erro ao fechar recursos (inserirVeiculo): " + e.getMessage());
            }
        }
    }

    public List<Veiculo> listarVeiculos() throws Exception {
        List<Veiculo> lista = new ArrayList<>();
        try {
            abrirBanco();
            String sql = "SELECT * FROM veiculo order by idVeiculo desc";
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();

            while (rs.next()) {
                Veiculo v = new Veiculo();
                v.setIdVeiculo(rs.getInt("idVeiculo"));
                v.setCategoriaVeiculo(CategoriaVeiculo.valueOf(rs.getString("categoria")));
                v.setMarca(rs.getString("marca"));
                v.setModelo(rs.getString("modelo"));
                v.setCor(rs.getString("cor"));
                v.setRodas(rs.getInt("rodas"));
                v.setMotorizacao(rs.getFloat("motorizacao"));
                v.setPesoKg(rs.getFloat("pesoKg"));
                v.setCapacidadeTanque(rs.getFloat("capacidadeTanqueL"));
                v.setAssentos(rs.getInt("assentos"));
                v.setAnoFabricacao(rs.getInt("anoFabricacao"));
                v.setAnoModelo(rs.getInt("anoModelo"));
                v.setPlaca(rs.getString("placa"));
                v.setChassi(rs.getString("chassi"));
                v.setImagem(rs.getString("imagem"));
                v.setPreco(rs.getDouble("preco"));
                lista.add(v);
            }
            fecharBanco();
        } catch (Exception e) {
            System.out.println("Erro " + e.getMessage());
        }
        return lista;
    }

    public Veiculo buscarIdVeiculo(int idVeiculo) {

        try {
            Veiculo veiculo = new Veiculo();
            abrirBanco();
            String query = "SELECT idVeiculo, categoria, marca, modelo, cor, rodas, motorizacao, pesoKg, capacidadeTanque, assentos, anoFabricacao, anoModelo, placa, chassi, preco, imagem FROM veiculo WHERE idVeiculo = ?";
            pst = con.prepareStatement(query);
            pst.setInt(1, idVeiculo);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                veiculo.setIdVeiculo(rs.getInt("idVeiculo"));

                try {
                    veiculo.setCategoriaVeiculo(CategoriaVeiculo.valueOf(rs.getString("categoria")));
                } catch (IllegalArgumentException e) {
                    System.err.println("Categoria inválida para o veículo ID " + idVeiculo + ": '" + rs.getString("categoria") + "'.");
                    veiculo.setCategoriaVeiculo(CategoriaVeiculo.Carro); // Valor padrão
                }

                veiculo.setMarca(rs.getString("marca"));
                veiculo.setModelo(rs.getString("modelo"));
                veiculo.setCor(rs.getString("cor"));
                veiculo.setRodas(rs.getInt("rodas"));
                veiculo.setMotorizacao(rs.getFloat("motorizacao"));
                veiculo.setPesoKg(rs.getFloat("pesoKg"));
                veiculo.setCapacidadeTanque(rs.getFloat("capacidadeTanque"));
                veiculo.setAssentos(rs.getInt("assentos"));
                veiculo.setAnoFabricacao(rs.getInt("anoFabricacao"));
                veiculo.setAnoModelo(rs.getInt("anoModelo"));
                veiculo.setPlaca(rs.getString("placa"));
                veiculo.setChassi(rs.getString("chassi"));
                veiculo.setImagem(rs.getString("imagem"));
                veiculo.setPreco(rs.getDouble("preco"));

                return veiculo;
            }

            fecharBanco();
        } catch (Exception e) {
            System.err.println("Erro SQL ao buscar veículo por ID: " + e.getMessage());
            e.printStackTrace();
        } finally {
            System.out.println("Execução da Query de busca por ID (veículo) finalizada");
        }

        return null;
    }

    public boolean alterarVeiculo(Veiculo v) {
        try {
            abrirBanco();
            String query = "UPDATE veiculo SET categoriaVeiculo = ?, marca = ?, modelo = ?, cor = ?, rodas = ?, "
                    + "motorizacao = ?, pesoKg = ?, capacidadeTanque = ?, assentos = ?, "
                    + "anoFabricacao = ?, anoModelo = ?, placa = ?, chassi = ? "
                    + "WHERE idVeiculo = ?";

            pst = con.prepareStatement(query);
            pst.setString(1, v.getCategoriaVeiculo().name()); // Enum convertido para String
            pst.setString(2, v.getMarca());
            pst.setString(3, v.getModelo());
            pst.setString(4, v.getCor());
            pst.setInt(5, v.getRodas());
            pst.setFloat(6, v.getMotorizacao());
            pst.setFloat(7, v.getPesoKg());
            pst.setFloat(8, v.getCapacidadeTanque());
            pst.setInt(9, v.getAssentos());
            pst.setInt(10, v.getAnoFabricacao());
            pst.setInt(11, v.getAnoModelo());
            pst.setString(12, v.getPlaca());
            pst.setString(13, v.getChassi());
            pst.setInt(14, v.getIdVeiculo());

            int linhasAfetadas = pst.executeUpdate();

            fecharBanco();
            return linhasAfetadas > 0;

        } catch (Exception e) {
            System.out.println("Erro ao alterar veículo: " + e.getMessage());
            e.printStackTrace();
            return false;
        }

    }

    public void deletarVeiculo(Veiculo veiculo) {
        try {
            abrirBanco();
            String query = "DELETE FROM veiculo WHERE idVeiculo = ?";
            pst = con.prepareStatement(query);
            pst.setInt(1, veiculo.getIdVeiculo());
            pst.execute();
            fecharBanco();

        } catch (Exception e) {
            System.out.println("Erro " + e.getMessage());
        }
    }
}
