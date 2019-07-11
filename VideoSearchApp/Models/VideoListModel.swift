//
//  VideoListModel.swift
//  VideoSearchApp
//
//  Created by kk-project on 2019/07/03.
//  Copyright © 2019 kk-project. All rights reserved.
//

import Alamofire
import SwiftyJSON

class VideoListModel {

    // 基本となるベースURL
    let baseUrl = "https://api.search.nicovideo.jp/api/v2/video/contents/search"

    /**
     *  動画情報を取得するAPI
     *  - Parameters:
     *    - searchWord: 検索ワード
     *    - completion: データ取得完了を通知するクロージャー
     *  - Note:
     *  Modelは非同期通信のため、完了後にcompletionで通知する。
     */
    func fetch(searchWord: String, completion: @escaping ([VideoDataEntity]) -> ()) {
        // キーワードをURL用文字列にエンコード
        guard let searchWord = searchWord.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            print("キーワードの変換に失敗しました。")
            return
        }

        // 検索ワードによるパラメータ付与
        let paramSerchWord = "?q=" + searchWord

        // 検索対象（タイトル）
        let paramTarget = "&targets=title"

        // 検索結果数（サーバーに負荷をかけない)
        let paramLimit = "&_limit=3"

        // 並び順（再生数順）
        let paramSort = "&_sort=-viewCounter"

        // 要求するパラメータ
        let paramItem = "&fields=contentId,title,viewCounter,thumbnailUrl"

        // なるべく指定してほしいとあったApp名（サンプル値）
        let paramAppName = "&_context=apiguide"

        // 実際に要求するリクエストURL
        let requestUrl = baseUrl + paramSerchWord + paramTarget + paramLimit + paramSort + paramItem + paramAppName

        print("URL:\(requestUrl)")
        // Alamofireを利用して通信を行います。
        Alamofire.request(requestUrl).responseJSON { (response: DataResponse<Any>) in

            if response.result.isFailure == true {
                // 通信エラー
                print("通信エラー")
                return
            }

            // "guard let 変数 〜 else" で変数の中身がnilの場合のみの処理が書けます。
            // ただし最後に必ずreturnで関数を終了させなければいけません。
            // 変数は以後の関数内でも利用できます。
            guard let val = response.result.value as? [String: Any] else {
                // JSOではない
                print("JSONではない")
                return
            }

            // responseJSONを使うと辞書形式でも扱えますが、今回はより簡単に扱うためにSwiftyJSONを利用します。
            let json = JSON(val)

            // 取得データを表示
            print(" ** json.description:\(json.description)" )

            // 取得データを扱いやすいデータに変更
            let prefJSON = json["data"].arrayValue
            let data = prefJSON.map { data in
                return VideoDataEntity(item: data)
            }
            completion(data)
        }
    }

}


public struct VideoDataEntity {
    let title: String
    let contentId: String
    let imageUrl: String
    let count: Int

    init(item: JSON) {
        self.title = item["title"].stringValue
        self.contentId = item["contentId"].stringValue
        self.imageUrl = item["thumbnailUrl"].stringValue
        self.count = item["viewCounter"].intValue
    }
}
