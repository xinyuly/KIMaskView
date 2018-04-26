//
//  KIMaskView.swift
//  KIMaskViewDemo
//
//  Created by xinyu on 2018/4/23.
//  Copyright © 2018年 MaChat. All rights reserved.
//

import UIKit

// contentView在遮罩视图的相对位置
enum KIModalViewDockToSide {
    case Default
    case top
    case bottom
    case left
    case right
    case center
}
class KIMaskView: UIView {
    open var contentView: UIView?
    open var maskColor: UIColor? {
        didSet{
            maskedView?.backgroundColor = maskColor
        }
    }
    open var dismissWhenTouchMaskView: Bool = true
    open var dockToSide: KIModalViewDockToSide = .Default
    
    fileprivate var maskedView: UIView?
    fileprivate var isShow: Bool = false
    
    deinit {
        contentView = nil
        maskedView = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupModalView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        maskedView?.frame = bounds
    }
    //MARK: - Events
    public func showInView(view:UIView) {
        if isShow {
            return
        }
        isShow = true
        
        guard let contentView = contentView else { return }
        addSubview(contentView)
        
        if view.isKind(of: object_getClass(UIScrollView())!) {
            let scrollView = view as! UIScrollView
            scrollView.isScrollEnabled = false
            //XXXXX
        }
        var frame = contentView.frame
        let superViewBounds = view.bounds
        self.frame = superViewBounds
        view.addSubview(self)
        view.bringSubview(toFront: self)
        contentView.alpha = 0.0
        switch dockToSide {
        case .Default,.center:
            frame.origin.x = superViewBounds.width*0.5 - frame.width*0.5
            frame.origin.y = superViewBounds.height*0.5 - frame.height*0.5
            break
        case .top:
            frame.origin.y = 0
            break
        case .bottom:
            frame.origin.y = superViewBounds.height - frame.height
            break
        case .left:
            frame.origin.x = 0
            break
        case .right:
            frame.origin.x = superViewBounds.width - frame.width
            break
        }
        self.contentView?.frame = frame
        
        UIView.animate(withDuration: 0.15, delay: 0, options: .beginFromCurrentState, animations: {
            self.maskedView?.alpha = 1.0
            self.contentView?.alpha = 1.0
        }) { (finished) in
            
        }
        
    }
    
    @objc func dismiss() {
        if !isShow {
            return
        }
        isShow = false
        self.endEditing(true)
        let frame = contentView?.frame
        
        UIView.animate(withDuration: 0.15, delay: 0, options: .beginFromCurrentState, animations: {
            self.contentView?.frame = frame!
            self.contentView?.alpha = 0.0
            self.maskedView?.alpha = 0.0
        }) { (finished) in
            self.removeFromSuperview()
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.dismiss), object: nil)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touch = touches.first else {
            return
        }
        if touch.view == maskedView && dismissWhenTouchMaskView {
            dismiss()
        }
        
    }
    
    //MARK: - Private Methods
    fileprivate func setupModalView() {
        backgroundColor = UIColor.clear
        if maskedView == nil {
            maskedView = UIView.init()
            maskedView?.alpha = 0.2
            addSubview(maskedView!)
            maskColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        }
        self.isUserInteractionEnabled = true
    }
    
}

