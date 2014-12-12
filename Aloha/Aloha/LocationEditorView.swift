//
//  LocationEditorView.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import UIKit



class LocationEditorView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
//    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var waveTypePicker: UIPickerView!
    
    
    var items: [String] = ["Koordinaten", "Adresse", "Name", "Beschreibung"]
    var itemValue = Array<String>()
    
   
    var addressText:String = "Adresse wird geladen"
    var surfSpotName:String = "surfSpotName"
    var spotDescription:String = "Spot Beschreibung"
    
    let pickerData = [watertemperature(), waterdepth(), watertemperature(), watertype()]
    
    var currentCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        var coordString: String  = String(format: "%f", self.currentCoordinate.latitude) + ", " + String(format: "%f", self.currentCoordinate.longitude)
        
        self.itemValue.append(coordString)
        self.addressText = getAddress(currentCoordinate)
        self.itemValue.append(self.addressText)
        self.itemValue.append(self.surfSpotName)
        self.itemValue.append(self.spotDescription)
        
        waveTypePicker.dataSource = self
        
//         waveTypePicker.dataSource = pickerData
        
        
        
//        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        self.tableView.dataSource = self
//        tableView.estimatedRowHeight = 89
//        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
//        return pickerData[component].count
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        println(pickerData[row])
    }
    
    
    
    // Sucht zur gegebenen Koordinate die Adresse raus und speichert sie in das Array für die tableView.
    func getAddress(coord: CLLocationCoordinate2D) -> String{
        let geocoder = GMSGeocoder()
        
        
        var newAddress: String = "Adresse wird geladen"
        geocoder.reverseGeocodeCoordinate (coord){ response , error in
        
            if let address = response?.firstResult() {
                let lines = address.lines as [String]
                newAddress = join(" ", lines)
                self.addressText = newAddress
                if(!self.itemValue.isEmpty){
                    self.itemValue.removeAtIndex(1)
                    self.itemValue.insert(newAddress, atIndex: 1)
//                    self.tableView.reloadData()
                }
            }
        }
       return newAddress
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.items.count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell // erzeugt eine Zelle in der Tabelle
//        cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell") // zeigt eine Wertefeld in der erzeugten Zelle an
//        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
//        cell.editingAccessoryType = UITableViewCellAccessoryType.DisclosureIndicator
//        cell.textLabel?.text? = self.items[indexPath.row]
//        cell.detailTextLabel?.text = self.itemValue[indexPath.row] // String(format: "%f", currentSpotLatitude)
//        return cell
//        
//    }
    
   
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        println("You selected cell #\(indexPath.row)!")
//    }
    
//    func tableView(tableView: UITableView,
//        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
//        forRowAtIndexPath indexPath: NSIndexPath) {
//            switch editingStyle {
//            case .Delete:
//                // remove the deleted item from the model
//                self.items.removeAtIndex(indexPath.row)
//                
//                // remove the deleted item from the `UITableView`
//                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            default:
//                return
//            }
//    }
    /*
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject!) {
            // sender is the tapped `UITableViewCell`
            let cell = sender as UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)
            
            // load the selected model
            let item = self.items[indexPath!.row]
            
            let detail = segue.destinationViewController as LocationEditorView
            // set the model to be viewed
            detail.item = item
    }
*/
    
    
    
    @IBAction func back2initialViewController(Sender: UIButton) {
        // erst mal Daten speichern
        //TODO: gegen echte Werte aus den Feldern ersetzen!
        //FIXME: das is nur zu Testzwecken!
        var testPunkt = Location()
        testPunkt.name = "Hier wird ein Name stehen"
        testPunkt.favorite = false
        testPunkt.adress = "dummy Straße 12"
        testPunkt.tags = ["sportlich", "nass"]
        testPunkt.waterproperties = ["wellig", "auf und ab"]
        testPunkt.coastproperties = ["sandig", "flach"]
        testPunkt.notes = "nuffin to say"
        testPunkt.possibleDangers = ["Hipsters möglich"]
        testPunkt.difficulty = "pretty easy"

        Vault.saveLocation(testPunkt)
        
        // View wechseln
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MapView") as MapController
        navigationController?.popViewControllerAnimated(true)
        //self.presentViewController(secondViewController, animated: true, completion: nil)
       
        
        println("zurück zum ersten ViewController")
    }
}