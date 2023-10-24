//
//  JuegosViewController.swift
//  ColecionDeJuegos
//
//  Created by cesar on 10/24/23.
//  Copyright © 2023 cesar. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var JuegoImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func CamaraTopped(_ sender: Any) {
    }
    @IBAction func FotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker , animated:true , completion:nil)

    }
    @IBAction func AgregarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let juego = Juego(context:context)
        juego.titulo = tituloTextField.text
        juego.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated:true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }
    func imagePickerController(_ picker:UIImagePickerController , didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey:Any]){
    let imagenSeleccionada = info[.originalImage] as? UIImage
    JuegoImageView.image = imagenSeleccionada
    imagePicker.dismiss(animated:true , completion:nil)
    }

    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
