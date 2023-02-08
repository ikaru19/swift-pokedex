//
//  PokemonTableCell.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class PokemonTableCell: UITableViewCell {
    public static let identifier: String = "PokemonTableCell"
    private var vwContainer: UIView?
    private var ivContent: UIImageView?
    private var lbName: UILabel?
    
    private var data: Domain.PokemonEntity?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initDesign()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initDesign()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }
    
    func updateUI(data: Domain.PokemonEntity) {
        self.data = data
        lbName?.text = data.name
        let url = URL(string: data.image)
        ivContent?.sd_imageIndicator = SDWebImageActivityIndicator.gray
        ivContent?.sd_setImage(with: url)
    }
}

// MARK: UIKIT
private extension PokemonTableCell {
    func initDesign() {
        setupBaseView()
        let vwContainer = generateContainer()
        let ivContent = generateContentImageView()
        let lbName = generateAuthorLabel()
        
        contentView.addSubview(vwContainer)
        vwContainer.addSubview(ivContent)
        vwContainer.addSubview(lbName)
        
        vwContainer.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.edges.equalToSuperview()
        }

        ivContent.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100).priority(.high)
        }
        
        lbName.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.leading.equalTo(ivContent.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        self.vwContainer = vwContainer
        self.ivContent = ivContent
        self.lbName = lbName
    }
    
    func setupBaseView() {
        self.contentView.backgroundColor = .clear
    }
    
    func generateContainer() -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        // shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 3.0
        
        return view
    }
    
    func generateAuthorLabel() -> UILabel {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        view.textColor = .black
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }
    
    func generateContentImageView() -> UIImageView {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
