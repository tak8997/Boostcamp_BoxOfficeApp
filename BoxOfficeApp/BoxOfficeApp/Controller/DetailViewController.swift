//
//  DetailViewController.swift
//  BoxOfficeApp
//
//  Created by oingbong on 15/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var id: String?
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        configure()
    }
    
    private func configure() {
        guard let movieId = id else { return }
        Parser.jsonUrl(with: movieId, type: .id) { (item) in
            guard let movieItem: Movie = Parser.decode(from: item) else { return }
            self.movie = movieItem
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let infoCell = tableview.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell, let movie = movie {
            infoCell.configure(from: movie)
            return infoCell
        }
        return UITableViewCell(frame: CGRect(origin: .zero, size: .zero))
    }
}
