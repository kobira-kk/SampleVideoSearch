//
//  VideoListViewModel.swift
//  VideoSearchApp
//
//  Created by kk-project on 2019/07/10.
//  Copyright © 2019 kk-project. All rights reserved.
//


class VideoListViewModel {

    // 動画一覧情報
    var videoList: [VideoDataEntity] = []

    /**
     *  Modelからデータを取得
     *  - Parameters:
     *    - searchWord: 検索ワード
     *    - completion: データ取得完了を通知するクロージャー
     *  - Note:
     *  Modelは非同期通信のため、完了後にcompletionで通知する。
     */
    func fetch(searchWord: String, completion: @escaping () -> ()) {
        VideoListModel().fetch(searchWord: searchWord) { [weak self] (videoList) in
            self?.videoList = videoList
            completion()
        }
    }


}
