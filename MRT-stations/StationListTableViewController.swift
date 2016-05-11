//
//  StationListTableViewController.swift
//  MRT-stations
//
//  Created by  Bryant on 2016/5/11.
//  Copyright © 2016年  Bryant. All rights reserved.
//

import UIKit
import QuartzCore


class StationListTableViewController: UITableViewController {
    
    var stationData:MRTStationsSource!
    let LineColor:NSDictionary = ["文湖線":UIColor(red: 158/255, green: 101/255, blue: 46/255, alpha: 1),
                                  "淡水信義線":UIColor(red: 203/255, green: 44/255, blue: 48/255, alpha: 1),
                                  "新北投支線":UIColor(red: 248/255, green: 144/255, blue: 165/255, alpha: 1),
                                  "松山新店線":UIColor(red: 0, green: 119/255, blue: 73/255, alpha: 1),
                                  "小碧潭支線":UIColor(red: 206/255, green: 220/255, blue: 0, alpha: 1),
                                  "中和新蘆線":UIColor(red: 1, green: 163/255, blue: 0, alpha: 1),
                                  "板南線":UIColor(red: 0, green: 94/255, blue: 184/255, alpha: 1),
                                  "貓空纜車":UIColor(red:119/255,green:185/255 ,blue:51/255, alpha:1)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        let datapath = NSBundle.mainBundle().pathForResource("MRT", ofType: "json")!
        guard let stationsSource = try? MRTStationsSource(contentOfFile:datapath)else{
            fatalError()
        }
        self.stationData=stationsSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return stationData.lines.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stationData.lines[section].stations.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StationCell", forIndexPath: indexPath)
        let station = self.stationData.lines[indexPath.section].stations[indexPath.row]
        let stationName = self.view.viewWithTag(10) as! UILabel
        stationName.text=station.name
        var i=1;
        for (lineName,code) in station.lines {
            let label = self.view.viewWithTag(500+i) as! UILabel
            label.layer.masksToBounds=true
            label.layer.cornerRadius = 4;
            label.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            label.text = code as! String
            label.textAlignment = NSTextAlignment.Center
            label.backgroundColor = LineColor[lineName as! String] as! UIColor
            label.font = UIFont.boldSystemFontOfSize(18)
            i = i+1
        }
        if station.lines.count==1 {
            let label = self.view.viewWithTag(502)as! UILabel
            label.text = ""
            label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return stationData.lines[section].name
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let segueIdentifier = segue.identifier else {
            return
        }
        
        if segueIdentifier == "ShowDetail" {
            guard let detailViewController = segue.destinationViewController as? StationDetailViewController else {
                return
            }
            guard let cell = sender as? UITableViewCell else { return }
            let indexPath = self.tableView.indexPathForCell(cell)!
            let station = self.stationData.lines[indexPath.section].stations[indexPath.row]
            detailViewController.station = station
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
