//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Rodrigo Abreu on 02/12/2017.
//  Copyright © 2017 Rodrigo Abreu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var snaps: [Snap] = []
        
    @IBAction func sair(_ sender: Any) {
        
        
        //deslogar o usuario para testes        
        let autenticacao = Auth.auth()

        do{
            try autenticacao.signOut()
            dismiss(animated: true, completion: nil)
            //ou exexutar uma segue para ir a uma determinada tela
        }catch{
            print("Erro ao deslogar usuario")
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let autenticacao = Auth.auth()
        
        if let idUsuarioLogado = autenticacao.currentUser?.uid{
            
            let database = Database.database().reference()
            let usuarios = database.child("usuarios")
            let snaps = usuarios.child( idUsuarioLogado ).child("snaps")
            
            //Cria ouvinte para Snaps
            snaps.observe(DataEventType.childAdded, with: { (snapshot) in
                
                let dados = snapshot.value as? NSDictionary
                
                let snap = Snap()
                snap.identificador = snapshot.key
                snap.nome = dados?["nome"] as! String
                snap.descricao = dados?["descricao"] as! String
                snap.urlImagem = dados?["urlImagem"] as! String
                snap.idImagem = dados?["idImagem"] as! String
                
                self.snaps.append( snap )
                             
                self.tableView.reloadData()
                
            })
            
            
            /*Adiciona evento para item removido*/
            snaps.observe(DataEventType.childRemoved, with: { (snapshot) in
                
              
                
                var indice = 0
                for snap in self.snaps{

                    if snap.identificador == snapshot.key{
                            self.snaps.remove(at: indice)                        
                    }
                    indice = indice + 1
                    
                }
                self.tableView.reloadData()
                
            })
            
            
        }
        
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let totalSnaps = snaps.count
        
        if totalSnaps == 0{
            return 1
        }
        return totalSnaps
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        
        let totalSnaps = snaps.count
        if totalSnaps == 0{
            celula.textLabel?.text = "Nenhum snap para você!"
        }else{
            
            let snap = self.snaps[ indexPath.row ]
            celula.textLabel?.text = snap.nome
        }
        
        
        return celula
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let totalSnaps = snaps.count
        if totalSnaps > 0{
            let snap = self.snaps[ indexPath.row ]
            self.performSegue(withIdentifier: "detalheSnapSegue", sender: snap)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detalheSnapSegue"{
            
            let detalheSnapViewController = segue.destination as! DetalheSnapViewController
            detalheSnapViewController.snap = sender as! Snap
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
