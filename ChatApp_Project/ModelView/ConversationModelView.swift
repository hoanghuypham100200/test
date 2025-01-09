//
//  ConversationViewModel.swift
//  MVVM
//
//  Created by Huy on 3/1/25.
//
import RxSwift
import RxCocoa
class ConversationViewModel {
    var messages: BehaviorRelay<[MessageModel]> = BehaviorRelay(value: [])
    var conversation: BehaviorRelay<[ConversationModel]> = BehaviorRelay(value: [])
    var dataConversation: [ConversationModel]  = retrieveConversation(forKey: "conversation") ?? []
    
    func fetchConversation() {
         dataConversation  = retrieveConversation(forKey: "conversation") ?? []

        conversation.accept(dataConversation)

    }
    func fetchMessages(conversationID: String) {
        var data:[ConversationModel]?
        data = retrieveConversation(forKey: "conversation")
        if let conversation = data!.first(where: { $0.id == conversationID }) {
            messages.accept(conversation.messageList)
        } else {
            print("Conversation not found")
        }
        
    }
    
    func createConversation(newConversationId: String) {
        let newConversation = ConversationModel(messageList: [], id: newConversationId)
        dataConversation = retrieveConversation(forKey: "conversation") ?? []
        
        
//        dataConversation.append(newConversation)
        dataConversation.insert(newConversation, at: 0)
        saveConersation(dataConversation, forKey: "conversation")
        conversation.accept(dataConversation)
    }
    
    func sendMessage(content: String, role: String, conversationID: String) {
          let newMessage = MessageModel(id: UUID().uuidString, content: content, role: role)
        var currentMessages: [MessageModel] = messages.value
        currentMessages.append(newMessage)
        
        //append Messages in []
       if let index = dataConversation.firstIndex(where: { $0.id == conversationID }){
           var dataMessage:[MessageModel] = dataConversation[index].messageList
           
           dataMessage.append(newMessage)
           var newConversation = ConversationModel(messageList: dataMessage, id: conversationID)
           dataConversation[index]  = newConversation
           saveConersation(dataConversation, forKey: "conversation")
           messages.accept(dataMessage)

        }
    
      }
    
    func clearMessage( conversationID: String) {
        
        //append Messages in []
       if let index = dataConversation.firstIndex(where: { $0.id == conversationID }){
           var dataMessage:[MessageModel] = dataConversation[index].messageList
           
           dataMessage = []
           var newConversation = ConversationModel(messageList: dataMessage, id: conversationID)
           dataConversation[index]  = newConversation
           saveConersation(dataConversation, forKey: "conversation")
           messages.accept(dataMessage)

        }
    
      }
    
    func removeConversation(conversationId: String) {
        
        if let index = dataConversation.firstIndex(where: { $0.id == conversationId }){
            dataConversation.remove(at: index)
         }
        saveConersation(dataConversation, forKey: "conversation")
        conversation.accept(dataConversation)
    }
    
}


func retrieveConversation(forKey key: String) -> [ConversationModel]? {
    do {
        if let data = UserDefaults.standard.data(forKey: key) {
            let decoder = JSONDecoder()
            let retrievedMessages = try decoder.decode([ConversationModel].self, from: data)
            return retrievedMessages
        } else {
            print("No messages found in UserDefaults for key: \(key)")
            return nil
        }
    } catch {
        print("Failed to decode messages: \(error)")
        return nil
    }
}

func saveConersation(_ conversation: [ConversationModel], forKey key: String) {
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(conversation)
        UserDefaults.standard.set(data, forKey: key)
    } catch {
        print("Failed to encode messages: \(error)")
    }
}

