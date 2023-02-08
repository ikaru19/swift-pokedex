//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage
import RxSwift

// MARK: LIFECYCLE AND CALLBACK
extension Presentation.UiKit {
    class PokemonDetailViewController: UIViewController {
        private var vwContainer: UIView?
        private var ivContent: UIImageView?
        private var lbName: UILabel?
        private var lbWeight: UILabel?
        private var lbType: UILabel?
        private var lbMove: UILabel?
        private var btCatch: UIButton?
        
        private var vmBag = DisposeBag()
        
        private var viewModel: PokemonDetailViewModel
        
        var data: Domain.PokemonEntity?
        var isFromLocal: Bool = false
        
        init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, viewModel: PokemonDetailViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            initDesign()
            initEvents()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            subscribeViewModel()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            if let data = data {
                showActivityIndicator()
                viewModel.getPokemonDetail(byName: isFromLocal ? data.id: data.name)
            }
        }
        
        private func subscribeViewModel() {
            viewModel.errors
                .observeOn(MainScheduler.instance)
                .subscribe(
                    onNext: { [weak self] error in
                        guard let self = self else {
                            return
                        }
                        self.hideActivityIndicator()
                        self.handleError(error)
                    }
                )
                .disposed(by: vmBag)
            viewModel
                .pokemonData
                .observeOn(MainScheduler.instance)
                .subscribe(
                    onNext: { [weak self] data in
                        guard let self = self else {
                            return
                        }
                        self.hideActivityIndicator()
                        self.populateData(data)
                    }
                )
                .disposed(by: vmBag)
        }
        
        @objc
        func onCatchTapped() {
            if Bool.random() {
                showCatchPopUp()
            } else {
                showRunPopUp()
            }
        }
        
        @objc
        func onReleasedTapped() {
            guard let data = data else {
                return
            }
            viewModel.deletePokemon(byId: data.id)
            navigationController?.popToRootViewController(animated: true)
        }
    }
}

// MARK: Function
private extension Presentation.UiKit.PokemonDetailViewController {
    func populateData(_ data: Domain.PokemonEntity) {
        self.data = data
        let url = URL(string: data.image)
        ivContent?.sd_setImage(with: url)
        lbName?.text = data.name
        lbWeight?.text = "\(data.weight ?? "0") kg"
        lbType?.text = data.types.joined(separator: ", ")
        lbMove?.text = data.abilities.joined(separator: ", ")
    }
    
    func showCatchPopUp() {
        let alert = UIAlertController(title: "You Catch A Pokemon", message: "Please Enter Your Pokemon Name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            if let text = alert?.textFields?.first?.text {
                if !text.isEmpty {
                    self.insertPokemonToLocalDB(name: text)
                } else {
                    self.insertPokemonToLocalDB(name: self.data?.name ?? "Pokemon")
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showRunPopUp() {
        let alert = UIAlertController(title: "The Pokemon is Run", message: "Try to catch the pokemon again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            alert?.removeFromParent()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func insertPokemonToLocalDB(name: String) {
        if var data = data {
            data.name = name
            viewModel.insetPokemonToLocal(data: data)
        }
    }
}

// MARK: Event
private extension Presentation.UiKit.PokemonDetailViewController {
    func initEvents() {
        let buttonTapped = isFromLocal ? UITapGestureRecognizer(target: self, action: #selector(onReleasedTapped)):
                                         UITapGestureRecognizer(target: self, action: #selector(onCatchTapped))
        btCatch?.addGestureRecognizer(buttonTapped)
    }
}


// MARK: UIBUILDER
private extension Presentation.UiKit.PokemonDetailViewController {
    func initDesign() {
        setupBaseView()
        let vwContainer = generateContainerView()
        let ivContent = generateContentImageView()
        let lbName = generateTitleLabel()
        let lbWeight = generateSubtitle()
        let lbType = generateSubtitle()
        let lbMove = generateSubtitle()
        let btCatch = generateButton()
        
        view.addSubview(vwContainer)
        vwContainer.addSubview(ivContent)
        vwContainer.addSubview(lbName)
        vwContainer.addSubview(lbWeight)
        vwContainer.addSubview(lbType)
        vwContainer.addSubview(lbMove)
        vwContainer.addSubview(btCatch)
        
        vwContainer.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        ivContent.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
        
        lbName.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalTo(ivContent.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.lessThanOrEqualToSuperview()
        }
        
        lbWeight.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalTo(lbName.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.lessThanOrEqualToSuperview()
        }
        
        lbType.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalTo(lbWeight.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.lessThanOrEqualToSuperview()
        }
        
        lbMove.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalTo(lbType.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        btCatch.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalTo(lbMove.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
        }
        self.vwContainer = vwContainer
        self.ivContent = ivContent
        self.lbName = lbName
        self.lbWeight = lbWeight
        self.lbType = lbType
        self.lbMove = lbMove
        self.btCatch = btCatch
    }
    
    func setupBaseView() {
        view.backgroundColor = .white
        self.navigationItem.title = "Detail"
    }
    
    func generateContainerView() -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func generateContentImageView() -> UIImageView {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.sd_imageIndicator = SDWebImageActivityIndicator.gray
        return view
    }
    
    func generateTitleLabel() -> UILabel {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        view.textColor = .darkText
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }
    
    func generateSubtitle() -> UILabel {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 16, weight: .light)
        view.textColor = .darkText.withAlphaComponent(0.6)
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }
    
    func generateButton() -> UIButton {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle(isFromLocal ? "Release": "Catch", for: .normal)
        view.backgroundColor = isFromLocal ? .red: .systemBlue
        return view
    }
}
