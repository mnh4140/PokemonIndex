//
//  BaseCollectionViewCell.swift
//  PokemonIndex
//
//  Created by NH on 5/15/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        
    }
    
    func setConstraints() {
        
    }
    
}
