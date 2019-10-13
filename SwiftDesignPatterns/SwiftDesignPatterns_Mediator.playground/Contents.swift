// 中介者模式
// 来自网络：类之间的交互行为被统一放在Mediator的对象中，对象通过Mediator对象同其他对象交互，Mediator对象起着控制器的作用
// 设计模式分类：行为型模式

/// 对象抽象
class Colleague {
    let name: String
    let mediator: Mediator
    
    init(name: String, mediator: Mediator) {
        self.name = name
        self.mediator = mediator
    }
    
    /**
     发送消息
     
     - parameter message: 消息
     */
    func send(message: String) {
        print("Colleague \(name) send: \(message)")
        mediator.send(message, colleague: self)
    }
    
    /**
     接收消息
     
     - parameter message: 消息
     */
    func receive(message: String) {
        assert(false, "Method should be overriden")
    }
}

/**
 *  中介者接口
 */
protocol Mediator {
    /**
     发送消息
     
     - parameter message:   消息
     - parameter colleague: 发送者
     */
    func send(message: String, colleague: Colleague)
}

/// 具体中介者
class MessageMediator: Mediator {
    private var colleagues: [Colleague] = []
    
    func addColleague(colleague: Colleague) {
        colleagues.append(colleague)
    }
    
    func send(message: String, colleague: Colleague) {
        for c in colleagues {
            if c !== colleague { //for simplicity we compare object references
                c.receive(message)
            }
        }
    }
}

/// 具体对象
class ConcreteColleague: Colleague {
    override func receive(message: String) {
        print("Colleague \(name) received: \(message)")
    }
}

let messagesMediator = MessageMediator()
let user0 = ConcreteColleague(name: "张三", mediator: messagesMediator)
let user1 = ConcreteColleague(name: "李四", mediator: messagesMediator)
let user2 = ConcreteColleague(name: "王五", mediator: messagesMediator)
messagesMediator.addColleague(user0)
messagesMediator.addColleague(user1)
messagesMediator.addColleague(user2)

user0.send("Hello") // user1 receives message
