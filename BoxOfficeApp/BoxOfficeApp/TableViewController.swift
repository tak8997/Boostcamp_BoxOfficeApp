//
//  ViewController.swift
//  BoxOfficeApp
//
//  Created by oingbong on 05/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var movies: Movies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        configure()
    }
    
    private func configure() {
        // 1. URL 객체 정의 - else 일 때 사용자에게 알람 (선택사항)
        guard let url = URL(string: "http://connect-boxoffice.run.goorm.io/movies?order_type=1") else { return }
        // 2. URLRequest 객체 정의 및 요청 내용
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // 3. HTTP 메세지 헤더 설정
        
        // 4. URLSession 객체로 전송 및 응답값 처리 로직 작성
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // 4-1. 서버가 응답이 없거나 통신이 실패했을 때
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            do {
                guard let responseData = data else { return }
                let items = try JSONDecoder().decode(Movies.self, from: responseData)
                self.movies = Movies(orderType: items.orderType, data: items.data)
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            } catch {
                print("error")
            }
        }
        
        // 5. GET 전송
        task.resume()
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        guard let items = movies?[indexPath.row] else { return UITableViewCell(frame: CGRect(origin: .zero, size: .zero))}
        cell.configure(from: items)
        return cell
    }
}
