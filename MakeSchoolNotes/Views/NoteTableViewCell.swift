//
//  NoteTableViewCell.swift
//  MakeSchoolNotes
//
//  Created by Martin Walsh on 29/05/2015.
//  Updated by Chris Orcutt on 09/07/2015.
//  Copyright © 2015 MakeSchool. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    static var dateFormatter: NSDateFormatter = { //class NSDateFormatter จัดรูปแบบวันเวลา และใช้ static เพื่อให้ใช้งานตัวแปรร่วมกัน หากมีคลาส 1000 คลาส ก็ประกาศตัวแปร dateFormatter ครั้งเดียวด้วย static //Closure
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" //กำหนด format
        return formatter
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var note: Note?{ //ประกาศตัวแปรขึ้นมาให้เป็นชนิด class Note
        didSet{ //หลังที่ note เปลี่ยนแปลงแล้ว ส่วน wilSet ก่อน note เปลี่ยนแปลง//Closure
            if let note = note, titleLabel = titleLabel, dateLabel = dateLabel{ //check nil ทุกตัว
                titleLabel.text = note.title  //ดึงมาเฉพาะ title
                dateLabel.text = NoteTableViewCell.dateFormatter.stringFromDate(note.modificationDate)
            }
        
        }
    
    }
    
}
//Closure ทำเพื่อให้มันทำงานได้เรย