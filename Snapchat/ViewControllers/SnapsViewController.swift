//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Rodrigo Abreu on 02/12/2017.
//  Copyright © 2017 Rodrigo Abreu. All rights reserved.
//

import UIKit
import FirebaseAuth

class SnapsViewController: UIViewController {

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

        // Do any additional setup after loading the view.
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
