//
//  MarkTableViewCell.swift
//  bikeCitizens
//
//  Created by Paul on 27.02.22.
//

import UIKit
import SDWebImage

class MarkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var onLikeTap: (() -> Void)?
    
    @IBAction func tabLikeAction(_ sender: Any) {
        onLikeTap?()
    }
    
    func setMarkVM(mark: MarkTableViewCellVM) {
        loadImageIcon(fromURLString: mark.iconUrl)
        nameLabel.text = mark.name
        summaryLabel.text = mark.summary
        configureFavoriteBtn(forState: mark.isFavorite)
        onLikeTap = mark.onLikeTap
    }
    
    private func loadImageIcon(fromURLString: String) {
        iconImageView.sd_setImage(with: URL(string: fromURLString),
                              placeholderImage: UIImage(systemName: "location.circle.fill"))

    }
    
    private func configureFavoriteBtn(forState: Bool) {
        let favoriteImageName = forState ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName:favoriteImageName), for: .normal)
    }
}
