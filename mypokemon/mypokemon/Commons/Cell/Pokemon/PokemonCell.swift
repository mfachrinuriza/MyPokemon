//
//  PokemonCell.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 29/03/24.
//

import UIKit
import core

class PokemonCell: UICollectionViewCell {

    @IBOutlet weak var content: UIStackView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var btnTrash: UIButton!
    @IBOutlet weak var nickname: UILabel!
    
    static let cellIdentifier = "PokemonCell"
    
    var isShowTrash: Bool? = nil {
        didSet {
            nickname.isHidden = !(isShowTrash ?? false)
            btnTrash.isHidden = !(isShowTrash ?? false)
        }
    }
    var onTapTrash: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        content.layer.borderWidth = 1
        content.layer.borderColor = Color.getColor(name: .black30)?.cgColor
    }
    
    func update(with data: Pokemon) {
        self.name.text = data.name
        self.nickname.text = data.nickname
    }

    @IBAction func btnTrashTapped(_ sender: Any) {
        self.onTapTrash?()
    }
}
