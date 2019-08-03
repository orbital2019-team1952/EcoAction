//
//  AchievementViewController.swift
//  EcoAction
//
//  Created by Shirley Wang on 29/6/19.
//  Copyright © 2019 Orbital2019Team1952. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import CoreCharts


class AchievementViewController: UIViewController, CoreChartViewDataSource {
    
    @IBOutlet weak var personal: UIButton!
    @IBOutlet weak var forAll: UIButton!
    @IBOutlet weak var sevenDays: UIButton!
    @IBOutlet weak var thirtyDays: UIButton!
    
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var barChart: HCoreBarChart!
    var ref: DatabaseReference! = Database.database().reference()
    
    var chartData: [CoreChartEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        
        barChart.displayConfig.backgroundColor = UIColor.clear
        
        personal.isSelected = true
        personal.isHighlighted = true
        forAll.isSelected = false
        forAll.isHighlighted = false
        
        sevenDays.isSelected = true
        sevenDays.isHighlighted = true
        thirtyDays.isSelected = false
        thirtyDays.isHighlighted = false
        
        readPersonalData()
        
        barChart.displayConfig.backgroundColor = UIColor.clear
        barChart.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func setLabel() {
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        ref.child("users").child(userID).observe( DataEventType.value, with: { (snapshot) in
            
            guard let dict = snapshot.value as? [String:AnyObject] else { return }
            
            guard let nicknameText = dict["nickname"] as? String else { return }
            
            guard let pointNum = dict["points"] as? Int else { return }
            
            self.nickname.text = nicknameText
            
            self.point.text = "\(pointNum)"
        })
        
    }
    
    func loadCoreChartData() -> [CoreChartEntry] {
        print(chartData)
        return chartData
    }
    
    func readPersonalData() {
        var ref: DatabaseReference! = Database.database().reference()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        ref.child("users/\(userID)/achievement").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            let today = Date()
            let date = self.turnTimeString(date: today)
            let dformatter = DateFormatter()
            dformatter.dateFormat = "yyyy-MM-dd"
            let currentDate = dformatter.date(from: date)
            
            var lunchbox = 0
            var straw = 0
            var bag = 0
            var recyc = 0
            var light = 0
            
            guard let results = snapshot.value as? [String: Any] else { return } //changed
            let keyInOrder = results.keys.sorted(by: >)
            var tempAch: [CoreChartEntry] = []
            for key in keyInOrder {
                let action = results[key] as! [String: Any]
                let timeInterval = action["timeInterval"] as! TimeInterval
                
                let past = Date(timeIntervalSince1970: timeInterval)
                let pastDate = dformatter.date(from: self.turnTimeString(date: past))
                
                let diffInDays = Calendar.current.dateComponents([.day], from: pastDate as! Date, to: currentDate as! Date).day
                guard let diff = diffInDays else { return }
                
                let duration = self.sevenDays.isSelected ? 7 : 30
                if diff > duration { break }
                
                let prepare = action["prepare your own lunchbox"] as! Bool
                let reduce = action["reduce using plastic straw"] as! Bool
                let reuse = action["reuse plastic bag or bring your own bag"] as! Bool
                let recycle = action["recycle plastic or can or paper"] as! Bool
                let turnOff = action["turn off the light when leaving"] as! Bool
                
                lunchbox += (prepare ? 1 : 0)
                straw += (reduce ? 1 : 0)
                bag += (reuse ? 1 : 0)
                recyc += (recycle ? 1 : 0)
                light += (turnOff ? 1 : 0)
            }
            let title = ["prepare your own lunchbox", "reduce using plastic straw", "reuse plastic bag or bring your own bag", "recycle plastic or can or paper", "turn off the light when leaving"]
            let num = [lunchbox, straw, bag, recyc, light]
            
            for index in 0..<title.count {
                let newEntry = CoreChartEntry(id: "\(num[index])",
                    barTitle: title[index],
                    barHeight: Double(num[index]),
                    barColor: self.rainbowColor())
                
                
                tempAch.append(newEntry)
            }
            self.chartData = tempAch
            //self.barChart.setNeedsDisplay()
            self.barChart.displayConfig.backgroundColor = UIColor.clear
            self.barChart.reload()
            self.barChart.displayConfig.backgroundColor = UIColor.clear
        })
    }
    
    func readPubicDate() {
        var ref: DatabaseReference! = Database.database().reference()
        ref.child("public").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            let today = Date()
            let date = self.turnTimeString(date: today)
            let dformatter = DateFormatter()
            dformatter.dateFormat = "yyyy-MM-dd"
            let currentDate = dformatter.date(from: date)
            
            var lunchbox = 0
            var straw = 0
            var bag = 0
            var recyc = 0
            var light = 0
            
            let results = snapshot.value as! [String: Any]
            let keyInOrder = results.keys.sorted(by: >)
            var tempAch: [CoreChartEntry] = []
            for key in keyInOrder {
                let action = results[key] as! [String: Any]
                
                let pastDate = dformatter.date(from: key)
                
                let diffInDays = Calendar.current.dateComponents([.day], from: pastDate as! Date, to: currentDate as! Date).day
                guard let diff = diffInDays else { return }
                
                let duration = self.sevenDays.isSelected ? 7 : 30
                if diff > duration { break }
                
                let prepare = action["prepare your own lunchbox"] as! Int
                let reduce = action["reduce using plastic straw"] as! Int
                let reuse = action["reuse plastic bag or bring your own bag"] as! Int
                let recycle = action["recycle plastic or can or paper"] as! Int
                let turnOff = action["turn off the light when leaving"] as! Int
                
                lunchbox += prepare
                straw += reduce
                bag += reuse
                recyc += recycle
                light += turnOff
            }
            let title = ["prepare your own lunchbox", "reduce using plastic straw", "reuse plastic bag or bring your own bag", "recycle plastic or can or paper", "turn off the light when leaving"]
            let num = [lunchbox, straw, bag, recyc, light]
            
            for index in 0..<title.count {
                let newEntry = CoreChartEntry(id: "\(num[index])",
                    barTitle: title[index],
                    barHeight: Double(num[index]),
                    barColor: self.rainbowColor())
                
                
                tempAch.append(newEntry)
            }
            self.chartData = tempAch
            //self.barChart.setNeedsDisplay()
            self.barChart.displayConfig.backgroundColor = UIColor.clear
            self.barChart.reload()
            self.barChart.displayConfig.backgroundColor = UIColor.clear
        })
    }
    
    func turnTimeString(date: Date) -> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd"
        return dformatter.string(from: date)
    }
    
    @IBAction func toggleDuration(_ sender: UIButton) {
        sevenDays.isSelected = !sevenDays.isSelected
        sevenDays.isHighlighted = !sevenDays.isHighlighted
        thirtyDays.isSelected = !thirtyDays.isSelected
        thirtyDays.isHighlighted = !thirtyDays.isHighlighted
        if personal.isSelected {
            readPersonalData()
        } else {
            readPubicDate()
        }
      
        //self.loadCoreChartData()
        
    }
    
    @IBAction func toggleState(_ sender: UIButton) {
        personal.isSelected = !personal.isSelected
        personal.isHighlighted = !personal.isHighlighted
        forAll.isSelected = !forAll.isSelected
        forAll.isHighlighted = !forAll.isHighlighted
        if personal.isSelected {
            readPersonalData()
        } else {
            readPubicDate()
        }
    }
    
}  
