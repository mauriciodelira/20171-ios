//
//  File.swift
//  Comprei!
//
//  Created by admin on 30/08/17.
//
//

import Foundation

class Item: NSObject, NSCoding {
    var nome: String!
    var valor: Float!
    var qtde: Int!
    var comprado: Bool!
    
    override var description: String{
        return self.nome
    }
    
    init(nome: String!, valor: Float! = 0.0, qtde: Int! = 0, comprado: Bool! = false) {
        self.nome = nome
        self.valor = valor
        self.qtde = qtde
        self.comprado = comprado
    }
    
    //memoria >> arquivo
    required init?(coder aDecoder: NSCoder) {
        self.nome = aDecoder.decodeObject(forKey: "nome") as! String
        self.valor = aDecoder.decodeObject(forKey: "valor") as? Float
        self.qtde = aDecoder.decodeObject(forKey: "qtde") as! Int
        self.comprado = aDecoder.decodeObject(forKey: "comprado") as! Bool
    }
    
    //arquivo >> memoria
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.nome, forKey: "nome")
        aCoder.encode(self.valor, forKey: "valor")
        aCoder.encode(self.qtde, forKey: "qtde")
        aCoder.encode(self.comprado, forKey: "comprado")
    }
    
    func total() -> Float {
        return Float(self.qtde) * self.valor
    }
    
    func isComprado() -> Bool {
        return comprado
    }
    
}
