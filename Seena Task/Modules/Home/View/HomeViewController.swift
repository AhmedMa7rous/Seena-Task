//
//  HomeViewController.swift
//  Seena Task
//
//  Created by Ma7rous on 17/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    //MARK: Outlet Connections
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak private var viewMessage: UIView!
    @IBOutlet weak private var lblMessage: UILabel!
    @IBOutlet weak private var imgMeessage: UIImageView!
    
/*=================================================*/
    //MARK: Properties
    private var viewModel = HomeViewModel()
        
/*=================================================*/
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData()
        updateUI()
        bindTableView()
        
    }
/*=================================================*/
    //MARK: Support Functions
    fileprivate func setupIntialView() {
        //Set Intial state
        navigationItem.title = "Home"
        homeTableView.isHidden = true
        viewMessage.isHidden = false
        lblMessage.text = "Getting News..."
        imgMeessage.image = #imageLiteral(resourceName: "Loading")
    }
    
    fileprivate func setupTableView() {
        //Register UsersCell
        homeTableView.register(HomeTableViewCell.nib, forCellReuseIdentifier: HomeTableViewCell.identifier)
        
    }
        
    fileprivate func setupObservables() {
        //Set success state
        viewModel.onSuccess.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.viewMessage.isHidden = true
            self.homeTableView.isHidden = false
        }.disposed(by: viewModel.disposeBag)
            
        //Set error state
        viewModel.onError.subscribe { [weak self] error in
            guard let self = self else { return }
            self.homeTableView.isHidden = true
            self.viewMessage.isHidden = false
            self.lblMessage.text = error.debugDescription
            self.imgMeessage.image = #imageLiteral(resourceName: "Error")
        }.disposed(by: viewModel.disposeBag)
    }
    
    func updateUI() {
        setupTableView()
        setupIntialView()
        setupObservables()
    }
    
    func bindTableView() {
        homeTableView.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
        viewModel.movies.bind(to: homeTableView.rx.items(cellIdentifier: HomeTableViewCell.identifier, cellType: HomeTableViewCell.self)) { (row, item, cell) in
            cell.configure(movie: item)
            
        } .disposed(by: viewModel.disposeBag)
        
        homeTableView.rx.modelSelected(Result.self).subscribe { [weak self] movie in
            guard let self = self else { return }
            guard let movie = movie.element else { return }
            let vc = DetailsViewController(movie: movie)
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: viewModel.disposeBag)
    }
}
/*=================================================*/
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

