//
//  Header.swift
//  Exemplo
//
//  Created by Marcel Goncalves Viana Marins de Camargos on 29/03/20.
//  Copyright © 2020 Marcel Goncalves Viana Marins de Camargos. All rights reserved.
//

struct Header: Mappable {
    
    var investor: String
    
    init(mapper: Mapper) {
        
        self.investor = mapper.keyPath("investor")
        
    }
}
