//
//  MarkTableViewCellVM.swift
//  bikeCitizens
//
//  Created by Paul on 27.02.22.
//

import Foundation

struct MarkTableViewCellVM {
    
    var iconUrl: String
    var name: String
    var summary: String
    var isFavorite: Bool
    var onLikeTap: () -> Void
    
    init(mark: MarkModel, onLikeTap: @escaping() -> Void) {
        self.iconUrl = mark.iconURL
        self.name = mark.name
        self.summary = mark.summary
        self.isFavorite = mark.isFavorite
        self.onLikeTap = onLikeTap
    }
    
    init(place: Place, onLikeTap: @escaping() -> Void) {
        self.iconUrl = place.iconURL!
        self.name = place.name!
        self.summary = place.summary!
        self.isFavorite = true
        self.onLikeTap = onLikeTap
    }
    
    
    init(iconUrl: String, name: String, summary: String, isFavorite: Bool = false, onLikeTap:@escaping() -> Void) {
        self.iconUrl = iconUrl
        self.name = name
        self.summary = summary
        self.isFavorite = isFavorite
        self.onLikeTap = onLikeTap
    }
    
}
