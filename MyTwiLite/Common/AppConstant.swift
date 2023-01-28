//
//  AppConstant.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation
import Firebase

// Firebase callback type
typealias FirebaseCallBackType = (AuthDataResult?, Error?) -> Void
typealias CollectionCallBackType =  (QuerySnapshot?, Error?) -> Void
typealias DeleteTimelineCallBackType =  () -> Void
