//
//  FavoritesVC.swift
//  bikeCitizens
//
//  Created by Paul on 27.02.22.
//

import UIKit

class FavoritesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private lazy var marksVM = PlaceListVM(withView: self)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        marksVM.fetchData()
    }

}


extension FavoritesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marksVM.numberOfMarks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarkTableViewCell", for: indexPath) as? MarkTableViewCell
        else { return UITableViewCell() }
        
        let markVM = marksVM.getMarkTableViewCellVM(atIndex:indexPath)
        cell.setMarkVM(mark: markVM)
        return cell
    }
    
}

extension FavoritesVC: MarkListTableViewInput {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func deleteRows(at: [IndexPath]) {
        tableView.deleteRows(at: at, with: .fade)
    }
    
}
