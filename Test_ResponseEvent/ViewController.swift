//
//  ViewController.swift
//  Test_ResponseEvent
//
//  Created by Young Robine on 2020/4/26.
//  Copyright © 2020 Young Robine. All rights reserved.
//

import UIKit
import CoreFoundation

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    
    var currentActivity: CFRunLoopActivity?
    let semaphore = DispatchSemaphore.init(value: 0)
    var runLoopObserver: CFRunLoopObserver?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.addTarget(self, action: #selector(self.clickEvent1), for: .touchUpOutside)
        
        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.clickEvent2))
        button.addGestureRecognizer(tapRecognizer)
        
        
        self.decideRunningSlow()
    }
    
    deinit {
        self.removeRunLoopObserver()
    }
    
    @objc func clickEvent1() -> Void {
        print("clickEvent1")
        
    }

    @objc func clickEvent2() -> Void {
        print("clickEvent2")
        
    }

}

extension ViewController {
    
    /// Runloop检测卡顿
    func decideRunningSlow() -> Void {

        let ownInfo = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
        
        var runLoopObserverContext = CFRunLoopObserverContext.init(version: 0, info: ownInfo, retain: nil, release: nil, copyDescription: nil)
                
        runLoopObserver = CFRunLoopObserverCreate(
            kCFAllocatorDefault,
            CFRunLoopActivity.allActivities.rawValue,
            true,
            0,
            { (observer, activity, info) in
                
                if observer == nil || info == nil {
                    return
                    
                }
                
                let selfValue = Unmanaged<ViewController>.fromOpaque(info!).takeUnretainedValue()
                selfValue.currentActivity = activity
                selfValue.semaphore.signal()
                
            },
            &runLoopObserverContext)
        
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), runLoopObserver, CFRunLoopMode.commonModes)
        
        DispatchQueue.global().async {
            
            while (true) {
                
                if self.currentActivity != nil {
                    
                    let semaphoreWait = self.semaphore.wait(timeout: DispatchTime.now() + 0.033334)
                    
                    if semaphoreWait == .timedOut {
                        
                        switch self.currentActivity! {
                        case .afterWaiting, .beforeSources: // * 发生了卡顿
                            print("发生了卡顿")
                            break
                            
                        default:
                            print("正常")
                            break
                            
                        }
                        
                    }
                    
                }
            }
        }
        

    }
    
    
    func removeRunLoopObserver() {
        if runLoopObserver == nil {
            return
            
        }
        
        CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), runLoopObserver, CFRunLoopMode.commonModes)

    }

    
}

