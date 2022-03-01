//
//  MarkSearchListVC.swift
//  bikeCitizens
//
//  Created by Paul on 28.02.22.
//

import UIKit

class MarkSearchListVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var markListVM = MarkListVM(withView: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showLoader(false)
        self.tableView.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.searchBar.endEditing(true)
    }
    
    func presentSheet(forMark mark: MarkDetailVM) {
        let storyboard = UIStoryboard(name: "MarkSheet", bundle: nil)
        let sheetMarkDetailVC = storyboard.instantiateViewController(withIdentifier: "MarkDetailVC") as! MarkDetailVC
        sheetMarkDetailVC.markDetailVC = mark
        self.present(sheetMarkDetailVC, animated: true, completion: nil)
    }

}

extension MarkSearchListVC: Loadable {
    
    func showLoader(_ show: Bool) {
        self.tableView.isHidden = show
        if show {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
}

extension MarkSearchListVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return markListVM.numberOfMarks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarkTableViewCell", for: indexPath) as? MarkTableViewCell
        else { return UITableViewCell() }
        
        let model = markListVM.getMarkTableViewCellVM(atIndex:indexPath)
        cell.setMarkVM(mark: model)
        return cell
    }
    
}

extension MarkSearchListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let markDetailVM = markListVM.markDetailVMForSelectedRow(atIndex: indexPath) else { return }
        self.presentSheet(forMark: markDetailVM)
    }
}

extension MarkSearchListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        markListVM.requestDataFor(inputName: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension MarkSearchListVC: MarkListTableViewInput {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func deleteRows(at: [IndexPath]) {
    }
    
}
    
