//
//  LocationEditorView.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import UIKit



class LocationEditorView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    // Elemente des UI
    @IBOutlet var _outName: UITextField!
    @IBOutlet var _outAdress: UILabel!
    
    // PickerViews
    @IBOutlet var _outWaveType: UIPickerView!
    @IBOutlet var _outWaterDepth: UIPickerView!
    @IBOutlet var _outWaterTemp: UIPickerView!
    @IBOutlet var _outWaterType: UIPickerView!
    
   
    
    // Switch
    @IBOutlet var _outFavorite: UISwitch!
    
   
    // Buttons and their functions
    @IBOutlet weak var waveTypeBtn: UIButton!
    @IBAction func settingWaveTypeByPressingButton(sender: UIButton) {
        
        if(!_outWaterType.hidden){
           _outWaveType.hidden = true
           println("aktiv")
        }
        else {
            println("gedrückt")
            _outWaveType.hidden = false
        }

    }
    
    @IBOutlet weak var waterDepthBtn: UIButton!
    @IBAction func settingWaterDepthByPressingBtn(sender: UIButton) {
        if(_outWaterDepth.hidden){
            _outWaterDepth.hidden = false
            
        }
        else{
            _outWaterDepth.hidden = true
          
        }
    }
    
    @IBOutlet weak var waterTempBtn: UIButton!
    @IBAction func settingWaterTempByPressingBtn(sender: UIButton) {
        
        if(_outWaterTemp.hidden){
            _outWaterTemp.hidden = false
           
        }
        else{
            _outWaterTemp.hidden = true
          
        }

    }
    
    @IBOutlet weak var waterTypeBtn: UIButton!
    @IBAction func settingWatertypeByPressingBtn(sender: UIButton) {
       
        if(_outWaterType.hidden){
             _outWaterType.hidden = false
           
        }
        else{
             _outWaterType.hidden = true
           
        }

    }
    
    var _intWaveType = 0
    var _intWaterDepth = 0
    var _intWaterTemp = 0
    var _intWaterType = 0
    
    var items: [String] = ["Koordinaten", "Adresse", "Name", "Beschreibung"]
    var itemValue = Array<String>()
    
   
    var addressText:String = "Adresse wird geladen"
    var surfSpotName:String = "surfSpotName"
    var spotDescription:String = "Spot Beschreibung"
    
    let _dataWaveType = wavetype()
    let _dataWaterDepth = waterdepth()
    let _dataWaterTemp = watertemperature()
    let _dataWaterType = watertype()
    
    var currentCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        var coordString: String  = String(format: "%f", self.currentCoordinate.latitude) + ", " + String(format: "%f", self.currentCoordinate.longitude)
        
        _outWaveType.delegate = self
        _outWaterDepth.delegate = self
        _outWaterTemp.delegate = self
        _outWaterType.delegate = self
        
        self.itemValue.append(coordString)
        self.addressText = getAddress(currentCoordinate)
        self.itemValue.append(self.addressText)
        self.itemValue.append(self.surfSpotName)
        self.itemValue.append(self.spotDescription)
        
        _outAdress.text = "Adresse wird geladen"
        _outAdress.reloadInputViews()
        
        _outWaveType.dataSource = self
        _outWaterDepth.dataSource = self
        _outWaterTemp.dataSource = self
        _outWaterType.dataSource = self
        
        _outWaveType.hidden = true
        _outWaterDepth.hidden = true
        _outWaterTemp.hidden = true
        _outWaterType.hidden = true
        
 //      var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("update"), userInfo: nil, repeats: false)
//         waveTypePicker.dataSource = pickerData
        
        
        
//        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        self.tableView.dataSource = self
//        tableView.estimatedRowHeight = 89
//        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    func update () {
//        dispatch_async(dispatch_get_main_queue(), {
//            self._outAdress.text = self.getAddress(self.currentCoordinate)
//        })
//         var coordString: String  = String(format: "%f", self.currentCoordinate.latitude) + ", " + String(format: "%f", self.currentCoordinate.longitude)
//        self._outAdress.text = coordString
//        println("update: \(coordString)")
//    }
    
    /*
    **************************************************************************
    PickerView Settings:
    
    **************************************************************************
    */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0 {
            return _dataWaveType.count
        } else if pickerView.tag == 1 {
            return _dataWaterDepth.count
        } else if pickerView.tag == 2 {
            return  _dataWaterTemp.count
        } else if  pickerView.tag == 3 {
            return _dataWaterType.count
        }
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if pickerView.tag == 0 {
            return _dataWaveType[row]
        } else if pickerView.tag == 1 {
            return _dataWaterDepth[row]
        } else if pickerView.tag == 2 {
            return _dataWaterTemp[row]
        } else if pickerView.tag == 3 {
            return _dataWaterType[row]
        }
        return ""
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        
        if pickerView.tag == 0 {
            _intWaveType = row
           waveTypeBtn.setTitle(_dataWaveType[row], forState: UIControlState.Normal)
            _outWaveType.hidden = true
          
            
        } else if pickerView.tag == 1 {
            _intWaterDepth = row
            waterDepthBtn.setTitle(_dataWaterDepth[row], forState: .Normal)
            _outWaterDepth.hidden = true
          
        } else if pickerView.tag == 2 {
            _intWaterTemp = row
             waterTempBtn.setTitle(_dataWaterTemp[row], forState: .Normal)
            _outWaterTemp.hidden = true
            
        } else if pickerView.tag == 3 {
            _intWaterType = row
             waterTypeBtn.setTitle(_dataWaterType[row], forState: .Normal)
            _outWaterType.hidden = true
            
        }
    }
    
    
    // --------------------------------------------------------
    
//    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return _dataWaterType.count
////        return pickerData[component].count
//    }
//
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
//        return _dataWaterType[row]
//    }
//    
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
////        println(pickerData[row])
//    }
    
    /*
    **************************************************************************
    PickerView Settings Ende
    
    **************************************************************************
    */
    
    // Sucht zur gegebenen Koordinate die Adresse raus und speichert sie in das Array für die tableView.
    func getAddress(coord: CLLocationCoordinate2D) -> String{
        let geocoder = GMSGeocoder()
        
        
        var newAddress: String = "Adresse wird geladen"
        geocoder.reverseGeocodeCoordinate (coord){ response , error in
        
            if let address = response?.firstResult() {
                let lines = address.lines as [String]
                newAddress = join(" ", lines)
                self.addressText = newAddress
                self._outAdress.text = newAddress
                
//                if(!self.itemValue.isEmpty){
//                    self.itemValue.removeAtIndex(1)
//                    self.itemValue.insert(newAddress, atIndex: 1)
////                    self.tableView.reloadData()
//                }
            }
        }
        println(newAddress)
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
        //      - 
        //      -
        
        //FIXME: das is nur zu Testzwecken!
        var nuPunkt = Location()
        nuPunkt.name = _outName.text
        nuPunkt.favorite = _outFavorite.on
        nuPunkt.adress = _outAdress.text!
        
        nuPunkt._wavetype = _intWaveType
        nuPunkt._waterdepth = _intWaterDepth
        nuPunkt._watertemperature = _intWaterTemp
        nuPunkt._watertype = _intWaterType
        
        //nuPunkt.tags = ["sportlich", "nass"]
        
        nuPunkt._coastproperties = 0
        nuPunkt.notes = "nuffin to say"
        //FIXME: wieder rein damit!
        //nuPunkt.possibleDangers = ["Hipsters möglich"]
        nuPunkt._difficulty = 1

        Vault.saveLocation(nuPunkt)
        
        // View wechseln
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MapView") as MapController
        navigationController?.popViewControllerAnimated(true)
        //self.presentViewController(secondViewController, animated: true, completion: nil)
       
        
        println("zurück zum ersten ViewController")
    }
}