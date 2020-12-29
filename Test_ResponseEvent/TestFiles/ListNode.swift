//
//  ListNode.swift
//  Test_ResponseEvent
//
//  Created by XC_Young on 2020/12/29.
//  Copyright © 2020 Young Robine. All rights reserved.
//

import UIKit

/// 反转双向链表
class ListNode: NSObject {
    var next: ListNode?
    var prev: ListNode?
    
    let title: String!
    
    init(title: String) {
        self.title = title
        
        super.init()
    }
    
    static func reverseList(head: ListNode?) -> ListNode? {
        var currentNode = head
        
        var prevNode: ListNode?
        
        while currentNode != nil {
            let nextNode = currentNode!.next

            currentNode!.prev = nextNode
            currentNode!.next = prevNode
            
            prevNode = currentNode!
            currentNode = nextNode
        }
        
        
        
        return prevNode
        
    }
    
    
    static func testRun() {
        var array: [ListNode] = []
        
        for index in 0 ..< 5 {
            let node = ListNode.init(title: "\(index)")
            array.append(node)
            
        }
        
        for index in 0 ..< array.count {
            let node = array[index]
            
            if index + 1 < array.count {
                node.next = array[index + 1]
                node.next?.prev = node
                
            }
            
        }
        
        
        let newHead = Self.reverseList(head: array[0])
        
        print(newHead)
        
    }
    
    
}

