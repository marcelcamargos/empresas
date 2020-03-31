//
//  HomeViewController.swift
//  Exemplo
//
//  Created by Marcel Goncalves Viana Marins de Camargos on 28/03/20.
//  Copyright © 2020 Marcel Goncalves Viana Marins de Camargos. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nomeEmpresaTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var authenticationAPI: EmpresaAPI?
    
    var empresas: [Enterprise] = []
    
    var empresasPesquisadas: [Enterprise] = []
    
    let cellSpacingHeight: CGFloat = 5
    
    @IBOutlet weak var imageBack: UIImageView!
    
    @IBOutlet weak var labelResultadoEncontrado: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.nomeEmpresaTextField?.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
    
        self.view.frame.origin.y = -100
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func searchRecordsAsPerText(_ textfield:UITextField) {
        
        buscarEmpresas(textField: textfield)
        
    }
    
    func buscarEmpresas(textField: UITextField) {
        
        let width = view.frame.width/2 - 36
        let height = view.frame.height/2 - 36
        
        let ind = MyIndicator(frame: CGRect(x: width, y: height, width: 72, height: 72), image: UIImage(named: "indicator")!)
        view.addSubview(ind)
        ind.startAnimating()
        
        EmpresaAPI.buscarEmpresas() {  (response, error, cache) in
        
            if let response = response {

                self.empresas = response.enterprises
        
                self.empresasPesquisadas.removeAll()
                if textField.text?.count != 0 {
                    for empresa in self.empresas {
                        
                        let fullName = empresa.enterprise_name
                        let fullNameArr = fullName!.split{$0 == " "}.map(String.init)
                        
                        let range = fullNameArr[0].lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil,   locale: nil)
                        
                        if range != nil {
                            self.empresasPesquisadas.append(empresa)
                        }
                    }
                    
                    self.labelResultadoEncontrado.text = "\(self.empresasPesquisadas.count) resultado (s) encontrado (s)"
                    
                } else {
                    self.empresasPesquisadas.removeAll()
                    self.labelResultadoEncontrado.text = "Nenhum resultado encontrado"
                }

                self.tableView.reloadData()
                
            } else if let error = error {
                if let urlResponse = error.urlResponse, urlResponse.statusCode == 401 {
                    // logout user
                } else if let responseObject = error.responseObject as? [String: Any], let errorMessage = responseObject["error_message"] {
                    // show errorMessage
                } else {
                    // show error.originalError.localizedDescription
                }
            }
            ind.stopAnimating()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.empresasPesquisadas.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "enterpriseId") as! EnterpriseTableViewCell

        let position = indexPath.section
        if position<self.empresasPesquisadas.count {
            
            let fullName = self.empresasPesquisadas[position].enterprise_name
            let fullNameArr = fullName!.split{$0 == " "}.map(String.init)
            
            let empresaPesq = fullNameArr[0]
            
            cell.nomeEmpresa.text = empresaPesq
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let position = indexPath.section
        let empresaEscolhida = self.empresasPesquisadas[position]
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detalheViewController = storyBoard.instantiateViewController(withIdentifier: "DetalheViewController") as! DetalheViewController
        detalheViewController.tituloNomeEmpresa = empresaEscolhida.enterprise_name
        detalheViewController.nomeEmpresa = empresaEscolhida.enterprise_name
        detalheViewController.descricao1 = empresaEscolhida.description
        detalheViewController.descricao2 = empresaEscolhida.description
        detalheViewController.modalPresentationStyle = .fullScreen
        self.present(detalheViewController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
