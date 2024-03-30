//
//  MyPokemonViewController.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 29/03/24.
//

import UIKit
import AVFoundation
import core

protocol MyPokemonViewControllerProtocol where Self: UIViewController {
    var presenter: MyPokemonPresenterProtocol { get }
    var router: MyPokemonRouterProtocol { get }
    
    var pokemons: [Pokemon]? { get set }
    var successMessage: String? { get set }
    var errorMessage: String? { get set }
    var isLoading: Bool? { get set }
    
    func update(with pokemons: [Pokemon])
}

class MyPokemonViewController: BaseViewController, MyPokemonViewControllerProtocol {

    @IBOutlet weak var emptyState: UILabel!
    @IBOutlet weak var collectionView: FittedCollectionView!
   
    var pokemonName: String?
    var pokemons: [Pokemon]?
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
    
    var presenter: MyPokemonPresenterProtocol
    var router: MyPokemonRouterProtocol
   
    init(
        presenter: MyPokemonPresenterProtocol,
        router: MyPokemonRouterProtocol
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.setNavigationBarWithTitle(title: "My Pokemon List")
        loadData()
    }
    
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.register(UINib(nibName: PokemonCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: PokemonCell.cellIdentifier)
    }
    
    func update(with pokemons: [Pokemon]) {
        if pokemons.count > 0 {
            self.pokemons = pokemons
            self.collectionView.reloadData()
            self.collectionView.isHidden = false
            self.emptyState.isHidden = true
        } else {
            self.collectionView.isHidden = true
            self.emptyState.isHidden = false
        }
    }
    
    func loadData() {
        self.presenter.getPokemons()
    }
}

extension MyPokemonViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemons?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = self.pokemons![indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.cellIdentifier, for: indexPath) as! PokemonCell
        cell.update(with: data)
        cell.isShowTrash = true
        cell.onTapTrash = {
            self.presenter.deletePokemon(name: data.name ?? "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = pokemons![indexPath.row]
        self.router.presentPokemonDetail(name: data.name ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.width / 2.08,
            height: 70
        )
    }
}
