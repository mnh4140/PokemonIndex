//
//  DetailViewModel.swift
//  PokemonIndex
//
//  Created by NH on 5/15/25.
//

import Foundation
import RxSwift

class DetailViewModel {
    let pokemonDetailSubject = PublishSubject<PokemonDetail>()
    private let disposeBag = DisposeBag()
    let id: Int
    
    init(id: Int) {
        self.id = id
        fetchPokemonDetail(id: self.id)
        print("ID:\(id)")
    }
    
    func fetchPokemonDetail(id: Int) {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(String(id))/") else { return }
        
        NetworkManager.shared.fetch(url: url)
            .subscribe(onSuccess: { [weak self] (response: PokemonDetail) in
                self?.pokemonDetailSubject.onNext(response)
            }, onFailure: { [weak self] error in
                self?.pokemonDetailSubject.onError(error)
            }).disposed(by: disposeBag)
    }
}
