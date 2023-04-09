//
//  MainDetailsViewController.swift
//  SMovie
//
//  Created by Alexander Altman on 09.04.2023.
//

import UIKit

final class MainDetailsViewController: UIViewController {
    
    private let mainDetailsView = MainDetailsView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpDelegates()
        setUpView()
    }
    
    private func setUpDelegates() {
        mainDetailsView.tableView.delegate = self
        mainDetailsView.tableView.dataSource = self
    }
    
    private func setUpView() {
        title = "Details"
        
        view.addSubview(mainDetailsView)
        NSLayoutConstraint.activate([
            mainDetailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainDetailsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainDetailsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainDetailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: - TableView
extension MainDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainDetailsTableViewCell.identifier,
                                                 for: indexPath) as! MainDetailsTableViewCell
        
        return cell
    }
}
