//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by Rodrigo Abreu on 01/12/2017.
//  Copyright © 2017 Rodrigo Abreu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CadastroViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var nomeCompleto: UITextField!    
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
            if let nomeCompletoR = self.nomeCompleto.text {
                if let senhaR = self.senha.text{
                    if let senhaConfirmacaoR = self.senhaConfirmacao.text{
                        
                        //Validar senha
                        if senhaR == senhaConfirmacaoR{
                            
                            //Validacao do nome
                            if nomeCompletoR != "" {
                                
                                //Criar conta no Firebase
                                let autenticacao = Auth.auth()
                                autenticacao.createUser(withEmail: emailR, password: senhaR, completion: { (usuario, erro) in
                                    
                                    if erro == nil{
                                        
                                        if usuario == nil{
                                            
                                            self.exibirMensagem(titulo: "Erro ao autenticar.", mensagem: "Problema ao realizar autenticação, tente novamente.")
                                            
                                        }else{
                                            
                                            //gravando os dados do usuario e atrelando com o Auth
                                            let database = Database.database().reference()
                                            let usuarios = database.child("usuarios")
                                            
                                            let usuarioDados = ["nome" : nomeCompletoR, "email": emailR]
                                            usuarios.child( usuario!.uid ).setValue(usuarioDados)
                                            
                                            //redireciona usuario para tela principal
                                            self.performSegue(withIdentifier: "cadastroLoginSegue", sender: nil)
                                            
                                        }
                                        
                                    }else{
                                        
                                        //Validando erro de cadastro
                                        /*
                                         ERROR_INVALID_EMAIL
                                         ERROR_WEAK_PASSWORD
                                         ERROR_EMAIL_ALREADY_IN_USE
                                         */
                                        
                                        let erroR = erro! as NSError
                                        if let codigoErro = erroR.userInfo["error_name"]{
                                            
                                            let erroTexto = codigoErro as! String
                                            var mensagemErro = ""
                                            switch erroTexto{
                                            case "ERROR_INVALID_EMAIL" : mensagemErro = "E-mail inválido, digite um e-mail válido!"
                                                break
                                            case "ERROR_WEAK_PASSWORD" : mensagemErro = "Senha precisa ter no mínimo 6 caracteres, com letras e números!"
                                                break
                                            case "ERROR_EMAIL_ALREADY_IN_USE" : mensagemErro = "Esse e-mail já está sendo utilizado, crie sua conta com outro e-mail."
                                                break
                                            default:
                                                mensagemErro = "Dados digitados estão incorretos."
                                            }
                                            
                                            self.exibirMensagem(titulo: "Dados inválidos", mensagem: mensagemErro)
                                            
                                        }
                                        
                                    }/*Fim validacao erro Firebase*/
                                    
                                })
                            }else{
                                
                                let alerta = Alerta(titulo: "Dados incorretos", mensagem: "Digite o seu nome para prosseguir!")
                                self.present(alerta.getAlerta(), animated: true, completion: nil)
                                
                            }
                            
                        }else{
                            self.exibirMensagem(titulo: "Dados incorretos.", mensagem: "As senhas não estão iguais, digite novamente.")
                        }/*Fim validacao senha*/
                        
                        
                    }
                }
            }
        }
        
        
        
        
        
    }/*Fechamento Método criar conta*/
    
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
