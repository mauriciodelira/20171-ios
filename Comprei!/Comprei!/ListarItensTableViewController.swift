//
//  ListarItensTableViewController.swift
//  Comprei!
//
//  Created by admin on 30/08/17.
//
//

import UIKit

class ListarItensTableViewCell: UITableViewCell {
    @IBOutlet weak var lbNomeItem: UILabel!
    @IBOutlet weak var lbQtdItens: UILabel!
    @IBOutlet weak var btCheck: UIButton!
    
}

class ListarItensTableViewController: UITableViewController {

    var compra: Compra!
    var listaCompras: ListaCompras!
    
    @IBOutlet weak var btNavBarButtonAdd: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItems = [self.btNavBarButtonAdd, self.editButtonItem]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
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
        return compra.size()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath) as! ListarItensTableViewCell

        let item = self.compra.get(pos: indexPath.row)
        
        cell.lbNomeItem.text = item.nome
        
        if(item.qtde != 1) {
            cell.lbQtdItens.text = "\(String(item.qtde)) unidades"
        } else {
            cell.lbQtdItens.text = "\(String(item.qtde)) un."
        }
        
        
        // coloca um checkmark ao lado se estiver setado um boolean em item
        if(item.isComprado()) {
            // a propriedade Bool comprado de Item == true: a imagem é um checkbox marcado
            cell.btCheck.setImage(#imageLiteral(resourceName: "checked-checkbox-filled.png"), for: UIControlState.normal)
        } else {
            // a propriedade == false: a imagem é um checkbox desmarcado
            cell.btCheck.setImage(#imageLiteral(resourceName: "unchecked-checkbox-filled.png"), for: UIControlState.normal)
        }
        
        
        return cell
    }
    
    // ao clicar no UIButton da custom cell (que é o nosso checkbox), vem pra essa função
    @IBAction func toqueCheckBox(_ sender: Any) {
        
        // pega a posição do toque dentro do CGPoint (um mapa de coordenadas XY):
        let buttonClickPosition = (sender as AnyObject).convert(CGPoint(), to: tableView)
        
        // puxa o indexPath segundo o ponto XY tirado acima, retornando um NSIndexPath
        let indexPath = self.tableView.indexPathForRow(at: buttonClickPosition)
        
        // verifica se realmente conseguiu encontrar um indexPath válido
        if ((indexPath) != nil) {
            
            // puxa o item daquela posição específica que foi clicado
            let item = self.compra.get(pos: (indexPath?.row)!)
            
            // dentro desse if vai alterar a propriedade. Se era true, fica false, e vice versa
            if(item.isComprado()) {
                print("checkbox: item comprado era true, agora false")
                item.comprado = false
            } else {
                print("checkbox: item comprado era false, agora true")
                item.comprado = true
            }
            
            // atualiza a tableView pra exibir a mudança na célula
            self.tableView.reloadData()
            self.listaCompras.salvar()
        }
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.compra.delItem(pos: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.listaCompras.salvar()
        }
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let objetoMovido = self.compra.get(pos: fromIndexPath.row)
        self.compra.moveItem(objeto: objetoMovido, origem: fromIndexPath.row, destino: to.row)
        
        // self.compra.moveItem(origem: fromIndexPath.row, destino: to.row)
        self.listaCompras.salvar()
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
        
        let itemDetalhe = segue.destination as! FormularioViewController
        itemDetalhe.listaCompras = self.listaCompras
        itemDetalhe.compra = self.compra
        
        if(segue.identifier == "celula_detalhe") {
            
            if let indexPath = tableView.indexPathForSelectedRow{
                print("row selecionada: \(indexPath.row)")
                itemDetalhe.item = self.compra.get(pos: indexPath.row)
            }
        } else if(segue.identifier == "itens_detalhe") {
            
        }
    }
}
