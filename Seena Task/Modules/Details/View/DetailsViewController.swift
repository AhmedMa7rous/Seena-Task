//
//  DetailsViewController.swift
//  Seena Task
//
//  Created by Ma7rous on 17/02/2023.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {

    //MARK: - Outlet Connections
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishedByLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
/*===============================================*/
    //MARK: - Properties
    var viewModel: DetailsViewModel
        
/*===============================================*/
    //MARK: - LifeCycle
    init(movie: Result) {
        self.viewModel = DetailsViewModel(movie: movie)
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        bindMovieData()
        
    }
    
/*==============================================*/
    //MARK: - Services Functions
    func bindMovieData() {
        let imageUrl = URL(string: viewModel.movie.multimedia.src)
        movieImageView.sd_setImage(with: imageUrl, completed: nil)
        titleLabel.text = viewModel.movie.displayTitle
        publishedByLabel.text = viewModel.movie.byline
        ratingLabel.text = viewModel.movie.mpaaRating
        summaryLabel.text = viewModel.movie.summaryShort
        publishedDateLabel.text = viewModel.movie.publicationDate
    }
    
    func updateUI() {
        navigationItem.title = "Movie Details"
        movieImageView.layer.cornerRadius = 15
        movieImageView.layer.masksToBounds = true
        
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        // add it to the image view;
        movieImageView.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        movieImageView.isUserInteractionEnabled = true
    }

    @objc func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if let _ = gesture.view as? UIImageView {
            let vc = ImageInfoViewController(url: viewModel.movie.multimedia.src)
            self.navigationController?.pushViewController(vc, animated: true)

        }
    }
    
}
