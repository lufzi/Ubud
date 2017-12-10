//
//  ExampleViewController.swift
//  Ubud-Example
//
//  Created by Luqman Fauzi on 22/10/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ExampleCell"

final class ExampleViewController: UITableViewController {

    init() {
        super.init(style: .grouped)
        self.title = "Ubud 🏞"
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = 50.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = indexPath.row == 0 ? "Local Resource Sample" : "Remote Resource Sample"
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let localResourceViewController = LocalResourceViewController()
            navigationController?.pushViewController(localResourceViewController, animated: true)
        } else {
            let remoteResourceViewController = RemoteResourceViewController()
            navigationController?.pushViewController(remoteResourceViewController, animated: true)
        }
    }
}
