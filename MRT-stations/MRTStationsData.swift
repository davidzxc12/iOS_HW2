//
//  MRTStationsData.swift
//  MRT-stations
//
//  Created by  Bryant on 2016/5/10.
//  Copyright © 2016年  Bryant. All rights reserved.
//

import Foundation
import ObjectMapper


struct Line {
    let name:String
    let stations:[Station]
    
}

struct Station {
    var name:String = ""
    var lines:NSDictionary = [String:String]()
}

extension Station:Mappable{
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.name <- map["name"]
        self.lines <- map["lines"]
    }
}

enum MRTStationsSourceErrorType: ErrorType {
    case FileNotFound
    case InvalidContent
}

struct MRTStationsSource {
    var lines:[Line] = []
    init(contentOfFile path:String) throws {
        let filepath = try! String(contentsOfFile:path)
        guard let jsonData = Mapper<Station>().mapArray(filepath) else{
            throw MRTStationsSourceErrorType.FileNotFound
        }
        var LinesStationMap = [String:[Station]]()
        for StationDict in jsonData {
            for (key,_) in StationDict.lines {
                if(LinesStationMap[key as! String] == nil){
                    LinesStationMap[key as! String] = []
                }
                LinesStationMap[key as! String]!.append(StationDict)
            }
        }
        
        var _lines = [Line]()
        for(lineName,stations) in LinesStationMap {
            let line = Line(name: lineName, stations: stations)
            _lines.append(line)
        }
        self.lines = _lines.sort{(lineA:Line ,lineB:Line) -> Bool in
            lineA.name < lineB.name
        }
        
    }
}