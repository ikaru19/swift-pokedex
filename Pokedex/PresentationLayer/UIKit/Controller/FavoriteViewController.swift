//
//  FavoriteViewController.swift
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
    class FavoriteViewContoller: UIViewController {
        private var tvContent: UITableView?
        private var data: [Domain.PokemonEntity] = []
        private var vmBag = DisposeBag()
        
        private var viewModel: FavoriteViewModel
        
        init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, viewModel: FavoriteViewModel) {
            self.viewModel = viewModel
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

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            subscribeViewModel()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            fetchPokemon()
        }
        
        private func subscribeViewModel() {
            viewModel
                .errors
                .observeOn(MainScheduler.instance)
                .subscribe(
                    onNext: { [weak self] error in
                        guard let self = self else {
                            return
                        }
                        self.handleError(error)
                    }
                )
                .disposed(by: vmBag)
            viewModel
                .pokemonLists
                .observeOn(MainScheduler.instance)
                .subscribe(
                    onNext: { [weak self] data in
                        guard let self = self else {
                            return
                        }
                        self.initPokemonData(data)
                    }
                )
                .disposed(by: vmBag)
        }
    }
}

// MARK: Function
private extension Presentation.UiKit.FavoriteViewContoller {
    func initPokemonData(_ datas: [Domain.PokemonEntity]) {
        self.data =  datas
        tvContent?.reloadData()
    }
    
    func fetchPokemon() {
        viewModel.getLocalPokemon()
        tvContent?.reloadData()
    }
    
    func deletePokemon(byId id: String) {
        viewModel.deletePokemon(byId: id)
        fetchPokemon()
    }
}

// MARK: DESIGN
private extension Presentation.UiKit.FavoriteViewContoller {
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

// MARK: View
private extension Presentation.UiKit.FavoriteViewContoller {
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

// MARK: TABLE DELEGATE
extension Presentation.UiKit.FavoriteViewContoller: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PokemonTableCell.identifier, for: indexPath
        ) as? PokemonTableCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.updateUI(data: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: GOTO DETAIL
        guard let vc = (UIApplication.shared.delegate as? ProvideViewControllerResolver)?.vcResolver.instantiateDetailViewController().get() else {
            fatalError("View Controller can't be nil: Detail")
        }
        vc.data = data[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        vc.isFromLocal = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                deletePokemon(byId: data[indexPath.row].id)
            }
    }
}
