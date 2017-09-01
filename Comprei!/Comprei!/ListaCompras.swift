//
//  ListaCompras.swift
//  Comprei!
//
//  Created by admin on 30/08/17.
//
//

import Foundation

class ListaCompras: NSObject {
    var compras: Array<Compra>!
    
    override init() {
        super.init()
        
        let obj = NSKeyedUnarchiver.unarchiveObject(withFile: self.diretorio())
        // print("listaCompra | obj lista compras = \(obj)")
        if (obj != nil) {
            // print("listaCompra | achou arquivo de feiras!! inicia com o que tem")
            self.compras = obj as! Array<Compra>
            // print("listaCompra | no arquivo tinha \(compras.count) feiras")
            
            for compra in self.compras {
                print("lista | na compra tem \(compra.size()) coisas")
                print("- itens da compra acima: \(compra.itens)")
            }
        }
        else {
            // print("listaCompra | nao achou arquivo de compras, inicia arr vazio")
            self.compras = Array<Compra>()
        }
    }
    
    func diretorio() -> String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        
        let docPath = "\(path)/listaFeiras.dat"
        
        return docPath
        
    }
    
    func salvar() {
        // print("listaCompra | salvar no arquivo, persistindo self.compras")
        print("lista | salvando em: \(self.diretorio())")
        NSKeyedArchiver.archiveRootObject(self.compras, toFile: self.diretorio())
    }
    
    func addCompra(nova: Compra) {
        print("lista | add compra: \(nova.description)")
        self.compras.append(nova)
        self.salvar()
    }
    
    
    func delCompra(pos: Int) {
        // print("listaCompra | deletar compra: pos \(pos)")
        self.compras.remove(at: pos)
        self.salvar()
    }
        
    func moveCompra(objeto: Compra, origem: Int, destino: Int){
        self.compras.remove(at: origem)
        self.compras.insert(objeto, at: destino)
        self.salvar()
    }
    
    func size() -> Int {
        return self.compras.count
    }
    
    func get(pos: Int) -> Compra {
        return self.compras[pos]
    }
    
    func totalCompras() -> Float {
        // print("listaCompra | total R$)")
        
        var tot: Float = 0.0
        
        for compra in compras {
            tot += compra.totalValor()
        }
        
        return tot
    }
    
    func totalCompras(pos: Int) -> Float {
        // print("listaCompra | total qtd")

        return self.compras[pos].totalValor()
    }
    
}
