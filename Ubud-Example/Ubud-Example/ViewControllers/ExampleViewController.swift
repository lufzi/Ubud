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
        super.init(nibName: nil, bundle: nil)
        self.title = "Example"
        self.view.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = 55.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "Example 1"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            
        }
    }
}
