

//
//  File.swift
//  Comprei!
//
//  Created by admin on 30/08/17.
//
//

import Foundation

class Compra: NSObject, NSCoding {
    var itens: Array<Item>!
    var titulo: String!
    
    override var description: String {
        return titulo
    }

    override init() {
            self.itens = Array<Item>()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        // print("descodificando uma compra")
        self.itens = aDecoder.decodeObject(forKey: "itens") as! Array<Item>
        self.titulo = aDecoder.decodeObject(forKey: "titulo") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        // print("tá persistindo uma compra com X itens: \(self.itens.count)")
        aCoder.encode(self.itens, forKey: "itens")
        aCoder.encode(self.titulo, forKey: "titulo")
    }
    
    
    func diretorio() -> String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        
        let docPath = "\(path)/itensFeira.dat"
                
        return docPath
    }
    
    func salvar(){
        print("compra | salvando em: \(self.diretorio())")
        NSKeyedArchiver.archiveRootObject(self, toFile: self.diretorio())
    }
    
    func addItem(novo: Item!){
        print("compra | add item:\(novo.nome)")
        if (self.itens.contains(novo)) {
            let posExistente = self.itens.index(of: novo)
            print(self.itens[posExistente!])
        } else {
            print("vai ser appendado")
            self.itens.append(novo)
        }
        // self.salvar()
    }
    
    func delItem(pos: Int){
        // print("compra | del item:\(pos)")
        self.itens.remove(at: pos)
        self.salvar()
    }
    
    func moveItem(objeto: Item, origem: Int, destino: Int){
        self.itens.remove(at: origem)
        self.itens.insert(objeto, at: destino)
    }
    
    func size()-> Int {
        return self.itens.count
    }
    
    func get(pos: Int) -> Item {
        return self.itens[pos]
    }
    
    // quantidade de itens total da compra
    func totalQtd()-> Int {
        // print("compra| total itens")
        var tot: Int = 0
        
        for item in itens{
            tot+=item.qtde
        }
        
        return tot
    }
    
    // valor total da compra
    func totalValor() -> Float {
        // print("compra| total R$")
        var tot: Float = 0.0
        
        for item in itens {
            tot += item.total()
        }
        
        return tot
        
    }
    

}
