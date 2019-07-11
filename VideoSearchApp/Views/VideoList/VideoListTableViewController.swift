//
//  VideoListTableViewController.swift
//  VideoSearchApp
//
//  Created by kk-project on 2019/07/03.
//  Copyright © 2019 kk-project. All rights reserved.
//

import UIKit
import SafariServices

class VideoListTableViewController: UITableViewController {

    /// ViewModel
    let viewModel = VideoListViewModel()

    /// 検索ワード
    var searchWord: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetch(searchWord: searchWord, completion: {
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.videoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoListTableViewCell", for: indexPath) as? VideoListTableViewCell else {
            return UITableViewCell()
        }
        print(viewModel.videoList[indexPath.row])
        cell.configure(item: viewModel.videoList[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: "https://www.nicovideo.jp/watch/\(viewModel.videoList[indexPath.row].contentId)") else {
            return
        }
        print(viewModel.videoList[indexPath.row].title)
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
}

extension VideoListTableViewController {

    static func makeInstance(searchWord: String) -> UIViewController {
        // Storyboard`Main`の情報を取得
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        // `VideoListTableViewController`のインスタンスを生成
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "VideoListTableViewController") as? VideoListTableViewController else {
            return UIViewController()
        }
        // 検索ワードに引数で受け取った内容を格納
        vc.searchWord = searchWord
        return vc
    }

}

