//
//  Note.swift
//  MakeSchoolNotes
//
//  Created by Martin Walsh on 29/05/2015.
//  Updated by Chris Orcutt on 09/07/2015.
//  Copyright © 2015 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift //framwork ที่ใช้ในการติดต่อ database

class Note: Object {
    dynamic var title: String = ""  //dynamic คือ attribute ที่ใช้ในการติดต่อฐานข้อมูล เป็นการจองหน่วยความจำ
    dynamic var content: String = ""
    dynamic var modificationDate = NSDate() //เก๋บข้อมูลวันเวลา
  
}