//
//  SequentialRequestProcessor.swift
//  StartupProjectSampleA
//
//  Created by Towhid on 12/31/15.
//  Copyright © 2015 Towhid (m.towhid.islam@gmail.com). All rights reserved.
//

import Foundation
import UIKit
 

public protocol TransactionProcessingProtocol: NSObjectProtocol{
    var parserType: Response.Type {get set}
    var request: HttpWebRequest {get set}
    var linkedProcess: TransactionProcessingProtocol? {get set}
    var workingMemory: [String: AnyObject] {get}
    var workingMemoryHandler: ((_ previous: [String: AnyObject]) -> [String: AnyObject]) {get set}
    func addObjectToMemory(_ value: AnyObject, key: String) -> Void
    func copyObject(fromMemory memory: [String: AnyObject], key: String) -> Void
    func copyAll(_ from: [String: AnyObject]) -> Void
    func execute(_ success: @escaping ((_ next: TransactionProcessingProtocol?, _ previousResponse: [KGObjectProtocol]?) -> Void), failed: @escaping ((_ abort: Bool, _ reason: Response) -> Void)) -> Void
}

public protocol TransactionProcessorDelegate: NSObjectProtocol{
    func processingDidFinished(_ processor: TransactionProcessor, finalResponse: [KGObjectProtocol]?) -> Void
    func processingDidFailed(_ processor: TransactionProcessor, failedResponse: KGObjectProtocol) -> Void
    func processingWillStart(_ processor: TransactionProcessor, forProcess process: TransactionProcessingProtocol) -> Void
    func processingDidEnd(_ processor: TransactionProcessor, forProcess process: TransactionProcessingProtocol) -> Void
}

open class TransactionProcessor: NSObject{
    
    fileprivate var stack: [TransactionProcessingProtocol] = [TransactionProcessingProtocol]()
    fileprivate var abortMark: Bool = false
    fileprivate weak var delegate: TransactionProcessorDelegate?
    fileprivate var errorResponseType: KGObject.Type!
    
    public required init(delegate: TransactionProcessorDelegate?, errorResponse: KGObject.Type = KGObject.self){
        super.init()
        self.delegate = delegate
        self.errorResponseType = errorResponse
    }
    
    public final func push(process: TransactionProcessingProtocol){
        if let last = stack.last{
            process.linkedProcess = last
        }
        stack.append(process)
    }
    
    public final func start(){
        if let last = stack.last{
            self.delegate?.processingWillStart(self, forProcess: last)
            last.execute({ (next, previousResponse) -> Void in
                if (self.abortMark){
                    let errorResponse = self.errorResponseType.init()
                    errorResponse.update(withInfo: ["errorMessage":"Unknown"])
                    self.delegate?.processingDidFailed(self, failedResponse: errorResponse)
                    return
                }
                else if (next == nil){
                    self.delegate?.processingDidFinished(self, finalResponse: previousResponse)
                    return
                }
                else{
                    let doneProcess = self.stack.removeLast()
                    self.delegate?.processingDidEnd(self, forProcess: doneProcess)
                    self.start()
                }
                }, failed: { (abort, reason) -> Void in
                    print(reason.serializeIntoInfo())
                    if abort{
                        self.delegate?.processingDidFailed(self, failedResponse: reason)
                        return
                    }
                    if self.abortMark == false{
                        self.stack.removeLast()
                        self.start()
                    }
            })
        }
    }
    
    public final func abort() {
        abortMark = true
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
