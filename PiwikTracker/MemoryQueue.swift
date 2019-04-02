import Foundation

/// The MemoryQueue is a **not thread safe** in memory Queue.
public struct MemoryQueue: Queue {
  private var items = [Event]()
  
  public init(){
    
  }
  
  public var eventCount: Int { get {
    return items.count
    }
  }
  
  mutating public func enqueue(events: [Event], completion: (()->())?) {
    items.append(contentsOf: events)
    completion?()
  }
  
  public func first(limit: Int, completion: (_ items: [Event])->()) {
    let amount = [limit,eventCount].min()!
    let dequeuedItems = Array(items[0..<amount])
    completion(dequeuedItems)
  }
  
  mutating public func remove(events: [Event], completion: ()->()) {
    items = items.filter({ event in !events.contains(where: { eventToRemove in eventToRemove.uuid == event.uuid })})
    completion()
  }
}
