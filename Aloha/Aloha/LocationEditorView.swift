//
//  LocationEditorView.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import UIKit

class LocationEditorView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [String] = ["Koordinaten", "Adresse", "Name", "Beschreibung"]
    var itemValue = Array<String>()
    
   
    var addressText:String = "Adresse wird geladen"
    var surfSpotName:String = "surfSpotName"
    var spotDescription:String = "Spot Beschreibung"
    
    var currentCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        var coordString: String  = String(format: "%f", self.currentCoordinate.latitude) + ", " + String(format: "%f", self.currentCoordinate.longitude)
        
        self.itemValue.append(coordString)
        self.addressText = getAddress(currentCoordinate)
        self.itemValue.append(self.addressText) //
        self.itemValue.append(self.surfSpotName)
        self.itemValue.append(self.spotDescription)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.dataSource = self
        tableView.estimatedRowHeight = 89
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view, typically from a nib.
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
                    self.tableView.reloadData()
                }
          
            }
         
        }
        
       return newAddress

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell // erzeugt eine Zelle in der Tabelle
        cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell") // zeigt eine Wertefeld in der erzeugten Zelle an
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.editingAccessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel.text = self.items[indexPath.row]
        cell.detailTextLabel?.text = self.itemValue[indexPath.row] // String(format: "%f", currentSpotLatitude)
        return cell
        
    }
    
   
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
    
    func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            switch editingStyle {
            case .Delete:
                // remove the deleted item from the model
                self.items.removeAtIndex(indexPath.row)
                
                // remove the deleted item from the `UITableView`
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            default:
                return
            }
    }
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
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MapView") as MapController
        navigationController?.popViewControllerAnimated(true)
        //self.presentViewController(secondViewController, animated: true, completion: nil)
       
        
        println("zurück zum ersten ViewController")
    }
}