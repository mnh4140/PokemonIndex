//
//  MainViewController.swift
//  PokemonIndex
//
//  Created by NH on 5/15/25.
//

import UIKit
import SnapKit
import RxSwift

// 사용한 컬러 hex 값.
extension UIColor {
    static let mainRed = UIColor(red: 190/255, green: 30/255, blue: 40/255, alpha: 1.0)
    static let darkRed = UIColor(red: 120/255, green: 30/255, blue: 30/255, alpha: 1.0)
    static let cellBackground = UIColor(red: 245/255, green: 245/255, blue: 235/255, alpha: 1.0)
}

final class MainViewController: BaseViewController {
    // MARK: - Propertys
    private let viewModel = MainViewModel()
    private let disposebag = DisposeBag()
    
    private var pokemonList = [PokemonList.Pokemon]()

    
    private let monsterBallImageView = UIImageView() // 몬스터볼 이미지
    // 포켓몬 리스트 UICollectionView
    private lazy var pokemonListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PokemonListCell.self, forCellWithReuseIdentifier: String(describing: PokemonListCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    // MARK: - Methods
    override func setUI() {
        super.setUI()
        
        view.backgroundColor = .mainRed
        
        monsterBallImageView.image = .monsterBall
        monsterBallImageView.clipsToBounds = true
        monsterBallImageView.contentMode = .scaleAspectFit
        view.addSubview(monsterBallImageView)
        
        pokemonListCollectionView.backgroundColor = .darkRed
        view.addSubview(pokemonListCollectionView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        monsterBallImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        pokemonListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(monsterBallImageView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func bind() {
        // 포켓몬 리스트 받아오기.
        viewModel.pokemonListSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] pokemons in
                self?.pokemonList = pokemons
                self?.pokemonListCollectionView.reloadData() // UI 작업
            }, onError: { error in
                print("에러 발생 : \(error)")
            }).disposed(by: disposebag)
    }
}

// MARK: - UICollectionView Delegate, DataSource
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 8
        let coulmns: CGFloat = 3
        let totalSpacing = spacing * (coulmns - 1)
        let width = (view.frame.width - totalSpacing) / coulmns
        return CGSize(width: width, height: width)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(pokemonList.count)
        return pokemonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PokemonListCell.self), for: indexPath) as? PokemonListCell else { return .init()}
        
        guard let id = pokemonList[indexPath.item].id else { return .init() }
        
        cell.configure(id: id)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = pokemonList[indexPath.item].id else { return }
        
        let detailModel = DetailViewModel(id: id)
        
        let detailVC = DetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
        //print(id)
        
    }
}
