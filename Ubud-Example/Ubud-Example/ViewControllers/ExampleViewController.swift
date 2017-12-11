//
//  ExampleViewController.swift
//  Ubud-Example
//
//  Created by Luqman Fauzi on 22/10/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

public enum Example: String {
    case paginationTextExample = "Text Indicator Page"
    case paginationDotExample = "Dot Indicator Page"
}

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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = indexPath.row == 0 ? "Text Indicator Page" : "Dot Indicator Page"
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Pagination Indicator Example"
        } else {
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exampleGalleryViewController: ExampleGalleryViewController
        if indexPath.row == 0 {
            exampleGalleryViewController = ExampleGalleryViewController(example: .paginationTextExample)
        } else {
            exampleGalleryViewController = ExampleGalleryViewController(example: .paginationDotExample)
        }
        navigationController?.pushViewController(exampleGalleryViewController, animated: true)
    }
}
