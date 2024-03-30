//
//  HomeViewController.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import UIKit
import AVFoundation
import core

protocol HomeViewControllerProtocol where Self: UIViewController {
    var presenter: HomePresenterProtocol { get }
    var router: HomeRouterProtocol { get }
    
    var pokemons: [Pokemon]? { get set }
    var errorMessage: String? { get set }
    
    func update(with pokemons: [Pokemon], isFiltered: Bool)
}

class HomeViewController: BaseViewController, HomeViewControllerProtocol {
    public var homePresenterProtocol: HomePresenterProtocol!
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyState: UILabel!
    
    internal let presenter: HomePresenterProtocol
    internal let router: HomeRouterProtocol

    var pokemons: [Pokemon]?
    var filteredData = [Pokemon]()
    
    var errorMessage: String? = nil {
        didSet {
            self.showAlert(title: Wording.error, message: errorMessage)
        }
    }
    
    init(
        presenter: HomePresenterProtocol,
        router: HomeRouterProtocol
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
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        loadData()
    }
    
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.register(UINib(nibName: PokemonCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: PokemonCell.cellIdentifier)
        
        txtSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func loadData() {
        self.presenter.getPokemons()
    }
    
    func update(with pokemons: [Pokemon], isFiltered: Bool) {
        if pokemons.count > 0 {
            self.collectionView.reloadData()
            self.collectionView.isHidden = false
            self.emptyState.isHidden = true
            
            self.filteredData = pokemons
            if !isFiltered {
                self.pokemons = pokemons
            }
        } else {
            self.collectionView.isHidden = true
            self.emptyState.isHidden = false
        }
    }
    
    
    @IBAction func btnFavoriteTapped(_ sender: Any) {
        self.router.presentMyPokemon()
    }
}

extension HomeViewController {
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.presenter.filterData(with: textField.text, pokemons: self.pokemons ?? [])
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.cellIdentifier, for: indexPath) as! PokemonCell
        let data = self.filteredData[indexPath.row]
        cell.update(with: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = filteredData[indexPath.row]
        self.router.presentPokemonDetail(name: data.name ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.width / 2.08,
            height: 45
        )
    }
}
