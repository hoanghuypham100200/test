//
//  ConversationModel.swift
//  ChatApp_Project
//
//  Created by Huy on 6/1/25.
//
struct ConversationModel: Codable {
    let messageList: [MessageModel]
    let id : String
}

struct MessageModel: Codable{
    let id: String
    let content: String
    let role: String
}
