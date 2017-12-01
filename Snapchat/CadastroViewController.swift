//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by Rodrigo Abreu on 01/12/2017.
//  Copyright © 2017 Rodrigo Abreu. All rights reserved.
//

import UIKit
import FirebaseAuth

class CadastroViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var senha: UITextField!
    @IBOutlet var senhaConfirmacao: UITextField!
    
    
    func exibirMensagem(titulo: String, mensagem: String){
        
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alerta.addAction( acaoCancelar )
        
        present(alerta, animated: true, completion: nil)
    }
    
    
    @IBAction func CriarConta(_ sender: Any) {
        
        //Recuperar dados difitados
        if let emailR = self.email.text {
            if let senhaR = self.senha.text{
                if let senhaConfirmacaoR = self.senhaConfirmacao.text{
                    
                    //Validar senha
                    if senhaR == senhaConfirmacaoR{
                        
                        //Criar conta no Firebase
                        let autenticacao = Auth.auth()
                        autenticacao.createUser(withEmail: emailR, password: senhaR, completion: { (usuario, erro) in
                            
                            if erro == nil{
                                print("Sucesso ao cadastrar usuário.")
                            }else{
                                print("Erro ao cadastrar usuário.")
                            }/*Fim validacao erro Firebase*/
                            
                        })
                        
                    }else{
                        self.exibirMensagem(titulo: "Dados incorretos.", mensagem: "As senhas não estão iguais, digite novamente.")
                    }/*Fim validacao senha*/
                    
                    
                }
            }
        }
        
        
        
        
        
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
