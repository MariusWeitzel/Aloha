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
    
    let barWidth:CGFloat = 150.0
    let sidebarContainerView:UIView = UIStoryboard.SidebarViewController()!.view!
    let originView:UIView!
    
    var animator:UIDynamicAnimator!
    var delegate:SidebarDelegate?
    var isSidebarOpen:Bool = false
    
    override init() {
        super.init()
    }
    
    init(sourceView:UIView){
        super.init()
        originView = sourceView
        
        setupSidebar()
        
        animator = UIDynamicAnimator(referenceView: originView)
        
        let showGestureRecognizer:UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "handleLeftSwipe:")
        showGestureRecognizer.edges = UIRectEdge.Left
        originView.addGestureRecognizer(showGestureRecognizer)
        
        let hideGestureRecognizer:UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "handleRightSwipe:")
        hideGestureRecognizer.edges = UIRectEdge.Right
        originView.addGestureRecognizer(hideGestureRecognizer)
        
        
        
    }
    
    
    func setupSidebar(){
        
        sidebarContainerView.frame = CGRectMake(-originView.frame.size.width, originView.frame.origin.y, originView.frame.size.width, originView.frame.size.height)
        
        sidebarContainerView.backgroundColor = UIColor.clearColor()
        sidebarContainerView.clipsToBounds = false
        
        originView.addSubview(sidebarContainerView)
        
    }
    
    
    func handleLeftSwipe(recognizer:UIScreenEdgePanGestureRecognizer){
        showSidebar(true)
        delegate?.sidebarWillOpen?()
        
    }
    
    func handleRightSwipe(recognizer:UIScreenEdgePanGestureRecognizer){
        showSidebar(false)
        delegate?.sidebarWillClose?()
    }
    
    
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

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func SidebarViewController() -> UIViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("SidebarViewController") as? UIViewController
    }
    
}