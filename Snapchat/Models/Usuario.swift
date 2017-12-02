//
//  Usuario.swift
//  Snapchat
//
//  Created by Rodrigo Abreu on 02/12/2017.
//  Copyright © 2017 Rodrigo Abreu. All rights reserved.
//

import Foundation

class Usuario{
    
    var email: String
    var nome: String
    var uid: String
    
    init(email: String, nome:String, uid:String){
        self.email = email
        self.nome = nome
        self.uid = uid
    }
    
}
