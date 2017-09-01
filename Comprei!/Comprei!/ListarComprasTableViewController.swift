//
//  ListarTableViewController.swift
//  Comprei!
//
//  Created by admin on 30/08/17.
//
//

import UIKit

class ListarComprasTableViewCell: UITableViewCell {
    @IBOutlet weak var lbTituloCompra: UILabel!
    @IBOutlet weak var lbQtdItensCompra: UILabel!
    @IBOutlet weak var lbTotalCompra: UILabel!
    
}

class ListarComprasTableViewController: UITableViewController {

    var compras = ListaCompras()
    let alertNovaCompra = UIAlertController(title: "Nova compra", message: "Informe o título da compra.", preferredStyle: .alert)
    
    @IBAction func adicionar(_ sender: UIBarButtonItem) {
        
        // print("Ativou nova compra")
        self.alertNovaCompra.textFields?[0].text = ""
        self.present(self.alertNovaCompra, animated: true, completion: nil)
        
        // print("deve ter exibido")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tableView.reloadData()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.alertNovaCompra.addTextField { (textField) in
            textField.placeholder = "Título da compra"
            textField.keyboardType = UIKeyboardType.alphabet
            textField.text = ""
        }
        
        self.alertNovaCompra.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        self.alertNovaCompra.addAction(UIAlertAction(title: "Salvar", style: UIAlertActionStyle.default, handler: {
            [weak alertNovaCompra] (_) in
            
            let tituloCompra = alertNovaCompra?.textFields![0].text
            let compra = Compra()
            compra.titulo = tituloCompra
            self.compras.addCompra(nova: compra)
            // print("Nova compra: \(compra.titulo) e qtd de itens: \(compra.size())")
            
            self.tableView.reloadData()
            
        }))
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
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
        return compras.size()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath) as! ListarComprasTableViewCell

        // Configure the cell...
        let compra = self.compras.get(pos: indexPath.row)

        cell.lbTotalCompra.text = "R$ \(compra.totalValor())"
        cell.lbTituloCompra.text = compra.titulo
        if(compra.itens.count != 1) {
            cell.lbQtdItensCompra.text = "\(compra.itens.count) itens"
        }else {
            cell.lbQtdItensCompra.text = "\(compra.itens.count) item"
        }
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {// focar aauqi
            // Delete the row from the data source
            self.compras.delCompra(pos: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let objetoMovido = self.compras.get(pos: fromIndexPath.row)
        self.compras.moveCompra(objeto: objetoMovido, origem: fromIndexPath.row, destino: to.row)
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "compras_itens") {
            if let indexPath = tableView.indexPathForSelectedRow{
                let selectedRow = indexPath.row
                let detalheCompra = segue.destination as! ListarItensTableViewController
                detalheCompra.compra = self.compras.get(pos: selectedRow)
                detalheCompra.title = self.compras.get(pos: selectedRow).titulo
                detalheCompra.listaCompras = self.compras
            }    
        }
        
        
    }
    

}
