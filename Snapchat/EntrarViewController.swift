//
//  EntrarViewController.swift
//  Snapchat
//
//  Created by Rodrigo Abreu on 01/12/2017.
//  Copyright © 2017 Rodrigo Abreu. All rights reserved.
//

import UIKit
import FirebaseAuth

class EntrarViewController: UIViewController {

    
    @IBOutlet var email: UITextField!
    @IBOutlet var senha: UITextField!
    
    
   
    
    
    @IBAction func entrar(_ sender: Any) {
        
        //Recuperar dados digitados
        if let emailR = self.email.text{
            if let senhaR = self.senha.text{
                
                //Autenticar usuário no Firebase                
                let autenticacao = Auth.auth()
                autenticacao.signIn(withEmail: emailR, password: senhaR, completion: { (usuario, erro) in
                    
                    if erro == nil{
                        
                        //verificar se o usuario existe
                        if usuario == nil{
                            
                            self.exibirMensagem(titulo: "Erro ao autenticar", mensagem: "Problema ao realizar a autenticação, tente novamente.")
                            
                        }else{
                            
                            //redireciona usuario para tela principal
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                            
                        }
                        
                    }else{
                        self.exibirMensagem(titulo: "Dados incorretos.", mensagem: "Verifique os dados digitados e tente novamente!")
                    }
                    
                })
                
            }
        }
        
        
        
    }
    
    
    
    func exibirMensagem(titulo: String, mensagem: String){
        
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alerta.addAction( acaoCancelar )
        
        present(alerta, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
