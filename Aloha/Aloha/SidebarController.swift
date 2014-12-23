//
//  SidebarController.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import Foundation
import UIKit

@objc protocol SidebarDelegate{
    optional func sidebarWillClose()
    optional func sidebarWillOpen()
}

class Sidebar: NSObject {
    
    
    let sidebarContainerView:UIView = UIStoryboard.SidebarViewController()!.view!
    let originView:UIView!
    
    var barWidth:CGFloat!
    var centerNavigationController: UINavigationController!
    var animator:UIDynamicAnimator!
    var delegate:SidebarDelegate?
    var isSidebarOpen:Bool = false
    
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
        
    }
    
    // Wischen von Links nach Rechts
    func handleLeftSwipe(recognizer:UIScreenEdgePanGestureRecognizer){
        showSidebar(true)
        delegate?.sidebarWillOpen?()
    }
    
    // Wischen von Rechts nach Links (allerdings im Menü)
    func handleRightSwipe(recognizer:UISwipeGestureRecognizer){
        let location = recognizer.locationInView(recognizer.view) // Position der Wischgeste
        if location.x < barWidth{ // Wischgeste muss sich innerhalb des Menüs befinden
            showSidebar(false)
            delegate?.sidebarWillClose?()
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