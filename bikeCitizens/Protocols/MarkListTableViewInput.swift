//
//  MarkListTableViewInput.swift
//  bikeCitizens
//
//  Created by Paul on 01.03.22.
//

import Foundation

protocol MarkListTableViewInput: AnyObject {
    func reloadData()
}

protocol MarkListTableViewEdit: AnyObject {
    func deleteRows(at: [IndexPath])
}
