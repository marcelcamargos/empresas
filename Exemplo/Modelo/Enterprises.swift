//
//  Enterprise.swift
//  Exemplo
//
//  Created by Marcel Goncalves Viana Marins de Camargos on 29/03/20.
//  Copyright © 2020 Marcel Goncalves Viana Marins de Camargos. All rights reserved.
//

struct Enterprises: Mappable {
    
    var enterprises: [Enterprise]
    
    init(mapper: Mapper) {
        
        self.enterprises = mapper.keyPath("enterprises")
        
    }
}
