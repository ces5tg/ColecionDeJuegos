//
//  JuegosViewController.swift
//  ColecionDeJuegos
//
//  Created by cesar on 10/24/23.
//  Copyright © 2023 cesar. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIPickerViewDataSource , UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorias.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorias[row]
        
    }
    
    
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var JuegoImageView: UIImageView!
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    @IBOutlet weak var eliminarBoton: UIButton!
    @IBOutlet weak var pickerCategorias: UIPickerView!
    
    var imagePicker = UIImagePickerController()
    var juego:Juego? = nil
    var categorias = ["categoria1" , "categoria2", "categoria3", "categoria4"]
    
    
    var pick = ""
    
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
       
        if juego != nil {
            juego!.titulo! = tituloTextField.text!
            juego!.imagen = JuegoImageView.image?.jpegData(compressionQuality:0.5)
            juego!.categoria! = self.pick
        }else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context:context)
            juego.titulo = tituloTextField.text
            juego.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
            juego.categoria = self.pick
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated:true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        if juego != nil{
            self.pick = juego!.categoria!
            print("asd \(self.pick)")
            JuegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            agregarActualizarBoton.setTitle("actualizar", for: .normal)
            tituloTextField.text = juego!.titulo
            //imagePicker.select(juego!.categoria)
            //print("ans")
            // Reemplaza "categoria_actual" con la categoría que deseas seleccionar
            if let index = categorias.firstIndex(of: juego!.categoria!) {
                print("poscicion \(index )")
                pickerCategorias.selectRow(index, inComponent: 0, animated: true)
                //pickerCategorias.selectedRow(inComponent: index)
                pickerCategorias.reloadAllComponents()
            }
        }else {
            eliminarBoton.isHidden = true
            //            pickerCategorias.selectRow(2, inComponent: 0, animated: true)
            //            pickerCategorias.reloadAllComponents()
        }
        pickerCategorias.dataSource = self
        pickerCategorias.delegate = self

    }
    
    func imagePickerController(_ picker:UIImagePickerController , didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey:Any]){
        let imagenSeleccionada = info[.originalImage] as? UIImage
        JuegoImageView.image = imagenSeleccionada
        imagePicker.dismiss(animated:true , completion:nil)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let categoria = categorias[row]
        print(categoria)
        self.pick = categoria
        print(self.pick)
        
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
