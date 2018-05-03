//
//  CoinsAssembly.swift
//  Crypto
//
//  Created by  on 20/01/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class CoinsListAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CoinsListRouter.self) { r in
            return CoinsListRouter()
        }
        
        container.register(CoinsListInteractorInput.self) { (r, presenter: CoinsListPresenter) in
            let interactor = CoinsListInteractor()
            interactor.output = presenter
            return interactor
        }
        
        container.register(CoinsListRouterInput.self) { r in
            return CoinsListRouter()
        }
        
        container.register(CoinsListViewOutput.self) { (r, vc: CoinsListViewController) in
            let presenter = CoinsListPresenter()
            presenter.view = vc
            presenter.interactor = container.resolve(CoinsListInteractorInput.self, argument: presenter)
            presenter.router = container.resolve(CoinsListRouterInput.self)
            return presenter
        }
        
        container.register(CoinsListViewController.self) { (resolver) in
            let viewController = CoinsListViewController()
            viewController.output = resolver.resolve(CoinsListViewOutput.self, argument: viewController)
            viewController.settings = resolver.resolve(CryptoSettings.self)
            return viewController
        }
        
        container.storyboardInitCompleted(CoinsListViewController.self) { (resolver, viewController) in
            viewController.output = resolver.resolve(CoinsListViewOutput.self, argument: viewController)
            viewController.settings = resolver.resolve(CryptoSettings.self)
        }
        
    }
    
    func loaded(resolver: Resolver) {
    }

}
