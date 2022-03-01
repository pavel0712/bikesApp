//
//  MarkListTableViewDelegateType.swift
//  bikeCitizens
//
//  Created by Paul on 01.03.22.
//

import Foundation


protocol MarkListTableViewDelegateType {
    func markDetailVMForSelectedRow(atIndex index: IndexPath) -> MarkDetailVM?
}
