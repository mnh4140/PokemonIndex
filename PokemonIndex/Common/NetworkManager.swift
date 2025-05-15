//
//  NetworkManager.swift
//  PokemonIndex
//
//  Created by NH on 5/15/25.
//

import Foundation
import RxSwift

/// 네트워크 에러
enum NetworkError: Error {
    case invalidURL
    case dataFetchFail
    case decodingFail
}

/// 네트워트 매니저
/// 싱글톤 패턴 적용
/// RxSwift
class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    
    // Single 은 오직 하나의 값 또는 에러만 방출하는 Rx 타입
    // 네트워크 요청 처럼 결과가 하나인 작업에 적합
    func fetch<T: Decodable>(url: URL) -> Single<T> {
        
        // observer는 .success(value) 와 .failure(error)만 방출
        return Single.create { observer in
            let session = URLSession(configuration: .default)
            session.dataTask(with: URLRequest(url:url)) { data, response, error in
                
                // 예외 처리: 에러 발생
                if let error = error {
                    observer(.failure(error))
                    return
                }
                
                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode) else {
                    observer(.failure(NetworkError.dataFetchFail))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    // 디코딩을 성공하면 .success(decodedData) 로 전달
                    observer(.success(decodedData))
                } catch {
                    observer(.failure(NetworkError.decodingFail))
                }
            }.resume()
            // 구독 해제, 메모리에서 해제
            return Disposables.create()
        }
    }
}
