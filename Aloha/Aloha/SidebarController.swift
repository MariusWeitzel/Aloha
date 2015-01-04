//
//  SidebarController.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import Foundation
import UIKit



class Sidebar: NSObject {
    
    
    let sidebarContainerView:UIView = UIStoryboard.SidebarViewController()!.view!
    let originView:UIView!
    
    // Filter Daten
    let _dataDifficulty = difficulty()
    let _dataCoastproperties = coastproperties()
    let _dataBeachtype = beachtype()
    let _dataWaveType = wavetype()
    let _dataWaterDepth = waterdepth()
    let _dataWaterTemp = watertemperature()
    let _dataWaterType = watertype()
    
    var barWidth:CGFloat!
    var centerNavigationController: UINavigationController!
    var animator:UIDynamicAnimator!
    var isSidebarOpen:Bool = false
    var switches  = [UISwitch]()
    var names = [String]()
    var filterArray = Array<Array<String>>()
    
    override init() {
        super.init()
    }
    
    init(sourceView:UIView){
        super.init()
        originView = sourceView
        barWidth = originView.frame.size.width * 1/3 // Sidebar ist 1/3 so groß wie der OriginalView
        setupSidebar()
        
        animator = UIDynamicAnimator(referenceView: originView)
        
        // Gesten
        
        let showGestureRecognizer:UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "handleLeftSwipe:")
        showGestureRecognizer.edges = UIRectEdge.Left
        originView.addGestureRecognizer(showGestureRecognizer)
        
        let hideGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleRightSwipe:")
        hideGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        originView.addGestureRecognizer(hideGestureRecognizer)
    }
    
    // Sidebar erzeugen
    func setupSidebar(){
        sidebarContainerView.frame = CGRectMake(-originView.frame.size.width, originView.frame.origin.y, originView.frame.size.width, originView.frame.size.height)
        sidebarContainerView.backgroundColor = UIColor.clearColor()
        sidebarContainerView.clipsToBounds = false
        originView.addSubview(sidebarContainerView) // Sidebar zum Ursprungs View hinzufügen
        createSwitches()
    }
    
    // Erzeugt die Daten für die Switches
    func getFilterData(){
        var filter = [String]()
        
        /*filter[0] = "Schwierigkeit"
        for var i = 0; i < _dataDifficulty.count; i++ {
            filter[i+1] = _dataDifficulty[i]
        }
        filterArray.append(filter)
        filter.removeAll(keepCapacity: false)*/
        
        filter.append("Favorit")
        filter.append("Ja / Nein")
        filterArray.append(filter)
        filter.removeAll(keepCapacity: false)
        
        filter.append("Küsteneigenschaften")
        for var i = 0; i < _dataCoastproperties.count; i++ {
            filter.append(_dataCoastproperties[i])
        }
        filterArray.append(filter)
        filter.removeAll(keepCapacity: false)
        
        filter.append("Strandart")
        for var i = 0; i < _dataBeachtype.count; i++ {
            filter.append(_dataBeachtype[i])
        }
        filterArray.append(filter)
        filter.removeAll(keepCapacity: false)
        
        filter.append("Wellentyp")
        for var i = 0; i < _dataWaveType.count; i++ {
            filter.append(_dataWaveType[i])
        }
        filterArray.append(filter)
        filter.removeAll(keepCapacity: false)
        
        filter.append("Wassertiefe")
        for var i = 0; i < _dataWaterDepth.count; i++ {
            filter.append(_dataWaterDepth[i])
        }
        filterArray.append(filter)
        filter.removeAll(keepCapacity: false)
        
        filter.append("Wassertemperatur")
        for var i = 0; i < _dataWaterTemp.count; i++ {
            filter.append(_dataWaterTemp[i])
        }
        filterArray.append(filter)
        filter.removeAll(keepCapacity: false)
        
        filter.append("Wassertyp")
        for var i = 0; i < _dataWaterType.count; i++ {
            filter.append(_dataWaterType[i])
        }
        filterArray.append(filter)
        filter.removeAll(keepCapacity: false)
    }
    
    // Erzeugt die Switches
    func createSwitches(){
        getFilterData()
        var yPos = CGFloat(100)
        var spacing = CGFloat(40)
        
        for item in filterArray{
            var filterNameLabel = UILabel(frame: CGRectMake(550, yPos, 200, 21))
            filterNameLabel.text = item[0]
            sidebarContainerView.addSubview(filterNameLabel)
            yPos = yPos + spacing
            
            for var i = 1; i < item.count; i++ {
                
                var filterLabel = UILabel(frame: CGRectMake(600, yPos, 200, 21))
                filterLabel.text = item[i]
                names.append(item[i])
                sidebarContainerView.addSubview(filterLabel)
                
                
                var filterSwitch = UISwitch(frame:CGRectMake(700, yPos, 0, 0))
                sidebarContainerView.addSubview(filterSwitch)
                filterSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
                switches.append(filterSwitch)
                yPos = yPos + spacing
            }
        }
    }
    
    // Empfängt die Betätigung eines Switches
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            for var i = 0; i < switches.count; i++ {
                if (switchState == switches[i]){
                    println("Switch \(names[i]) ist an")
                    // ToDo: Filtermethode einbinden
                }
            }
            
        } else {
            for var i = 0; i < switches.count; i++ {
                if (switchState == switches[i]){
                    println("Switch \(names[i]) ist aus")
                    // ToDo: Filtermethode einbinden
                }
            }
        }
    }
    
    // Wischen von Links nach Rechts
    func handleLeftSwipe(recognizer:UIScreenEdgePanGestureRecognizer){
        showSidebar(true)
    }
    
    // Wischen von Rechts nach Links (allerdings im Menü)
    func handleRightSwipe(recognizer:UISwipeGestureRecognizer){
        let location = recognizer.locationInView(recognizer.view) // Position der Wischgeste
        if location.x < barWidth{ // Wischgeste muss sich innerhalb des Menüs befinden
            showSidebar(false)
        }
    }
    
    // Methode, um die Sidebar mit Animation anzuzeigen
    func showSidebar(shouldOpen:Bool){
        animator.removeAllBehaviors()
        isSidebarOpen = shouldOpen
        
        let gravityX:CGFloat = (shouldOpen) ? 0.5 : -0.5
        let magnitude:CGFloat = (shouldOpen) ? 20 : -20
        let boundaryX:CGFloat = (shouldOpen) ? barWidth : -originView.frame.size.width-1
        
        
        let gravityBehavior:UIGravityBehavior = UIGravityBehavior(items: [sidebarContainerView])
        gravityBehavior.gravityDirection = CGVectorMake(gravityX, 0)
        animator.addBehavior(gravityBehavior)
        
        let collisionBehavior:UICollisionBehavior = UICollisionBehavior(items: [sidebarContainerView])
        collisionBehavior.addBoundaryWithIdentifier("sideBarBoundary", fromPoint: CGPointMake(boundaryX, 20), toPoint: CGPointMake(boundaryX, originView.frame.size.height))
        animator.addBehavior(collisionBehavior)
        
        let pushBehavior:UIPushBehavior = UIPushBehavior(items: [sidebarContainerView], mode: UIPushBehaviorMode.Instantaneous)
        pushBehavior.magnitude = magnitude
        animator.addBehavior(pushBehavior)
        
        
        let sideBarBehavior:UIDynamicItemBehavior = UIDynamicItemBehavior(items: [sidebarContainerView])
        sideBarBehavior.elasticity = 0.3
        animator.addBehavior(sideBarBehavior)
        
    }
    
}

// Erweiterung von UIStoryboard
private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    // Methode, um den SidebarViewController aus dem Storyboard zu holen
    class func SidebarViewController() -> UIViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("SidebarViewController") as? UIViewController
    }
    
}