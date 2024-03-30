//
//  PokemonDetailViewController.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 15/02/24.
//

import UIKit
import core
import Kingfisher

protocol PokemonDetailViewControllerProtocol where Self: UIViewController {
    var presenter: PokemonDetailPresenterProtocol { get }
    var router: PokemonDetailRouterProtocol { get }
    
    var pokemonName: String? { get set }
    var successMessage: String? { get set }
    var errorMessage: String? { get set }
    var myPokemonData: Pokemon? { get set }
    var isLoading: Bool? { get set }
    
    func updateUI(with pokemon: PokemonDetail)
}

class PokemonDetailViewController: BaseViewController, PokemonDetailViewControllerProtocol {

    internal let presenter: PokemonDetailPresenterProtocol
    internal let router: PokemonDetailRouterProtocol

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var baseExperience: UILabel!
    @IBOutlet weak var btnAddPokemon: UIButton!
    @IBOutlet weak var btnRemovePokemon: UIButton!
    
    @IBOutlet weak var types: UILabel!
    @IBOutlet weak var moves: UILabel!
    
    var pokemon: PokemonDetail? = nil {
        didSet {
            var typesValue = ""
            if let types = pokemon?.types {
                for (index, type) in types.enumerated() {
                    let name = type.type?.name ?? ""
                    typesValue += "\(name)"
                    
                    if name != types.last?.type?.name {
                        typesValue += ", "
                    }
                    
                    if index > 2 {
                        break
                    }
                }
            }
            
            self.types.text = typesValue
            
            var movesValue = ""
            if let moves = pokemon?.moves {
                for (index, move) in moves.enumerated() {
                    let name = move.move?.name ?? ""
                    movesValue += "\(name)"
                    
                    if name != moves[2].move?.name {
                        movesValue += ", "
                    }
                    
                    if index > 2 {
                        break
                    }
                }
            }
            
            self.moves.text = movesValue
        }
    }
    var pokemonName: String?
    var myPokemonData: Pokemon? = nil {
        didSet {
            if myPokemonData != nil {
                nickname.isHidden = false
                nickname.text = myPokemonData?.nickname
                setBtnPokemonEdit()
                btnRemovePokemon.isHidden = false
            } else {
                nickname.isHidden = true
                nickname.text = nil
                setBtnPokemonAdd()
                btnRemovePokemon.isHidden = true
            }
        }
    }
    var isLoading: Bool? = nil {
        didSet {
            if isLoading ?? false {
                self.showLoading()
            } else {
                self.removeLoading()
            }
        }
    }
    
    var successMessage: String? = nil {
        didSet {
            self.showAlert(title: Wording.success, message: successMessage)
        }
    }
    var errorMessage: String? = nil {
        didSet {
            self.showAlert(title: Wording.error, message: errorMessage)
        }
    }
    
    init(
        presenter: PokemonDetailPresenterProtocol,
        router: PokemonDetailRouterProtocol
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        loadData()
    }
    
    func loadData() {
        self.presenter.getPokemonDetail(name: self.pokemonName ?? "")
        self.presenter.getMyPokemonDetail(name: self.pokemonName ?? "")
    }
    
    func updateUI(with pokemon: PokemonDetail) {
        self.pokemon = pokemon
        let iconUrl = pokemon.sprites?.front_default
        self.icon.kf.setImage(with: URL(string: iconUrl ?? ""), placeholder: UIImage(named: "ic_default_image_1", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil))
        
        self.name.text = pokemon.name
        self.height.text = "\(pokemon.height?.f(.number) ?? "")"
        self.weight.text = "\(pokemon.weight?.f(.number) ?? "")"
        self.baseExperience.text = "\(pokemon.base_experience ?? 0)"
    }
    
    func setBtnPokemonAdd() {
        btnAddPokemon.setTitle("Add to My Pokemon", for: .normal)
        btnAddPokemon.setTitleColor(.white, for: .normal)
        btnAddPokemon.backgroundColor = .blue
    }
    
    func setBtnPokemonEdit() {
        btnAddPokemon.setTitle("Edit My Pokemon", for: .normal)
        btnAddPokemon.setTitleColor(.white, for: .normal)
        btnAddPokemon.backgroundColor = .systemOrange
    }
    
    @IBAction func btnAddPokemonTapped(_ sender: Any) {
        let data = Pokemon(
            name: pokemonName,
            nickname: myPokemonData?.nickname,
            changedCount: myPokemonData?.changedCount
        )
        self.router.presentAddingPokemon(pokemon: data)
    }
    
    @IBAction func btnRemovePokemonTapped(_ sender: Any) {
        if let pokemonName = self.pokemonName {
            self.presenter.deletePokemon(name: pokemonName)
        }
    }
}
