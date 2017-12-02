//
//  FotoViewController.swift
//  Snapchat
//
//  Created by Rodrigo Abreu on 02/12/2017.
//  Copyright © 2017 Rodrigo Abreu. All rights reserved.
//

import UIKit
import Photos

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    
    @IBOutlet var imagem: UIImageView!
    @IBOutlet var descricao: UITextField!
    
    let imagePicker = UIImagePickerController()
    
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
