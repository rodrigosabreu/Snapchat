//
//  Alerta.swift
//  Snapchat
//
//  Created by Rodrigo Abreu on 02/12/2017.
//  Copyright © 2017 Rodrigo Abreu. All rights reserved.
//

import UIKit

class Alerta{
    
    var titulo: String
    var mensagem: String
    
    init(titulo: String, mensagem: String){
        self.titulo = titulo
        self.mensagem = mensagem
    }
    
    func getAlerta() -> UIAlertController{
        
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alerta.addAction( acaoCancelar )
        return alerta
    }
    
}
