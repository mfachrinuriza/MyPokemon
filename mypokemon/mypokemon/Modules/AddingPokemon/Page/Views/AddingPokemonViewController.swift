//
//  AddingPokemonViewController.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 29/03/24.
//

import UIKit
import core

protocol AddingPokemonViewControllerProtocol where Self: UIViewController {
    var presenter: AddingPokemonPresenterProtocol { get }
    var router: AddingPokemonRouterProtocol { get }
    
    var pokemon: Pokemon? { get set }
    var successMessage: String? { get set }
    var errorMessage: String? { get set }
    var isLoading: Bool? { get set }
}

class AddingPokemonViewController: BaseViewController, AddingPokemonViewControllerProtocol {

    @IBOutlet weak var txtNickname: UITextField!
    @IBOutlet weak var formError: UILabel!
    @IBOutlet weak var txtPokemonName: UITextField!
    
    var pokemon: Pokemon?
    var successMessage: String? {
        didSet {
            self.navigationController?.popViewController(animated: true)
        }
    }
    var errorMessage: String?
    var isLoading: Bool?
    
    var presenter: AddingPokemonPresenterProtocol
    var router: AddingPokemonRouterProtocol
   
    init(
        presenter: AddingPokemonPresenterProtocol,
        router: AddingPokemonRouterProtocol
    ) {
        self.presenter = presenter
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        if let pokemon = self.pokemon {
            self.txtNickname.text = pokemon.nickname
            self.txtPokemonName.text = pokemon.name
        }
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        self.formError.isHidden = true
        
        var changedCount = pokemon?.changedCount ?? 0
        let isUpdate = pokemon?.nickname != nil && pokemon?.nickname != ""
        var formData = Pokemon(
            name: self.presenter.getNameFibonacciFomatted(
                changedCount: changedCount,
                nickname: txtNickname.text ?? ""
            ),
            nickname: txtNickname.text,
            changedCount: isUpdate ? changedCount + 1 : 0
        )
        var isValid = self.presenter.isFormValidated(with: formData)
        if isValid {
            if isUpdate {
                self.presenter.updatePokemon(request: formData)
            } else {
                self.presenter.addPokemon(request: formData)
            }
            
        } else {
            self.formError.isHidden = false
        }
    }
}
