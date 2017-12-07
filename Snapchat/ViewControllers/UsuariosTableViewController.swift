//
//  UsuariosTableViewController.swift
//  Snapchat
//
//  Created by Rodrigo Abreu on 02/12/2017.
//  Copyright © 2017 Rodrigo Abreu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UsuariosTableViewController: UITableViewController {

    var usuarios: [Usuario] = []
    var urlImagem = ""
    var descricao = ""
    var idImagem = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let database = Database.database().reference()
        let usuarios = database.child("usuarios")
        
        /*Adiciona evento novo usuario adicionado*/
        usuarios.observe(DataEventType.childAdded, with: { (snapshot) in
            
            let dados = snapshot.value as? NSDictionary
            
            //Recupera dados usuário logado
            let autenticacao = Auth.auth()
            let idUsuarioLogado = autenticacao.currentUser?.uid
            
            //Recuperar os dados
            let emailUsuario = dados!["email"] as! String
            let nomeUsuario = dados!["nome"] as! String
            let idUsuario = snapshot.key
            
            let usuario = Usuario(email: emailUsuario, nome: nomeUsuario, uid: idUsuario)
            
            //adiciona usuario no array
            if idUsuario != idUsuarioLogado{
                self.usuarios.append( usuario )
            }
            
            self.tableView.reloadData()
            print(self.usuarios)
            
            
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.usuarios.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)

        // Configure the cell...
        let usuario = self.usuarios[ indexPath.row ]
        celula.textLabel?.text = usuario.nome
        celula.detailTextLabel?.text = usuario.email

        return celula

    }
 

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let usuarioSelecionado = self.usuarios[ indexPath.row ]
        let idUsuarioSelecionado = usuarioSelecionado.uid

        //Recupera referencia do banco de dados
        let database = Database.database().reference()
        let usuarios = database.child("usuarios")
        let snaps = usuarios.child( idUsuarioSelecionado ).child("snaps")//Criando o nó Snaps

        //Recupera o usuario logado
        let autenticacao = Auth.auth()
        if let idUsuarioLogado = autenticacao.currentUser?.uid{
            
            let usuarioLoado = usuarios.child( idUsuarioLogado )
            usuarioLoado.observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
                print(snapshot)
                
                let dados = snapshot.value as? NSDictionary
                
                let snap = [
                    "de": dados!["email"] as! String,
                    "nome": dados!["nome"] as! String,
                    "descricao": self.descricao,
                    "urlImagem": self.urlImagem,
                    "idImagem": self.idImagem
                ]
                
                snaps.childByAutoId().setValue(snap)//Criando ID automatico para o nó para cada snap
                
                self.navigationController?.popToRootViewController(animated: true)
                
            })
            
        }
        
        
        

        

    }




}
