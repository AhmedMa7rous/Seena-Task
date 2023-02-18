//
//  HomeViewModel.swift
//  Seena Task
//
//  Created by Ma7rous on 18/02/2023.
//

import UIKit
import Moya
import RxSwift
import RxRelay


class HomeViewModel {
    //MARK: Properties
    private let provider = MoyaProvider<NetworkLayer>()
    private(set) var movies = BehaviorSubject(value: [Result]())
    
    var disposeBag: DisposeBag = DisposeBag()
    var onSuccess: PublishSubject<Void> = PublishSubject<Void>()
    var onError: PublishSubject<String> = PublishSubject<String>()
    var showLoader: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    //MARK: - Intents
    func fetchData() {
        provider.request(.news) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    self.movies.on(.next(try response.map(Movies.self).results))
                    self.onSuccess.onNext(())
                } catch {
                    print(error.localizedDescription)
                    self.onError.onNext(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.onError.onNext(error.localizedDescription)
            }
        }
    }
}
