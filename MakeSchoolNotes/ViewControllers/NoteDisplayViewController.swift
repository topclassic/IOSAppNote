//
//  NoteDisplayViewController.swift
//  MakeSchoolNotes
//
//  Created by WebEngineering on 2/5/2559 BE.
//  Copyright © 2559 Chris Orcutt. All rights reserved.
//

import UIKit
import RealmSwift

class NoteDisplayViewController: UIViewController {

    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var note: Note?{
        didSet{
            displayNote(note)
        }
    }
    
    func displayNote(note: Note?){
        if let note = note, titleTextField = titleTextField, contentTextView = contentTextView
        {
            titleTextField.text = note.title
            contentTextView.text = note.content
        }
    }
    
    override func viewDidLoad() { //ทำงานทุกครั้งที่หน้าถูกโหลด แต่มันทำงานครั้งเดียวเมื่อ view มันถูกโหลดขึ้นมา
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) { //ทำงานทุกครั้งที่หน้าจอจะถูกโหลดขึนมา
        super.viewWillAppear(animated) //เรียกใช้ฟังชันของคลาสแม่
        displayNote(note)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        saveNote()
    }

    func saveNote(){
        if let note = note{
            do{
                let ream = try Realm()
                
                try ream.write(){
                    if(note.title != self.titleTextField || note.content != self.contentTextView.text ) //note ในฐานข้อมูลเดิม มันไม่ตรงกับที่อยู่ใน textfield คือมันเกิดการเปลี่ยนแปลงขึ้น
                    {
                        note.title = self.titleTextField.text!
                        note.content = self.contentTextView.text
                        note.modificationDate = NSDate()
                    }
                }
            }
            catch{
                print("handle error")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
