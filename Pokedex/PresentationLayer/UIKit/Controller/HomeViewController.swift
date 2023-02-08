//
//  HomeViewController.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

// MARK: LIFECYCLE AND CALLBACK
extension Presentation.UiKit {
    class HomeViewController: UIViewController {
        private var tvContent: UITableView?
        
        override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            initDesign()
            initViews()
        }
    }
}

// MARK: View
private extension Presentation.UiKit.HomeViewController {
    func initViews() {
        initTableView()
    }
    
    func initTableView() {
        tvContent?.register(
            PokemonTableCell.self,
                forCellReuseIdentifier: PokemonTableCell.identifier
        )
        self.tvContent?.delegate = self
        self.tvContent?.dataSource = self
        tvContent?.rowHeight = UITableView.automaticDimension
        tvContent?.estimatedRowHeight = 600
    }
}

// MARK: DESIGN
private extension Presentation.UiKit.HomeViewController {
    private func initDesign() {
        setupBaseView()
        
        let tvContent = generateTableView()

        view.addSubview(tvContent)
        tvContent.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }

        self.tvContent = tvContent
    }
    
    func setupBaseView() {
        view.backgroundColor = .white
    }
    
    func generateTableView() -> UITableView {
        let view = UITableView(frame: .zero,style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .none
        return view
    }
}

// MARK: TABLE DELEGATE
extension Presentation.UiKit.HomeViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PokemonTableCell.identifier, for: indexPath
        ) as? PokemonTableCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.updateUI()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: GOTO DETAIL
        let vc = Presentation.UiKit.PokemonDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let table = tvContent else {
            return
        }
        let y = scrollView.contentOffset.y/(scrollView.contentSize.height - scrollView.frame.size.height)
        let relativeHeight = 1 - (table.rowHeight / (scrollView.contentSize.height - scrollView.frame.size.height))
        if y >= relativeHeight{
            // TODO: LOADMORE
        }
    }
}
