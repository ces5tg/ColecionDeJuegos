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
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    @IBOutlet weak var eliminarBoton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var juego:Juego? = nil
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated:true)
        
    }
    @IBAction func FotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker , animated:true , completion:nil)

    }
    @IBAction func AgregarTapped(_ sender: Any) {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let juego = Juego(context:context)
//        juego.titulo = tituloTextField.text
//        juego.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
//        (UIApplication.shared.delegate as! AppDelegate).saveContext()
//        navigationController?.popViewController(animated:true)
        if juego != nil {
                juego!.titulo! = tituloTextField.text!
                juego!.imagen = JuegoImageView.image?.jpegData(compressionQuality:0.5)
        }else {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let juego = Juego(context:context)
            juego.titulo = tituloTextField.text
        juego.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)

        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated:true)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        if juego != nil{
            JuegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            agregarActualizarBoton.setTitle("actualizar", for: .normal)
        tituloTextField.text = juego!.titulo
        }else {
            eliminarBoton.isHidden = true
        }


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
