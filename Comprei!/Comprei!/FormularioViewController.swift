//
//  ViewController.swift
//  Comprei!
//
//  Created by admin on 30/08/17.
//
//

import UIKit

class FormularioViewController: UIViewController {
    @IBOutlet weak var tfNome: UITextField!
    @IBOutlet weak var tfValor: UITextField!
    @IBOutlet weak var tfQuantidade: UITextField!
    @IBOutlet weak var stQuantidade: UIStepper!
    @IBOutlet weak var btIsComprado: UIButton!
    
    var compra: Compra!
    var item: Item?
    var isComprado: Bool! = false
    
    var listaCompras: ListaCompras!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(salvar))
        
        self.tfNome.keyboardType = UIKeyboardType.alphabet
        self.tfValor.keyboardType = UIKeyboardType.decimalPad
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if(item != nil) {
            print("formulario| trouxe item! \(item!.nome ?? "nada")")
            self.tfNome.text = item?.nome
            self.tfValor.text = String(describing: item?.valor ?? 0 )
            self.tfQuantidade.text = String(describing: item?.qtde ?? 0)
            self.stQuantidade.value = Double(item!.qtde ?? 0)
            self.isComprado = item?.comprado
            
            if(item?.isComprado())! {
                btIsComprado.setImage(#imageLiteral(resourceName: "checked-checkbox-filled.png"), for: UIControlState.normal)
            } else {
                btIsComprado.setImage(#imageLiteral(resourceName: "unchecked-checkbox-filled.png"), for: UIControlState.normal)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func definirQuantidade(_ sender: Any) {
        self.tfQuantidade.text = String(Int(self.stQuantidade.value))
    }
    
    @IBAction func checkComprado(_ sender: Any) {
        if(self.item != nil) {
            if(item?.isComprado())! {
                item?.comprado = false
                isComprado = false
                btIsComprado.setImage(#imageLiteral(resourceName: "unchecked-checkbox-filled.png"), for: .normal)
            }
            else {
                item?.comprado = true
                isComprado = true
                btIsComprado.setImage(#imageLiteral(resourceName: "checked-checkbox-filled.png"), for: .normal)
            }
        } else {
            if(isComprado)! {
                isComprado = false
                btIsComprado.setImage(#imageLiteral(resourceName: "unchecked-checkbox-filled.png"), for: .normal)
            }
            else {
                isComprado = true
                btIsComprado.setImage(#imageLiteral(resourceName: "checked-checkbox-filled.png"), for: .normal)
            }
        }
    }
    
    func salvar() {
        let name = self.tfNome.text
        let valor = Float(self.tfValor.text!)
        let qtd = Int(self.tfQuantidade.text!)
        var comprado: Bool = false
        
        if(self.btIsComprado.currentImage == #imageLiteral(resourceName: "checked-checkbox-filled.png")) {
            print("salvar o item: comprado = marcado (true)")
            comprado = true
        } else {
            print("salvar o item: comprado = desmarcado (false)")
            comprado = false
        }
        
        if( self.item == nil ) {
            let novoItem = Item(nome: name!, valor: valor!, qtde: qtd, comprado: comprado)
            self.compra.addItem(novo: novoItem)
        } else {
            self.item?.nome = name
            self.item?.valor = valor
            self.item?.qtde = qtd
            self.item?.comprado = comprado
            self.compra.addItem(novo: self.item)
        }
        
        self.listaCompras.salvar()
        self.navigationController?.popViewController(animated: true)
    }


}

