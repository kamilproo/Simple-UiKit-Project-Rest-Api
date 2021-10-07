//
//  ViewController.swift
//  UiKitRestApiApp
//
//  Created by kamil on 07.10.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    var post = [Post]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        getPosts()
        // Do any additional setup after loading the view.
    }
    
    private func getPosts() {
        ApiClient.shared.getPostDate { [weak self] (post) in
            guard let self = self else { return }
            switch post {
            case let .success(data):
                self.post = data
            case let .failure(error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath)
        let post = post[indexPath.row]
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        return cell
    }
}

