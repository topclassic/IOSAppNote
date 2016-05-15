//
//  Notes.swift
//  MakeSchoolNotes
//
//  Created by Chotipat on 5/15/2559 BE.
//  Copyright © 2559 Chris Orcutt. All rights reserved.
//

import Foundation
import RealmSwift

class Notes: Object{//ประกาศข้อมูลตัวแปรที่จะเก็บลง RealmSwift
    dynamic var first: String = ""
    dynamic var second: Int = 0

}