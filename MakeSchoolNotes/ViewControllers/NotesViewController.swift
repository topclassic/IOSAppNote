//
//  NotesViewController.swift
//  MakeSchoolNotes
//
//  Created by Martin Walsh on 29/05/2015.
//  Updated by Chris Orcutt on 09/07/2015.
//  Copyright © 2015 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class NotesViewController: UITableViewController {
    
    var SelectedNote: Note? //ตัวแปรเอาไว้เก็บค่าข้อมูลของ  note ที่ถูกเลือก
 
    var notes: Results<Note>!{ //สร้างตัวแปรมาเก็บข้อมูล ต้องเป็น Results
        didSet{
            tableView.reloadData()
        }
    }
    
  override func viewDidLoad() { //ทุกครั้งที่มีการโหลดข้อมูล
    super.viewDidLoad()
    tableView.dataSource = self //ให้มันเก็บข้อมูลของตัวเองไว้
    tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
    //let myNote = Note()    //เตรียมข้อมูลเป็นก้อนลอยๆ ยังไม่ได้ลงฐานข้อมูล
    //myNote.title = "Super Simple Test Note"
    //myNote.content = "A long piece of content"
    
    //ยัดข้อมูลลงฐานข้อมูลใช้คำสั่ง do catch
    do{
        let realm = try Realm()//ดึงก้อนข้อมูลของเครื่อง
        
       /* try realm.write(){
            realm.add(myNote) //เพิ่มเข้าไปในหน่วยความจำจริงๆ
        }*/
        notes = realm.objects(Note).sorted("modificationDate", ascending: false) //update ข้อมูลให้กับ ตัวแปร notes
    }
    catch{
        print("handle error")
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "ShowNote"){
        let noteDisplay = segue.destinationViewController  as! NoteDisplayViewController
        noteDisplay.note = SelectedNote
        }
    }
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) { //segue คือข้อมูลที่มันจะส่งมา
        if let id=segue.identifier{
           //print("Identifier \(id)")
            
            do{
                let realm = try Realm()  //เชื่อมดาต้าเบส
                
                switch id{  //เช็คว่าการกดปุ่มนั่นเป็นปุ่มอะไร
                    case "Save": //ถ้าตรงกับ Save
                    //1
                    let source = segue.sourceViewController as! NewNoteViewController // create ตัวแปร source เพื่อเรียกใช้ข้อมํลใน currentNote
                    try realm.write(){
                        realm.add(source.currentNote!)
                    }
                case "Delete":
                    try realm.write(){
                        realm.delete(self.SelectedNote!)
                        }
                    let sourse = segue.sourceViewController as! NoteDisplayViewController
                    sourse.note = nil
                    
                default: print("Identifier \(id)")
            
                }
                //2
                notes = realm.objects(Note).sorted("modificationDate", ascending: false) //ascending คือเรียงจาก น้อยไปมาก เป็น false คือกลับกัน
            }
            catch{
                print("handle error")
            }
        }
    }

}
extension NotesViewController //เพิ่มความยืดหยุ่นในการใช้งานของคลาสที่มีอยู่
{
    //mark: Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("ShowExistingNote", sender: self)
    }
    
    
    //mark : datasourse
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool //แถวไหนสามารถ editได้บ้าง ฟังชันนี้ทำให้สไลด์ได้
    {
            return false
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            let note = notes[indexPath.row] as Object
            do{
                let realm = try Realm()  //เชื่อมดาต้าเบส
                notes = realm.objects(Note).sorted("modificationDate", ascending: false) //ascending คือเรียงจาก น้อยไปมาก เป็น false คือกลับกัน
            }
            catch {
                print("handel error")
            }

        }
    }
    override func tableView(tableView: UITableView,  //เป็นฟังชันที่ใช้ในการเข้าถึง, indexPath คือ ตำแหน่งของแถวที่วน
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath) as! NoteTableViewCell //as! คือ ไม่อยากเช็คเรียกค่าเรย คล้ายๆการ unwrep
        
        //cell.textLabel?.text = "Hello World"
        //การแสดงข้อมูลต้องรู้ indexPath
        let row = indexPath.row //.row ทำงานแถวที่เท่าไหร่
        let note = notes[row] as Note
        cell.note = note
        
        return cell
    }
    override func tableView(tableView: UITableView, //เป็นฟังชันที่ใช้ในการ
        numberOfRowsInSection section: Int) -> Int
    {
     //return 5 // tableview แสดงผล 5 แถว เรยแสดงคำว่า Hello world 5 แถว
        return notes?.count ?? 0
    }

}
