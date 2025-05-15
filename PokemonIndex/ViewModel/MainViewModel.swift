//
//  MainViewModel.swift
//  PokemonIndex
//
//  Created by NH on 5/15/25.
//

import Foundation
import RxSwift
/*
 - 포켓몬 도감을 노출하는 메인화면을 `MainViewController` 라고 합시다.
 - 이에 대한 뷰모델인 `MainViewModel` 을 구현합니다.
 - `RxSwift` 를 활용합니다.
 - 리스트 형태로 포켓몬 정보들을 가져와야겠죠. `limit=20`, `offset=0` 으로 합시다.
 - `NetworkManager` 를 활용해주세요.
 - (이 단계에서는 20개의 포켓몬 정보만 불러와도 됩니다.)
 */

class MainViewModel {
    /// - View가 구독 할 subject
    /// - 뷰에서 이 Subject를 구독하여, 새로운 포켓몬 리스트가 들어오면 자동으로 반응함
    /// - BehaviorSubject는 최근 값 1개를 저장하고, 구독 즉시 현재 값을 전달.
    /// - 타입은 [PokemonList.Pokemon], 포켓몬 리스트 배열.
    /// - 초기값으로 빈 배열을 설정합니다.
    let pokemonListSubject = BehaviorSubject(value: [PokemonList.Pokemon]())
    
    private let disposeBag = DisposeBag()
    
    private let limit = 20
    private let offset = 0
    
    init() {
        fetchPokemonList()
    }
    
    
    func fetchPokemonList() {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)") else {
            return
        }
        
        // ViewController가 fetchPokemonList() 호출
        // ViewModel이 API 호출
        // 응답을 BehaviorSubject에 전달
        // View는 pokemonListSubject를 구독하고 있기 때문에 자동으로 반응함
        NetworkManager.shared.fetch(url: url)
        // 구독, API로 데이터를 가져오면 response.results 을 Subject 로 전달
            .subscribe(onSuccess: { [weak self] (response: PokemonList) in
                self?.pokemonListSubject.onNext(response.results)
                // 실패 시, Subject에 에러를 담아 View에 전달
            }, onFailure: { [weak self] error in
                self?.pokemonListSubject.onError(error)
            }).disposed(by: disposeBag)
    }
}
