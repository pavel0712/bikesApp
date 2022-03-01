//
//  MarkDetailVC.swift
//  bikeCitizens
//
//  Created by Paul on 28.02.22.
//

import UIKit
import MapKit

class MarkDetailVC: UIViewController, UISheetPresentationControllerDelegate {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var markDetailVC: MarkDetailVM?
    var sheetMarkVC: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    func configureSheet() {
        sheetMarkVC.delegate = self
        sheetMarkVC.selectedDetentIdentifier = .medium
        sheetMarkVC.prefersGrabberVisible = true
        sheetMarkVC.detents = [ .medium() ]
    }
    
    func setMarkVM(mark: MarkModel) {
        loadImageIcon(fromURLString: mark.iconURL)
        nameLabel.text = mark.name
        summaryLabel.text = mark.summary
        configureFavoriteBtn(forState: mark.isFavorite)
    }
    
    private func loadImageIcon(fromURLString: String) {
        iconImageView.sd_setImage(with: URL(string: fromURLString),
                              placeholderImage: UIImage(systemName: "location.circle.fill"))

    }
    
    private func configureFavoriteBtn(forState: Bool) {
        let favoriteImageName = forState ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName:favoriteImageName), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSheet()
        
        if let markDetailVC = self.markDetailVC {
            self.setMarkVM(mark: markDetailVC.mark)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
