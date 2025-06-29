/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package Enuns;

/**
 *
 * @author thiagosilva
 */
public enum CategoriaVeiculo {

    Sedan, 
    SUV, 
    Hatch, 
    Picape, 
    Minivan, 
    Cupê, 
    Perua, 
    Roadster, 
    Utilitário, 
    Esportiva, 
    Naked, 
    Custom, 
    Touring, 
    Big_Trail,
    Scooter, 
    Ciclomotor, 
    Motocross, 
    Enduro,
    Carro,
    Moto;
    
    public static CategoriaVeiculo fromString(String categoria) {
    for (CategoriaVeiculo c : CategoriaVeiculo.values()) {
        if (c.name().equalsIgnoreCase(categoria)) {
            return c;
        }
    }
    throw new IllegalArgumentException("Categoria inválida: " + categoria);
    }
}
