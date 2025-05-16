//
//  DetailViewController.swift
//  PokemonIndex
//
//  Created by NH on 5/15/25.
//

import UIKit
import SnapKit
import RxSwift

class DetailViewController: BaseViewController {
    
    let viewModel: DetailViewModel
    let disposeBag = DisposeBag()
    
    let contentView = UIView()
    let imageView = UIImageView()
    let stackView = UIStackView()
    let idLabel = UILabel()
    let nameLabel = UILabel()
    let typeLabel = UILabel()
    let heightLabel = UILabel()
    let weightLabel = UILabel()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func setUI() {
        view.backgroundColor = .mainRed
        
        contentView.backgroundColor = .darkRed
        contentView.layer.cornerRadius = 10
        view.addSubview(contentView)
        
        imageView.image = .monsterBall
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        contentView.addSubview(stackView)
        
        idLabel.text = "아이디"
        idLabel.textAlignment = .left
        idLabel.textColor = .white
        idLabel.font = .systemFont(ofSize: 24, weight: .bold)
        stackView.addArrangedSubview(idLabel)
        
        nameLabel.text = "이름"
        nameLabel.textAlignment = .right
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        stackView.addArrangedSubview(nameLabel)
        
        typeLabel.text = "타입"
        typeLabel.textAlignment = .center
        typeLabel.textColor = .white
        typeLabel.font = .systemFont(ofSize: 18, weight: .medium)
        contentView.addSubview(typeLabel)
        
        heightLabel.text = "키"
        heightLabel.textAlignment = .center
        heightLabel.textColor = .white
        heightLabel.font = .systemFont(ofSize: 18, weight: .medium)
        contentView.addSubview(heightLabel)
        
        weightLabel.text = "몸무게"
        weightLabel.textAlignment = .center
        weightLabel.textColor = .white
        weightLabel.font = .systemFont(ofSize: 18, weight: .medium)
        contentView.addSubview(weightLabel)
    }
    
    override func setConstraints() {
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(weightLabel.snp.bottom).offset(16)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        heightLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        weightLabel.snp.makeConstraints { make in
            make.top.equalTo(heightLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    func bind() {
        viewModel.pokemonDetailSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] detailData in
                let urlString = detailData.sprites.frontDefault
                guard let url = URL(string: urlString) else { return }
                DispatchQueue.global().async { [weak self] in
                    if let data = try? Data(contentsOf: url) { // 동기 실행이여서 비동기로 실행해야됨, 안그럼 UI가 멈춤
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.sync { // UI 작업은 메인 스레드가 해야됨
                                self?.imageView.image = image
                            }
                        }
                    }
                }
                self?.idLabel.text = "No.\(detailData.id)"
                let name = PokemonTranslator.getKoreanName(for: detailData.name)
                self?.nameLabel.text = name
                
                let englishType = detailData.types[0].type.name

                if let typeEnum = PokemonTypeName(rawValue: englishType) {
                    let koreanType = typeEnum.displayName
                    self?.typeLabel.text = "타입 : \(koreanType)"
                }
                
                self?.heightLabel.text = "키 : \(Double(detailData.height)/10) m"
                self?.weightLabel.text = "몸무게 : \(Double(detailData.weight)/10) kg"
            }, onError: { error in
                print("디테일 데이터 구독 에러 발생")
            }).disposed(by: disposeBag)
    }
}
