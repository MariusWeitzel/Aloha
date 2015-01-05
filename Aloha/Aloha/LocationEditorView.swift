//
//  LocationEditorView.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import UIKit
// Wichtig für die Übertragung der Koordinaten von MapController zu LocationViewEditor und zurück
// zur Regelung der Anzeige des Surfspot-Icons
protocol SurfSpotMarkerDelegate {
    func createNewSurfSpotDidFinish(controller: LocationEditorView, coords: CLLocationCoordinate2D, isFavActive: Bool)
    func deleteSurfSpotDidFinish(controller: LocationEditorView, coords: CLLocationCoordinate2D)
}


class LocationEditorView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate {
    
    
    var delegate:SurfSpotMarkerDelegate? = nil
    
    //spot Location global für diese View anlegen
    var nuPunkt = Location()
    var me:Int = -1
    
    // Elemente des UI
    @IBOutlet var _outName: UITextField!
    @IBOutlet var _outAdress: UILabel!
    var addressText:String = "Adresse wird geladen"

    // PickerViews
    @IBOutlet var _outWaveType: UIPickerView!
    @IBOutlet var _outWaterDepth: UIPickerView!
    @IBOutlet var _outWaterTemp: UIPickerView!
    @IBOutlet var _outWaterType: UIPickerView!
    
    @IBOutlet weak var _outCoastProperty: UIPickerView!
    @IBOutlet weak var _outBeachType: UIPickerView!
   
    // Schwierigkeitsgrad
    @IBOutlet weak var difficultySegmentCtrl: UISegmentedControl!
    
    // Textbox der Notizen
    @IBOutlet weak var _outTextbox: UITextView!
    
    //Löschen Button
    @IBOutlet var _outDeleteBtn: UIButton!
    
    // Favorit
    @IBOutlet var _outFavorite: UISwitch!
    
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var scrollerView: UIView!
   
    // Buttons and their functions
    @IBOutlet weak var waveTypeBtn: UIButton!
    @IBAction func settingWaveTypeByPressingButton(sender: UIButton) {
        
        if(!_outWaterType.hidden){
           _outWaveType.hidden = true
//           println("aktiv")
        }
        else {
//            println("gedrückt")
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
     @IBAction func changeBackgroundImageOfBtn(sender: UIButton) {
        
        switch(sender.tag){
        case 0:
            if(!_boolJellyfish){
                setCautionButtonBackgroundToYES(sender)
                _boolJellyfish = true
            }
            else{
                setCautionButtonBackgroundToNO(sender)
                _boolJellyfish = false
            }
            break
            
        case 1:
            if(!_boolSharks){
                setCautionButtonBackgroundToYES(sender)
                _boolSharks = true
            }
            else{
                setCautionButtonBackgroundToNO(sender)
                _boolSharks = false
            }
            break
            
        case 2:
            if(!_boolRiffs){
                setCautionButtonBackgroundToYES(sender)
                _boolRiffs = true
            }
            else{
                setCautionButtonBackgroundToNO(sender)
                _boolRiffs = false
            }
            break

        case 3:
            if(!_boolDirt){
                setCautionButtonBackgroundToYES(sender)
                _boolDirt = true
            }
            else{
                setCautionButtonBackgroundToNO(sender)
                _boolDirt = false
            }
            break

        case 4:
            if(!_boolCautionXY){
                setCautionButtonBackgroundToYES(sender)
                _boolCautionXY = true
            }
            else{
                setCautionButtonBackgroundToNO(sender)
                _boolCautionXY = false
            }
            break

        case 5:
            if(!_boolCautionZX){
                setCautionButtonBackgroundToYES(sender)
                _boolCautionZX = true
            }
            else{
                setCautionButtonBackgroundToNO(sender)
                _boolCautionZX = false
            }
            break
            
        default: break
        }
    }
    
    func setCautionButtonBackgroundToYES(sender: UIButton){
        sender.setBackgroundImage(UIImage(named: "iosOKHaken.png"), forState: .Normal)
    }
    
    func setCautionButtonBackgroundToNO(sender: UIButton){
        sender.setBackgroundImage(UIImage(named: "iosCrossHaken.png"), forState: .Normal)
    }
    
    // Difficulty Button:
    @IBAction func setSurfSportDifficulty(sender: UISegmentedControl) {
        let segmentedControl = sender as UISegmentedControl
        _intDifficulty =  segmentedControl.selectedSegmentIndex
    }
    
    
    /* Buttons and their funcs Ende */
    
    /* PickerView und weitere Attributeinstellungen */
    var _intWaveType = 0
    var _intWaterDepth = 0
    var _intWaterTemp = 0
    var _intWaterType = 0
    
    var _intCoastproperty = 0
    var _intBeachType = 0
    
    var _intDifficulty = 1
    
    var _boolJellyfish = false
    var _boolSharks = false
    var _boolRiffs = false
    var _boolDirt = false
    var _boolCautionXY = false
    var _boolCautionZX = false
    
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
        
        _outAdress.text = getAddress(currentCoordinate)
        
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
        
// Do any additional setup after loading the view, typically from a nib.
        
        
        for var i:Int=0; i < Locations.count; i++ {
            if (Locations[i].lat == self.currentCoordinate.latitude && Locations[i].long == self.currentCoordinate.longitude) {
                nuPunkt = Locations[i]
                me = i
                _outDeleteBtn.enabled = true
            }
        }
        
        _outName.text = nuPunkt.name
        
        _outFavorite.on = nuPunkt.favorite
        _outAdress.text = nuPunkt.adress
        
        _intWaveType = nuPunkt._wavetype
        _outWaveType.selectRow(_intWaveType, inComponent: 0, animated: false)
        _intWaterDepth = nuPunkt._waterdepth
        _intWaterTemp = nuPunkt._watertemperature
        _intWaterType = nuPunkt._watertype
        
        _intCoastproperty = nuPunkt._coastproperties
        _intBeachType = nuPunkt._beachtype
        
        _outTextbox.text = nuPunkt.notes
        
        _boolJellyfish = nuPunkt.jellyfisch
        _boolSharks = nuPunkt.sharks
        _boolRiffs = nuPunkt.riffs
        _boolDirt = nuPunkt.dirt
        _boolCautionXY = nuPunkt.cautionXY
        _boolCautionZX = nuPunkt.cautionZX
        
        // Defaultwerte der Pickerview-Buttons
        waveTypeBtn.setTitle(_dataWaveType[_intWaveType], forState: .Normal)
        waterDepthBtn.setTitle(_dataWaterDepth[_intWaterDepth], forState: .Normal)
        waterTempBtn.setTitle(_dataWaterTemp[_intWaterTemp], forState: .Normal)
        waterTypeBtn.setTitle(_dataWaterType[_intWaterType], forState: .Normal)
        
        coastBtn.setTitle(_dataCoastProperty[_intCoastproperty], forState: .Normal)
        beachTypeBtn.setTitle(_dataBeachType[_intBeachType], forState: .Normal)
        
        _intDifficulty = nuPunkt._difficulty
        difficultySegmentCtrl.selectedSegmentIndex = nuPunkt._difficulty;
        waveTypeBtn.setTitle(_dataWaveType[_intWaveType], forState: .Normal)
    }
    
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
        }
        else if pickerView.tag == 1 {
            _intWaterDepth = row
            waterDepthBtn.setTitle(_dataWaterDepth[row], forState: .Normal)
            _outWaterDepth.hidden = true
        }
        else if pickerView.tag == 2 {
            _intWaterTemp = row
             waterTempBtn.setTitle(_dataWaterTemp[row], forState: .Normal)
            _outWaterTemp.hidden = true
        }
        else if pickerView.tag == 3 {
            _intWaterType = row
             waterTypeBtn.setTitle(_dataWaterType[row], forState: .Normal)
            _outWaterType.hidden = true
        }
        else if pickerView.tag == 4 {
            _intCoastproperty = row
            coastBtn.setTitle(_dataCoastProperty[row], forState: .Normal)
            _outCoastProperty.hidden = true
        }
        else if pickerView.tag == 5 {
            _intBeachType = row
            beachTypeBtn.setTitle(_dataBeachType[row], forState: .Normal)
            _outBeachType.hidden = true
        }
    }
    
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
            }
        }
//        println(newAddress)
        return newAddress
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back2initialViewController(Sender: UIButton) {
        // erst mal Daten speichern
        nuPunkt.lat = self.currentCoordinate.latitude
        nuPunkt.long = self.currentCoordinate.longitude
        
        // falls der Punkt keinen Namen bekommen hat!
        if countElements(_outName.text) == 0 {
//            println("Name ist leer!")
            nuPunkt.name = " "
        }
        else {
            nuPunkt.name = _outName.text
//            println("Name ist \(_outName.text)")
        }
        nuPunkt.favorite = _outFavorite.on
        nuPunkt.adress = _outAdress.text!
        
        nuPunkt._wavetype = _intWaveType
        nuPunkt._waterdepth = _intWaterDepth
        nuPunkt._watertemperature = _intWaterTemp
        nuPunkt._watertype = _intWaterType
        
        nuPunkt._coastproperties = _intCoastproperty
        nuPunkt._beachtype = _intBeachType
        // to avoid loading errors
        if countElements(_outTextbox.text) == 0 {
            nuPunkt.notes = " "
        }
        else {
            nuPunkt.notes = _outTextbox.text
        }
        
        nuPunkt.jellyfisch = _boolJellyfish
        nuPunkt.sharks = _boolSharks
        nuPunkt.riffs = _boolRiffs
        nuPunkt.dirt = _boolDirt
        nuPunkt.cautionXY = _boolCautionXY
        nuPunkt.cautionZX = _boolCautionZX
        
        nuPunkt._difficulty = _intDifficulty
        
        if me >= 0 {
            Locations.removeAtIndex(me)
            me = -1
        }
        Vault.saveLocation(nuPunkt)
        
        // Das Delegate regelt hier den Viewwechsel zur MapView - MapController
        if (delegate != nil) {
            delegate!.createNewSurfSpotDidFinish(self, coords: currentCoordinate, isFavActive: nuPunkt.favorite )
        }
    }
    
    @IBAction func deleteSurfSpot(sender: UIButton) {
        for var i=0; i < Locations.count; i++ {
            if (currentCoordinate.latitude == Locations[i].lat && currentCoordinate.longitude == Locations[i].long) {
//                println("Punkt: \(Locations[i].name)")
                Locations.removeAtIndex(i)
                
//                println("nach dem Löschen noch \(Locations.count) Punkte")
                Vault.saveLocation(nil)
                
                // View wechseln
                if (delegate != nil) {
                    delegate!.deleteSurfSpotDidFinish(self, coords: currentCoordinate)
                }
            }
        }
    }

    
    @IBAction func backButton(sender: UIButton) {
        // View wechseln
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MapView") as MapController
        navigationController?.popViewControllerAnimated(true)
        
//        println("Vorgang abgebrochen")
    }
    
}