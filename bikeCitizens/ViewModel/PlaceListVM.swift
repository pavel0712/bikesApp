//
//  PlaceListVM.swift
//  bikeCitizens
//
//  Created by Paul on 27.02.22.
//

import Foundation

class PlaceListVM {
    
    private let dbManager = StoreManager.shared
    private var marks = StoreManager.shared.fetchPlaces()
    private weak var view: MarkListTableViewInput?
    
    init(withView view: MarkListTableViewInput) {
        self.view = view
    }
    
    func fetchData() {
        self.marks = StoreManager.shared.fetchPlaces()
        self.view?.reloadData()
    }
    
    func numberOfMarks() -> Int {
        return marks.count
    }
    
    func getMarkTableViewCellVM(atIndex indexPath: IndexPath) -> MarkTableViewCellVM {
        let placeModel = marks[indexPath.row]
        return MarkTableViewCellVM(place: placeModel) { [weak self] in
            self?.dbManager.deletePlace(place: placeModel)
            self?.marks.remove(at: indexPath.row)
            self?.view?.deleteRows(at: [indexPath])
            self?.view?.reloadData()
        }
    }
}
