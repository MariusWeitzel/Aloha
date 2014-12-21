//
//  LocationEditorView.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import UIKit



class LocationEditorView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate{
    
    // Elemente des UI
    @IBOutlet var _outName: UITextField!
    @IBOutlet var _outAdress: UILabel!
    
    // PickerViews
    @IBOutlet var _outWaveType: UIPickerView!
    @IBOutlet var _outWaterDepth: UIPickerView!
    @IBOutlet var _outWaterTemp: UIPickerView!
    @IBOutlet var _outWaterType: UIPickerView!
    
    @IBOutlet weak var _outCoastProperty: UIPickerView!
    @IBOutlet weak var _outBeachType: UIPickerView!
   
    
    // Switch
    @IBOutlet var _outFavorite: UISwitch!
    
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var scrollerView: UIView!
   
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
    
    @IBOutlet weak var coastBtn: UIButton!
    @IBAction func setCoastPropertyByPressingBtn(sender: UIButton) {
        
        if(_outCoastProperty.hidden){
            _outCoastProperty.hidden = false
            
        }
        else{
            _outCoastProperty.hidden = true
            
        }

    }
    
    @IBOutlet weak var beachTypeBtn: UIButton!
    @IBAction func setBeachTypeByPressingBtn(sender: UIButton) {
        if(_outBeachType.hidden){
            _outBeachType.hidden = false
            
        }
        else{
            _outBeachType.hidden = true
            
        }

    }
    //Caution Buttons
    
    
    @IBOutlet weak var caution_JellyfishBtn: UIButton!
    @IBAction func changeBackgroundImageOfBtn(sender: UIButton) {
        
        switch(sender.tag){
        case 0:
            if(!_boolJellyfish){
                sender.setBackgroundImage(UIImage(named: "iosOKHaken.png"), forState: .Normal)
                _boolJellyfish = true
            }
            else{
                sender.setBackgroundImage(UIImage(named: "iosCrossHaken.png"), forState: .Normal)
                _boolJellyfish = false
            }
            break
            
        case 1:
            if(!_boolSharks){
                sender.setBackgroundImage(UIImage(named: "iosOKHaken.png"), forState: .Normal)
                _boolSharks = true
            }
            else{
                sender.setBackgroundImage(UIImage(named: "iosCrossHaken.png"), forState: .Normal)
                _boolSharks = false
            }
            break
            
        case 2:
            if(!_boolRiffs){
                sender.setBackgroundImage(UIImage(named: "iosOKHaken.png"), forState: .Normal)
                _boolRiffs = true
            }
            else{
                sender.setBackgroundImage(UIImage(named: "iosCrossHaken.png"), forState: .Normal)
                _boolRiffs = false
            }
            break

        case 3:
            if(!_boolDirt){
                sender.setBackgroundImage(UIImage(named: "iosOKHaken.png"), forState: .Normal)
                _boolDirt = true
            }
            else{
                sender.setBackgroundImage(UIImage(named: "iosCrossHaken.png"), forState: .Normal)
                _boolDirt = false
            }
            break

        case 4:
            if(!_boolCautionXY){
                sender.setBackgroundImage(UIImage(named: "iosOKHaken.png"), forState: .Normal)
                _boolCautionXY = true
            }
            else{
                sender.setBackgroundImage(UIImage(named: "iosCrossHaken.png"), forState: .Normal)
                _boolCautionXY = false
            }
            break

        case 5:
            if(!_boolCautionZX){
                sender.setBackgroundImage(UIImage(named: "iosOKHaken.png"), forState: .Normal)
                _boolCautionZX = true
            }
            else{
                sender.setBackgroundImage(UIImage(named: "iosCrossHaken.png"), forState: .Normal)
                _boolCautionZX = false
            }
            break

            
        default: break
        }
        
    }
    
    
    /* Buttons and their funcs Ende */
    
    @IBAction func setDifficultyBySlider(sender: UISlider) {
    }
    
    @IBOutlet weak var _outTextbox: UITextView!
    
    /* PickerView und weitere Attributeinstellungen */
    var _intWaveType = 0
    var _intWaterDepth = 0
    var _intWaterTemp = 0
    var _intWaterType = 0
    
    var _intCoastproperty = 1
    var _intBeachType = 0
    
    var _intDifficulty = 1
    
    var _boolJellyfish = false
    var _boolSharks = false
    var _boolRiffs = false
    var _boolDirt = false
    var _boolCautionXY = false
    var _boolCautionZX = false
    
    var items: [String] = ["Koordinaten", "Adresse", "Name", "Beschreibung"]
    var itemValue = Array<String>()
    
   
    var addressText:String = "Adresse wird geladen"
    var surfSpotName:String = "surfSpotName"
    var spotDescription:String = "Spot Beschreibung"
    
    let _dataWaveType = wavetype()
    let _dataWaterDepth = waterdepth()
    let _dataWaterTemp = watertemperature()
    let _dataWaterType = watertype()
    
    let _dataCoastProperty = coastproperties()
    let _dataBeachType = beachtype()
    
    var currentCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroller.contentSize = CGSizeMake(730, 750)
        scroller.scrollEnabled = true
        scroller.showsVerticalScrollIndicator = true
        scroller.addSubview(scrollerView)
        view.addSubview(scroller)
        var coordString: String  = String(format: "%f", self.currentCoordinate.latitude) + ", " + String(format: "%f", self.currentCoordinate.longitude)
        
        _outWaveType.delegate = self
        _outWaterDepth.delegate = self
        _outWaterTemp.delegate = self
        _outWaterType.delegate = self
        
        _outCoastProperty.delegate = self
        _outBeachType.delegate = self
        
        
        self.itemValue.append(coordString)
        self.addressText = getAddress(currentCoordinate)
        self.itemValue.append(self.addressText)
        self.itemValue.append(self.surfSpotName)
        self.itemValue.append(self.spotDescription)
        
        _outAdress.text = "Adresse wird geladen"
        
        
        _outWaveType.dataSource = self
        _outWaterDepth.dataSource = self
        _outWaterTemp.dataSource = self
        _outWaterType.dataSource = self
        _outCoastProperty.dataSource = self
        _outBeachType.dataSource = self
        
        
        _outWaveType.hidden = true
        _outWaterDepth.hidden = true
        _outWaterTemp.hidden = true
        _outWaterType.hidden = true
        _outCoastProperty.hidden = true
        _outBeachType.hidden = true
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
        } else if pickerView.tag == 4 {
            return  _dataCoastProperty.count
        } else if  pickerView.tag == 5 {
            return _dataBeachType.count
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
        } else if pickerView.tag == 4 {
            return _dataCoastProperty[row]
        } else if pickerView.tag == 5 {
            return _dataBeachType[row]
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
        else if pickerView.tag == 4 {
            _intCoastproperty = row
            coastBtn.setTitle(_dataCoastProperty[row], forState: .Normal)
            _outCoastProperty.hidden = true
            
        } else if pickerView.tag == 5 {
            _intBeachType = row
            beachTypeBtn.setTitle(_dataBeachType[row], forState: .Normal)
            _outBeachType.hidden = true
            
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