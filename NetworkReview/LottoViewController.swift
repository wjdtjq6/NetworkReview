//
//  LottoViewController.swift
//  NetworkReview
//
//  Created by t2023-m0032 on 6/6/24.
//

import UIKit
import Alamofire
import SnapKit

struct Lotto:Decodable {
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
    
    let drwNoDate: String
    
    let drwNo: Int
}

var lottoBounds: [Int] = []
var nowRow = 1122

class LottoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lottoBounds.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(lottoBounds[row])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nowRow = row
        loadData()
    }
    
    let textField = UITextField()
    
    let numberInfoLabel = UILabel()
    let dateLabel = UILabel()
    let separatorView = UIView()
    
    let resultnumberLabel = UILabel()
    let resultLabel = UILabel()
    
    let n1 = UILabel()
    let n2 = UILabel()
    let n3 = UILabel()
    let n4 = UILabel()
    let n5 = UILabel()
    let n6 = UILabel()
    let plusView = UIView()
    let plusImage = UIImageView()
    let n7 = UILabel()
    let bonusLabel = UILabel()
    
    let pickerView = UIPickerView()
    
    lazy var array = [textField, numberInfoLabel, dateLabel, separatorView, resultnumberLabel, resultLabel, n1, n2, n3, n4, n5, n6, plusView, plusImage, n7, bonusLabel]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        configureHierarchy()
        configureLayout()
        configureUI()
        configureFunction()
        
    }
    func configureFunction() {
        textField.addTarget(self, action: #selector(textFieldClicked), for: .touchDown)
        for i in lottoBounds {
            
        }
    }
    @objc func textFieldClicked() {
        pickerView.delegate = self
        pickerView.dataSource = self
        view.addSubview(pickerView)
        pickerView.snp.makeConstraints{ make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)//.offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        for i in 0...1200{
            lottoBounds.append(i)
        }
        pickerView.selectRow(nowRow, inComponent: 0, animated: true)
    }
    func configureHierarchy() {
        for i in array {
            view.addSubview(i)
        }
    }
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-25)
            make.height.equalTo(50)
            //make.width.equalTo(350)
        }
        array[1].snp.makeConstraints { make in
            make.top.equalTo(array[0].snp_bottomMargin).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(25)
        }
        array[2].snp.makeConstraints { make in
            make.top.equalTo(array[0].snp_bottomMargin).offset(30)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-25)
        }
        array[3].snp.makeConstraints { make in
            make.top.equalTo(array[2].snp_bottomMargin).offset(15)
            make.centerX.equalTo(view.safeAreaLayoutGuide)//.offset(25)
            make.height.equalTo(0.5)
            make.width.equalTo(350)
        }
        array[4].snp.makeConstraints { make in
            make.top.equalTo(array[3].snp_bottomMargin).offset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        array[5].snp.makeConstraints { make in
            make.top.equalTo(array[3].snp_bottomMargin).offset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        n1.snp.makeConstraints { make in
            make.top.equalTo(array[4].snp_bottomMargin).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        n2.snp.makeConstraints { make in
            make.top.equalTo(array[4].snp_bottomMargin).offset(20)
            make.leading.equalTo(n1.snp.trailingMargin).offset(12)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        n3.snp.makeConstraints { make in
            make.top.equalTo(array[4].snp_bottomMargin).offset(20)
            make.leading.equalTo(n2.snp.trailingMargin).offset(12)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        n4.snp.makeConstraints { make in
            make.top.equalTo(array[4].snp_bottomMargin).offset(20)
            make.leading.equalTo(n3.snp.trailingMargin).offset(12)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        n5.snp.makeConstraints { make in
            make.top.equalTo(array[4].snp_bottomMargin).offset(20)
            make.leading.equalTo(n4.snp.trailingMargin).offset(12)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        n6.snp.makeConstraints { make in
            make.top.equalTo(array[4].snp_bottomMargin).offset(20)
            make.leading.equalTo(n5.snp.trailingMargin).offset(12)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        plusView.snp.makeConstraints { make in
            make.top.equalTo(array[4].snp_bottomMargin).offset(20)
            make.leading.equalTo(n6.snp.trailingMargin).offset(12)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        plusImage.snp.makeConstraints { make in
            make.edges.equalTo(plusView).inset(13)
        }
        n7.snp.makeConstraints { make in
            make.top.equalTo(array[4].snp_bottomMargin).offset(20)
            make.leading.equalTo(plusView.snp.trailingMargin).offset(12)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        bonusLabel.snp.makeConstraints { make in
            make.top.equalTo(n7.snp_bottomMargin).offset(10)
            make.centerX.equalTo(n7.snp_centerXWithinMargins)
        }
        
        
    }
    func configureUI() {
        view.backgroundColor = .systemBackground
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.textAlignment = .center
        
        numberInfoLabel.text = "당첨번호 안내"
        numberInfoLabel.font = .boldSystemFont(ofSize: 13)
        
        dateLabel.text = "추첨"
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textColor = .lightGray
        
        separatorView.backgroundColor = .lightGray
        
        resultnumberLabel.text = "\(nowRow)회 "
        resultnumberLabel.textColor = .systemYellow
        resultnumberLabel.font = .boldSystemFont(ofSize: 20)
        resultnumberLabel.textAlignment = .right
        
        resultLabel.text = " 당첨결과"
        resultLabel.font = .systemFont(ofSize: 20)
        resultLabel.textAlignment = .left
        
        n1.layer.backgroundColor = UIColor.systemYellow.cgColor
        n1.layer.cornerRadius = 20
        n1.text = "3"
        n1.textAlignment = .center
        n1.textColor = .white
        
        n2.layer.backgroundColor = UIColor.systemBlue.cgColor
        n2.layer.cornerRadius = 20
        n2.text = "6"
        n2.textAlignment = .center
        n2.textColor = .white
        
        n3.layer.backgroundColor = UIColor.systemBlue.cgColor
        n3.layer.cornerRadius = 20
        n3.text = "21"
        n3.textAlignment = .center
        n3.textColor = .white
        
        n4.layer.backgroundColor = UIColor.systemRed.cgColor
        n4.layer.cornerRadius = 20
        n4.text = "30"
        n4.textAlignment = .center
        n4.textColor = .white
        
        n5.layer.backgroundColor = UIColor.systemRed.cgColor
        n5.layer.cornerRadius = 20
        n5.text = "34"
        n5.textAlignment = .center
        n5.textColor = .white
        
        n6.layer.backgroundColor = UIColor.lightGray.cgColor
        n6.layer.cornerRadius = 20
        n6.text = "35"
        n6.textAlignment = .center
        n6.textColor = .white
                
        plusImage.image = UIImage(systemName: "plus")
        plusImage.tintColor = .black
        
        n7.layer.backgroundColor = UIColor.lightGray.cgColor
        n7.layer.cornerRadius = 20
        n7.text = "22"
        n7.textAlignment = .center
        n7.textColor = .white
        
        bonusLabel.text = "보너스"
        bonusLabel.textColor = .gray
        bonusLabel.font = .boldSystemFont(ofSize: 12)
        bonusLabel.textAlignment = .center
        
        pickerView.backgroundColor = .systemGray3
        
    }
    
    func loadData() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo="
        AF.request(url+String(nowRow)).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                self.textField.text = String(value.drwNo)
                
                self.dateLabel.text = value.drwNoDate + " 추첨"
                
                self.resultnumberLabel.text = String(value.drwNo)+"회"
                
                self.n1.text = String(value.drwtNo1)
                self.n2.text = String(value.drwtNo2)
                self.n3.text = String(value.drwtNo3)
                self.n4.text = String(value.drwtNo4)
                self.n5.text = String(value.drwtNo5)
                self.n6.text = String(value.drwtNo6)
                self.n7.text = String(value.bnusNo)
                
                //(도전)for
            case .failure(let error):
                self.textField.text = "정확한 회차를 선택해주세요."
            }
        }
    }
}
