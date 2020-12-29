//
//  TreeNode.swift
//  Test_ResponseEvent
//
//  Created by X.Young on 2020/12/29.
//  Copyright © 2020 Young Robine. All rights reserved.
//

import UIKit

class TreeNode: NSObject {
    var left: TreeNode?
    var right: TreeNode?
    
    let title: String!
    
    init(title: String) {
        self.title = title
        
        super.init()
    }
    

}

extension TreeNode {
    /// 遍历(递归)
    static func traverse(head: TreeNode?) {
        /*
         前序遍历：根结点 ---> 左子树 ---> 右子树
         中序遍历：左子树---> 根结点 ---> 右子树
         后序遍历：左子树 ---> 右子树 ---> 根结点
         */
        
        if let node = head {
            print(node.title)
            
        }
        
        Self.traverse(head: head?.left)
        Self.traverse(head: head?.right)
        
    }
    
    /// 前序遍历(非递归)
    static func traverseWithoutRecursion0(head: TreeNode?) -> [String] {
        var currentTreeNode = head
        var treeNodes: [TreeNode] = []
        
        var result: [String] = []
        
        while treeNodes.count != 0 || currentTreeNode != nil {
            if let node = currentTreeNode {
                treeNodes.append(node)
                result.append(node.title)
                
                currentTreeNode = node.left
                
            }else {
                currentTreeNode = treeNodes.removeLast().right
                
            }
            
            
        }
        
        return result
        
    }
    
    /// 中序遍历(非递归)
    static func traverseWithoutRecursion1(head: TreeNode?) -> [String] {
        var currentTreeNode = head
        var treeNodes: [TreeNode] = []
        
        var result: [String] = []
        
        while treeNodes.count != 0 || currentTreeNode != nil {
            if let node = currentTreeNode {
                treeNodes.append(node)
                
                currentTreeNode = node.left
                
            }else {
                let node = treeNodes.removeLast()
                result.append(node.title)
                
                currentTreeNode = node.right
                
            }
            
            
        }
        
        return result
        
    }
    
    /// 后序遍历(非递归)
    static func traverseWithoutRecursion2(head: TreeNode?) -> [String] {
        var currentTreeNode = head
        var treeNodes: [TreeNode] = []
        
        var result: [String] = []
        
        // * 先根右左
        while treeNodes.count != 0 || currentTreeNode != nil {
            if let node = currentTreeNode {
                treeNodes.append(node)
                result.append(node.title)
                
                currentTreeNode = node.right
                
            }else {
                currentTreeNode = treeNodes.removeLast().left
                
            }
            
            
        }
        
        return result.reversed()
        
    }
    
}
