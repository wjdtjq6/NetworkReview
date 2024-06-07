//
//  MovieViewController.swift
//  NetworkReview
//
//  Created by t2023-m0032 on 6/6/24.
//

import UIKit
import SnapKit
import Alamofire
import TextFieldEffects

//{
//  "boxOfficeResult": {
//    "boxofficeType": "일별 박스오피스",
//    "showRange": "20240606~20240606",
//    "dailyBoxOfficeList": [
//      {
//        "rnum": "1",
//        "rank": "1",
//        "rankInten": "0",
//        "rankOldAndNew": "OLD",
//        "movieCd": "20191143",
//        "movieNm": "원더랜드",
//        "openDt": "2024-06-05",

struct Movie: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}

class MovieViewController: UIViewController {

    let textField = HoshiTextField()
    let searchButton = UIButton()
    let tableView = UITableView()
    let tableViewCell = UITableViewCell()
    
    var yesterDay = "20240601"
    
    var list: [DailyBoxOfficeList] = []
    
    func callRequest() {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt="
        AF.request(url+yesterDay).responseDecodable(of: Movie.self) { response in
            switch response.result {
                case .success(let value):
                    print(value)
                self.list = value.boxOfficeResult.dailyBoxOfficeList
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //어제 날짜
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyyMMdd"
        yesterDay = dateFormatter.string(from: Date.now - 86400)
        //
        callRequest()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)

    }
    @objc func searchButtonClicked() {
        yesterDay = textField.text!
        
        callRequest()
        //tableView.reloadData()
        //를 안해도되는 이유는 => CalRequest()에서 tableView.reloadData()를 해주고있음!!
    }
    func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(searchButton)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        
    }
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        tableView.snp.makeConstraints { make in
            //make.top.equalTo(textField.snp_bottomMargin).offset(100) // 왜 안됨??
            make.top.equalTo(view.safeAreaLayoutGuide).offset(70)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.rowHeight = 50
    }
    func configureUI(){
        view.backgroundColor = .black
        textField.borderActiveColor = .white
        textField.borderInactiveColor = .systemGray2
        textField.textColor = .white
        
        searchButton.backgroundColor = .white
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
}
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.backgroundColor = .clear
        cell.rankingLabel.text = list[indexPath.row].rank
        cell.titleLabel.text = list[indexPath.row].movieNm
        cell.dateLabel.text = list[indexPath.row].openDt

        return cell
    }
    
    
}
