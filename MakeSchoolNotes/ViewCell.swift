//
//  ViewCell.swift
//  MakeSchoolNotes
//
//  Created by Chotipat on 5/15/2559 BE.
//  Copyright © 2559 Chris Orcutt. All rights reserved.
//


import UIKit

class ViewCell: UITableViewCell{
    
@IBOutlet weak var testLabel: UILabel!
    
    var note: Notes? {//เรียกคลาส Notes
        didSet{ //โปรแกรมจะทำการ update ทุกๆครั้งที่ข้อมูลมีการเปลี่ยนแปลง
            if let note = note, testLabel = testLabel {
                testLabel.text = note.first
            }
        }
    }
        
}