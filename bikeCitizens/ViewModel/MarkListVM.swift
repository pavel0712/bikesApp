//
//  MarkListVM.swift
//  bikeCitizens
//
//  Created by Paul on 28.02.22.
//

import Foundation

class MarkListVM {
    
    private var marks: [MarkModel] = []
    private let apiManager = NetworkManager()
    private let dbManager = StoreManager.shared
    private weak var view: (MarkListTableViewInput & Loadable)?

    init(withView view: (MarkListTableViewInput & Loadable)) {
        self.view = view
    }
    
    
    func requestDataFor(inputName: String) {
        view?.showLoader(true)

        apiManager.loadMarks(withName: inputName) { [weak self] marks in
            guard let marks = marks else { return }
            self?.marks = marks
            self?.view?.showLoader(false)
            self?.view?.reloadData()
        }
    }

}

extension MarkListVM: MarkListTableViewType {
    
    func numberOfMarks() -> Int {
        return marks.count
    }
    
    func getMarkTableViewCellVM(atIndex: IndexPath) -> MarkTableViewCellVM {
        var markModel = marks[atIndex.row]
        markModel.isFavorite = dbManager.isPlaceExist(placeID: markModel.markID)
        return MarkTableViewCellVM(mark: markModel) { [weak self] in
            self?.dbManager.addRemoveMark(mark: markModel)
            self?.view?.reloadData()
        }
    }
}

extension MarkListVM: MarkListTableViewDelegateType {
    
    func markDetailVMForSelectedRow(atIndex index: IndexPath) -> MarkDetailVM? {
        return MarkDetailVM(mark: marks[index.row])
    }

}


