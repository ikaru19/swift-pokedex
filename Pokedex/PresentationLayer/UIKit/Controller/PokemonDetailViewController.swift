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
        
        override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            initDesign()
        }
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
        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        view.sd_imageIndicator = SDWebImageActivityIndicator.gray
        view.sd_setImage(with: url)
        return view
    }
    
    func generateTitleLabel() -> UILabel {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        view.textColor = .darkText
        view.numberOfLines = 0
        view.textAlignment = .left
        view.text = "title"
        return view
    }
    
    func generateSubtitle() -> UILabel {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 16, weight: .light)
        view.textColor = .darkText.withAlphaComponent(0.6)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.text = "subtitle"
        return view
    }
    
    func generateButton() -> UIButton {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Catch", for: .normal)
        view.backgroundColor = .systemBlue
        return view
    }
}
