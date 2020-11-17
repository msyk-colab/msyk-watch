//
//  CommonFunctions.swift
//  msyk-watch
//
//  Created by 水谷昌幸 on 2020/11/17.
//

import Foundation

let sensorDataFileName = "SensorData.csv"

func getDateTimeString() -> String{
    let f = DateFormatter()
    f.dateFormat = "yyyy_MMdd_HHmmss"
    let now = Date()
    return f.string(from: now)
}
