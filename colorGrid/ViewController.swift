//
//  ViewController.swift
//  colorGrid
//
//  Created by Omry Dabush on 13/04/2017.
//  Copyright © 2017 Omry Dabush. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cellSize = 20
    var currentCell : UIView?
    var cells = [String : UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = Int(view.frame.width / CGFloat(cellSize))
        let screenHeight = Int(view.frame.height / CGFloat(cellSize))
        for i in 0...screenWidth {
            for j in 0...screenHeight {
                let colorCell = UIView()
                colorCell.backgroundColor = generateRandomColor()
                colorCell.layer.borderWidth = 0.3
                colorCell.layer.borderColor = UIColor.black.cgColor
                
                let key = "\(i)|\(j)"
                cells[key] = colorCell
                
                view.addSubview(colorCell)
                colorCell.translatesAutoresizingMaskIntoConstraints = false
                
                colorCell.frame = CGRect(x: i * cellSize, y: j * cellSize, width: cellSize, height: cellSize)
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override var shouldAutorotate: Bool {
        return false
    }
    
    @objc func handlePan(gesture : UIPanGestureRecognizer){
        let location = gesture.location(in: view)
        
        let i = Int(location.x) / cellSize
        let j = Int(location.y) / cellSize
        
        let key = "\(i)|\(j)"
        
        guard let cellView = cells[key] else {return}
        
        if currentCell != cellView || gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.currentCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        
        view.bringSubview(toFront: cellView)
        currentCell = cellView
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        }, completion: nil)
        
        if (gesture.state == .ended) {
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.currentCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }
    
    fileprivate func generateRandomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
