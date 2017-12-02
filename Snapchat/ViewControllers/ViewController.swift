//
//  ViewController.swift
//  Snapchat
//
//  Created by Rodrigo Abreu on 01/12/2017.
//  Copyright © 2017 Rodrigo Abreu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //verificar se o usuario ja esta autenticado no firebase
        let autenticacao = Auth.auth()
        
        
        /*
        //deslogar o usuario para testes
        do{
            try autenticacao.signOut()
        }catch{
            print("Erro ao deslogar usuario")
        }
        */
        
        
        //redireciona para a tela principal caso esteja logado no firebase
        autenticacao.addStateDidChangeListener { (autenticacao, usuario) in
            if let usuarioLogado = usuario{
                self.performSegue(withIdentifier: "loginAutomaticoSegue", sender: nil)
            }
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

