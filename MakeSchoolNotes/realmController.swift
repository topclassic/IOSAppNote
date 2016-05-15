//
//  realmController.swift
//  MakeSchoolNotes
//
//  Created by Chotipat on 5/15/2559 BE.
//  Copyright © 2559 Chris Orcutt. All rights reserved.
//
import UIKit
import RealmSwift
class realmController: UITableViewController {
    
    // var text = ["123","12"]
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCellWithIdentifier("ViewCell", forIndexPath: indexPath) as! ViewCell
        let row = indexPath.row
        let note = notes[row]as Notes
        cell.note = note
       // cell.testLabel?.text = text[indexPath.row] //โชว var text ด้านบน
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return text.count // คืนค่าตามตัวแปรใน text
        return notes.count
    }
    
    // realmswift ข้อ 6
    var notes: Results<Notes>! {
        didSet{//ทำให้ table view อัพเดทการแสดงผลทุกครั้งที่มีการเปลี่ยนแปลงข้อมูล
            tableView.reloadData()
        }
    }
    override func viewDidLoad() { //ทุกครั้งที่มีการโหลดข้อมูลให้รู้ว่านำข้อมูลมาจากไหน
        let myNote = Notes()
        myNote.first = "123222"
       // super.viewDidLoad()
       // tableView.dataSource = self
        do{
            let realm = try Realm()
            try realm.write(){//save ข้อมูลลงเครื่อง
                realm.add(myNote)
            }
            notes = realm.objects(Notes)//load ข้อมูลจากเครื่อง
        }catch{
            print("error")
        }
    }
    
}