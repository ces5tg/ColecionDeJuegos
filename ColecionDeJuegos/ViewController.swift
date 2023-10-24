//
//  ViewController.swift
//  ColecionDeJuegos
//
//  Created by cesar on 10/24/23.
//  Copyright © 2023 cesar. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return juegos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let juego = juegos[indexPath.row]
        cell.textLabel?.text = juego.titulo
        cell.imageView?.image = UIImage(data: juego.imagen!)
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    var juegos:[Juego] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setEditing(true, animated: true)
        self.tableView.isEditing = true
        //cambo
        // Do any additional setup after loading the view.
    }
    override func setEditing(_ editing:Bool , animated:Bool){
           super.setEditing(editing, animated:animated)
           if(self.isEditing){
               self.editButtonItem.title = "eliminar"
           }
       }
    func obtenerJuegos() {
           let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       do{
           juegos = try context.fetch(Juego.fetchRequest()) as! [Juego]		
       } catch {
           print("error al leer entidad de core data")
       }
       }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
           
           
           let eliminarAction = UITableViewRowAction(style: .destructive, title: "Eliminar") { (action, indexPath) in
               print("haz presionado eliminar de edit")

                 let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
               let tarea = self.juegos[indexPath.row]
               let fetchRequest: NSFetchRequest<Juego> = Juego.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "titulo == %@", tarea.titulo!)
               do{
                   let resultado = try context.fetch(fetchRequest)
                   if let juegoEliminar = resultado.first{
                       context.delete(juegoEliminar)
                       try context.save()
                       self.obtenerJuegos()
                       self.tableView.reloadData()
                   }
               }catch{
                   
               }

           }
           return [eliminarAction]
       }
        func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let objetoMovido = self.juegos[fromIndexPath.row]
           juegos.remove(at:fromIndexPath.row)
           juegos.insert(objetoMovido , at:to.row)
           NSLog("%@" , "\(fromIndexPath.row) => \(to.row) \(juegos)")

       }
    

    override func viewWillAppear(_ animated:Bool){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try juegos = context.fetch(Juego.fetchRequest())
            tableView.reloadData()
    }catch{

    }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let juego = juegos[indexPath.row]
        performSegue(withIdentifier: "juegoSegue" , sender:juego)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC = segue.destination as! JuegosViewController
        siguienteVC.juego = sender as? Juego
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

}

