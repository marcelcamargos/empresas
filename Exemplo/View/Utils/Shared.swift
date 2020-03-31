//
//  Shared.swift
//  Exemplo
//
//  Created by Marcel Goncalves Viana Marins de Camargos on 29/03/20.
//  Copyright © 2020 Marcel Goncalves Viana Marins de Camargos. All rights reserved.
//

import UIKit

class Shared: NSObject {
    static let sharedInstance = Shared()

    func textFieldLeftPadding(textFieldName: UITextField) {
        textFieldName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textFieldName.frame.height))
        textFieldName.leftViewMode = .always
        textFieldName.rightViewMode = .always
    }

    private override init() {

    }
}
