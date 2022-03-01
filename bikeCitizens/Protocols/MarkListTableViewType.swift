//
//  MarkListTableViewType.swift
//  bikeCitizens
//
//  Created by Paul on 27.02.22.
//

import Foundation

protocol MarkListTableViewType {
    func numberOfMarks() -> Int
    func getMarkTableViewCellVM(atIndex: IndexPath) -> MarkTableViewCellVM
}
