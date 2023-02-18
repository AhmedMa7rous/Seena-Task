//
//  HomeTableViewCell.swift
//  Seena Task
//
//  Created by Ma7rous on 17/02/2023.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {
    //MARK: - Outlet Connections
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishedByLabel: UILabel!
    @IBOutlet weak var assistLabel: UILabel!
    @IBOutlet weak var PublishDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        articleImageView.layer.cornerRadius = 10
        articleImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
/*=========================================================*/
    //MARK: Support Functions
    public func configure(movie: Result) {
        let imageUrl = URL(string: movie.multimedia.src)
        articleImageView.sd_setImage(with: imageUrl, completed: nil)
        titleLabel.text = movie.displayTitle
        publishedByLabel.text = movie.byline
        PublishDateLabel.text = movie.publicationDate
    }
}
