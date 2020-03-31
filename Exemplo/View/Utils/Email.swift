//
//  Email.swift
//  Exemplo
//
//  Created by Marcel Goncalves Viana Marins de Camargos on 31/03/20.
//  Copyright © 2020 Marcel Goncalves Viana Marins de Camargos. All rights reserved.
//

import UIKit

class Email: UIView {

    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}
