//
//  Pokemon.swift
//  PokemonIndex
//
//  Created by NH on 5/15/25.
//

import Foundation

/// - 포켓몬 리스트 데이터 모델
struct PokemonList: Decodable {
    let count: Int
    let next: String? // null 일수 있어서 옵셔널로 선언
    let previous: String? // null 일수 있어서 옵셔널로 선언
    let results: [Pokemon]
}

extension PokemonList {
    /// - 포켓몬 리스트 결과 데이터 모델
    /// - 특정 포켓몬 이름과 상세 정보 URL 제공
    struct Pokemon: Decodable {
        let name: String // "name": "bulbasaur",
        let url : String // "url": "https://pokeapi.co/api/v2/pokemon/1/"
    }
}

/// - 포켓몬 상세 정보 데이터 모델
struct PokemonDetail: Decodable {
    /*
     이미지
     도감번호
     이름
     타입
     키
     몸무게
     */
    let sprites: PokemonSprites // 이미지
    let id: Int // 도감 번호
    let name: String // 이름
    let types: [PokemonType] // 타입
    let height: Int // 키
    let weight: Int // 몸무게
}

extension PokemonDetail {
    /// - 포켓몬 사진
    struct PokemonSprites: Decodable {
        let frontDefault: String
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
    
    /// - 포켓몬 타입
    struct PokemonType: Decodable {
        let slot: Int
        let type: PokemonTypeInfo
    }
    
    /// - 포켓몬 타입 정보
    struct PokemonTypeInfo : Decodable {
        let name: String
        let url: String
    }
}
