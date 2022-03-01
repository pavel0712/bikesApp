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
    
    var markDetailVM: MarkDetailVM?
    
    var sheetMarkVC: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    func configureSheet() {
        sheetMarkVC.delegate = self
        sheetMarkVC.selectedDetentIdentifier = .medium
        sheetMarkVC.prefersGrabberVisible = true
        sheetMarkVC.detents = [ .medium() ]
    }
    
    func displayMarkVM(markVM: MarkDetailVM) {
        loadImageIcon(fromURLString: markVM.iconUrl)
        nameLabel.text = markVM.name
        summaryLabel.text = markVM.summary
        configureFavoriteBtn(forState: markVM.isFavorite)
    }
    
    func configureMapView(markVM: MarkDetailVM) {
        mapView.delegate = self
        let point = MKPointAnnotation()
        point.title = markVM.name
        point.coordinate = markVM.location2D
        mapView.addAnnotation(point)
        mapView.centerToLocation(markVM.location)
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
        
        if let markDetail = self.markDetailVM {
            self.displayMarkVM(markVM: markDetail)
            self.configureMapView(markVM: markDetail)
        }
    }

}

extension MarkDetailVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
