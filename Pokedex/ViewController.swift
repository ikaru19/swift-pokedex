//
//  ViewController.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import UIKit
import Cleanse
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        (UIApplication.shared.delegate as? ProvideInjectorResolver)?.injectorResolver.inject(self)
        test()
        gotoMainPage()
    }
    
    private func gotoMainPage() {
        let vc = Presentation.UiKit.MainTabViewController(nibName: nil, bundle: nil)
        presentInFullScreen(vc, animated: true)
    }


    var data: PokemonRepository?
    func injectProperties(
            viewController: TaggedProvider<MyBaseUrl>,
            data: PokemonRepository?
    ){
        self.data = data
    }
    
    func test() {
        data?
            .getGameList(page: 0)
            .subscribe(
                onSuccess: {[weak self] data in
                    print("38")
                    print(data)
                },
                onError: {[weak self] error in
                    print("42")
                    print(error)
                }
            )
    }
}

