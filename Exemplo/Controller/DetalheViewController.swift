//
//  DetalheViewController.swift
//  Exemplo
//
//  Created by Marcel Goncalves Viana Marins de Camargos on 28/03/20.
//  Copyright © 2020 Marcel Goncalves Viana Marins de Camargos. All rights reserved.
//

import UIKit

class DetalheViewController: UIViewController {

    @IBOutlet weak var voltarParaHomeButton: UIButton!
    
    @IBOutlet weak var tituloNomeEmpresaLabel: UILabel!
    
    @IBOutlet weak var nomeEmpresaLabel: UILabel!
    
    @IBOutlet weak var descricao1TextView: UITextView!
    
    @IBOutlet weak var descricao2TextView: UITextView!
    
    var tituloNomeEmpresa: String!
    var nomeEmpresa: String!
    var descricao1: String!
    var descricao2: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(voltar(tapGestureRecognizer:)))
        voltarParaHomeButton.isUserInteractionEnabled = true
        voltarParaHomeButton.addGestureRecognizer(tapGestureRecognizer)
    }

    override func viewWillAppear(_ animated: Bool) {

        self.tituloNomeEmpresaLabel.text = tituloNomeEmpresa
        self.nomeEmpresaLabel.text = nomeEmpresa
        self.descricao1TextView.text = descricao1
        self.descricao2TextView.text = descricao2
    }
    
    @objc func voltar(tapGestureRecognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
