//
//  PokemonListCell.swift
//  PokemonIndex
//
//  Created by NH on 5/15/25.
//

import UIKit
import SnapKit

class PokemonListCell: BaseCollectionViewCell {
    let pokemonImageView = UIImageView()
    
    override func setUI() {
        super.setUI()
        
        contentView.backgroundColor = .cellBackground
        contentView.layer.cornerRadius = 20
        
        pokemonImageView.image = .monsterBall
        pokemonImageView.contentMode = .scaleAspectFit
        pokemonImageView.layer.cornerRadius = 20
        pokemonImageView.layer.borderWidth = 5
        pokemonImageView.clipsToBounds = true
        
        contentView.addSubview(pokemonImageView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        pokemonImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
