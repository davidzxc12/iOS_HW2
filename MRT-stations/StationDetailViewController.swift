//
//  StationDetailViewController.swift
//  MRT-stations
//
//  Created by  Bryant on 2016/5/11.
//  Copyright © 2016年  Bryant. All rights reserved.
//

import UIKit

class StationDetailViewController: UIViewController {
    @IBOutlet weak var stationName:UILabel!
    @IBOutlet weak var lineStackView:UIStackView!
    @IBOutlet weak var line2:UILabel!
    @IBOutlet weak var line1:UILabel!
    
    let LineColor:NSDictionary = ["文湖線":UIColor(red: 158/255, green: 101/255, blue: 46/255, alpha: 1),
                                  "淡水信義線":UIColor(red: 203/255, green: 44/255, blue: 48/255, alpha: 1),
                                  "新北投支線":UIColor(red: 248/255, green: 144/255, blue: 165/255, alpha: 1),
                                  "松山新店線":UIColor(red: 0, green: 119/255, blue: 73/255, alpha: 1),
                                  "小碧潭支線":UIColor(red: 206/255, green: 220/255, blue: 0, alpha: 1),
                                  "中和新蘆線":UIColor(red: 1, green: 163/255, blue: 0, alpha: 1),
                                  "板南線":UIColor(red: 0, green: 94/255, blue: 184/255, alpha: 1),
                                  "貓空纜車":UIColor(red:119/255,green:185/255 ,blue:51/255, alpha:1)
    ]

    var station:Station?{
        didSet{
            self.updateValues()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.updateValues()
    }
    
    func updateValues(){
        guard self.isViewLoaded() else{
            return
        }
        self.title = self.station?.name
        self.stationName.text=self.station?.name
        self.stationName.textAlignment = NSTextAlignment.Center
        self.stationName.font = stationName.font.fontWithSize(50)
        let lines = station!.lines.allKeys
        if(self.station?.lines.count == 1){
            lineStackView.removeArrangedSubview(line2)
            line1.text=lines[0] as! String
            line1.textAlignment = NSTextAlignment.Center
            line1.backgroundColor = self.LineColor[lines[0] as! String] as? UIColor
            line1.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            line1.font = UIFont.boldSystemFontOfSize(25)
        }
        else{
            line1.text=lines[0] as! String
            line1.textAlignment = NSTextAlignment.Center
            line2.text=lines[1] as! String
            line2.textAlignment = NSTextAlignment.Center
            line1.backgroundColor = self.LineColor[lines[0] as! String] as? UIColor
            line2.backgroundColor = self.LineColor[lines[1] as! String] as? UIColor
            line1.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            line2.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            line1.font = UIFont.boldSystemFontOfSize(25)
            line2.font = UIFont.boldSystemFontOfSize(25)
        }
        
        
    }
}
