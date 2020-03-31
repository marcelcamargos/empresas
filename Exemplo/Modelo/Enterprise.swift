//
//  Enterprise.swift
//  Exemplo
//
//  Created by Marcel Goncalves Viana Marins de Camargos on 29/03/20.
//  Copyright © 2020 Marcel Goncalves Viana Marins de Camargos. All rights reserved.
//

struct Enterprise: Mappable {
    
    var id: Int?
    var enterprise_name: String?
    var photo: String?
    var description: String?
    
    init(mapper: Mapper) {
        
        self.id = mapper.keyPath("id")
        self.enterprise_name = mapper.keyPath("enterprise_name")
        self.photo = mapper.keyPath("photo")
        self.description = mapper.keyPath("description")
        
    }
}
