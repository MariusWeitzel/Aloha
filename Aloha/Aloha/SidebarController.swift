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
    let _dataWaveType = wavetype()
    let _dataWaterDepth = waterdepth()
    let _dataWaterTemp = watertemperature()
    let _dataWaterType = watertype()
    let location = Location()
    
    var barWidth:CGFloat!
    var centerNavigationController: UINavigationController!
    var animator:UIDynamicAnimator!
    var isSidebarOpen:Bool = false
    var switches  = [UISwitch]()
    var names = [String]()
    
    override init() {
        super.init()
    }
    
    init(sourceView:UIView){
        super.init()
        originView = sourceView
        barWidth = originView.frame.size.width*1/3
        
        
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
    
    func createSwitches(){
        var yPos = CGFloat(100)
        var spacing = CGFloat(40)
        
        
        var filterNameLabel1 = UILabel(frame: CGRectMake(550, yPos, 200, 21))
        filterNameLabel1.text = "Wellentyp"
        sidebarContainerView.addSubview(filterNameLabel1)
        yPos = yPos + spacing
        
        for var i = 0; i < _dataWaveType.count; i++ {
            
            var filterLabel = UILabel(frame: CGRectMake(600, yPos, 200, 21))
            filterLabel.text = _dataWaveType[i]
            sidebarContainerView.addSubview(filterLabel)
            
            
            var filterSwitch = UISwitch(frame:CGRectMake(700, yPos, 0, 0))
            sidebarContainerView.addSubview(filterSwitch)
            filterSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
            switches.append(filterSwitch)
            names.append(_dataWaveType[i])
            yPos = yPos + spacing
        }
        
        var filterNameLabel2 = UILabel(frame: CGRectMake(550, yPos, 200, 21))
        filterNameLabel2.text = "Wassertiefe"
        sidebarContainerView.addSubview(filterNameLabel2)
        yPos = yPos + spacing
        
        for var i = 0; i < _dataWaterDepth.count; i++ {
            
            var filterLabel = UILabel(frame: CGRectMake(600, yPos, 200, 21))
            filterLabel.text = _dataWaterDepth[i]
            sidebarContainerView.addSubview(filterLabel)
            
            
            var filterSwitch = UISwitch(frame:CGRectMake(700, yPos, 0, 0))
            sidebarContainerView.addSubview(filterSwitch)
            filterSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
            switches.append(filterSwitch)
            names.append(_dataWaterDepth[i])
            yPos = yPos + spacing
        }
        
        var filterNameLabel3 = UILabel(frame: CGRectMake(550, yPos, 200, 21))
        filterNameLabel3.text = "Wassertemperatur"
        sidebarContainerView.addSubview(filterNameLabel3)
        yPos = yPos + spacing
        
        for var i = 0; i < _dataWaterTemp.count; i++ {
            
            var filterLabel = UILabel(frame: CGRectMake(600, yPos, 200, 21))
            filterLabel.text = _dataWaterTemp[i]
            sidebarContainerView.addSubview(filterLabel)
            
            
            var filterSwitch = UISwitch(frame:CGRectMake(700, yPos, 0, 0))
            sidebarContainerView.addSubview(filterSwitch)
            filterSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
            switches.append(filterSwitch)
            names.append(_dataWaterTemp[i])
            yPos = yPos + spacing
        }
        
        var filterNameLabel4 = UILabel(frame: CGRectMake(550, yPos, 200, 21))
        filterNameLabel4.text = "Wassertyp"
        sidebarContainerView.addSubview(filterNameLabel4)
        yPos = yPos + spacing
        
        for var i = 0; i < _dataWaterType.count; i++ {
            
            var filterLabel = UILabel(frame: CGRectMake(600, yPos, 200, 21))
            filterLabel.text = _dataWaterType[i]
            sidebarContainerView.addSubview(filterLabel)
            
            
            var filterSwitch = UISwitch(frame:CGRectMake(700, yPos, 0, 0))
            sidebarContainerView.addSubview(filterSwitch)
            filterSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
            switches.append(filterSwitch)
            names.append(_dataWaterType[i])
            yPos = yPos + spacing
        }
    }
    
    
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