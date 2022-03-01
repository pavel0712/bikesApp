//
//  MarkDetailVM.swift
//  bikeCitizens
//
//  Created by Paul on 28.02.22.
//

import Foundation
import CoreLocation

struct MarkDetailVM {

    var iconUrl: String {
        return mark.iconURL
    }
    
    var name: String {
        return mark.name
    }
    
    var summary: String {
        return mark.summary
    }
    
    var isFavorite: Bool {
        return StoreManager.shared.isPlaceExist(placeID: mark.markID)
    }
    
    var location2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: mark.lat, longitude: mark.lon)
    }
    
    var location: CLLocation {
        return CLLocation(latitude: mark.lat, longitude: mark.lon)
    }
    
    private var mark: MarkModel

    init(mark: MarkModel) {
        self.mark = mark
    }
    
}
