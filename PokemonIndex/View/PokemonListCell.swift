//
//  PokemonListCell.swift
//  PokemonIndex
//
//  Created by NH on 5/15/25.
//

import UIKit
import SnapKit
import Kingfisher

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
    private func pokemonID(url: String) -> Int {
        
        guard let stringID = url.split(separator: "/").last else {
            print("오류: url에서 id 값을 추출 실패")
            return 0
        }
        print(stringID)
        guard let id = Int(stringID) else {
            print("오류: id 값 정수형 변환 실패")
            return 0
        }
        return id
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImageView.image = nil
    }
    
    func configure(id: Int) {
        
        //MARK: 킹피셔 쓰기 전
//        let urlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
//        guard let url = URL(string: urlString) else { return }
//        
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) { // 동기 실행이여서 비동기로 실행해야됨, 안그럼 UI가 멈춤
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.sync { // UI 작업은 메인 스레드가 해야됨
//                        self?.pokemonImageView.image = image
//                    }
//                }
//            }
//        }
        
        // MARK: - 킹피셔 사용
        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
        pokemonImageView.kf.setImage(with: url)
    }
}
