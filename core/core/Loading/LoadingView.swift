//
//  LoadingView.swift
//  mypokemon
//
//  Created by Sinta Novita Sari on 29/03/24.
//

import UIKit

public class LoadingView: UIView {
    @IBOutlet weak var contentView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        Bundle(for: Self.self).loadNibNamed("LoadingView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.frame
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
