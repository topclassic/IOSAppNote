//
//  NewNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by WebEngineering on 2/4/2559 BE.
//  Copyright © 2559 Chris Orcutt. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    var currentNote: Note?

    override func viewDidLoad() { //ทำเมื่อโหลดหน้า
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { //ฟังชันนี้ทำงานทุกครั้ง ก่อนที่จะเปลี่ยนไปอีกหน้านึง คือกดปุ่ม
        
        if(segue.identifier == "ShowNewNote"){
            currentNote = Note() //สร้าง note เปล่าๆขึ้นมา
            let noteDisplay = segue.destinationViewController as! NoteDisplayViewController
            noteDisplay.note = currentNote
        }
    }


}
