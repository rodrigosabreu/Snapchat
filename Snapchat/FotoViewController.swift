//
//  FotoViewController.swift
//  Snapchat
//
//  Created by Rodrigo Abreu on 02/12/2017.
//  Copyright © 2017 Rodrigo Abreu. All rights reserved.
//

import UIKit
import FirebaseStorage

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    
    @IBOutlet var imagem: UIImageView!
    @IBOutlet var descricao: UITextField!
    @IBOutlet var botaoProximo: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func proximoPasso(_ sender: Any) {
        
        self.botaoProximo.isEnabled = false
        self.botaoProximo.setTitle("Carregando...", for: .normal)
        
        let armazenamento = Storage.storage().reference()
        let imagens = armazenamento.child("imagens")
        
        //Recuperar a imagem
        if let imagemSelecionada = imagem.image{
            
            if let imagemDados = UIImageJPEGRepresentation(imagemSelecionada, 0.5){
                imagens.child("imagem.jpg").putData(imagemDados, metadata: nil, completion: { (metaDados, erro) in
                    
                    if erro == nil{
                        print("Sucesso ao fazer upload do Arquivo")
                        
                        self.botaoProximo.isEnabled = true
                        self.botaoProximo.setTitle("Próximo", for: .normal)
                        
                    }else{
                        
                        print("Erro ao fazer o upload do Arquivo")
                        
                    }
                    
                })
            }
            
        }
        
        
    }
    
    
    @IBAction func selecionarFoto(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                        
            imagePicker.sourceType = .savedPhotosAlbum
            present(self.imagePicker, animated: true, completion: nil)
            //No info.plist é necessário solicitar permissão para o usuário utilizar a camera
            
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let imagemRecuperada = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imagem.image = imagemRecuperada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
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
