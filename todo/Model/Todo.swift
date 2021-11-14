import Foundation

class Todo
{
    private var m_id: String
    private var m_name: String
    private var m_notes: String
    private var m_hasDueDate: Bool
    private var m_dueDate: Date
    private var m_state: String
    
    // public properties
    public var name: String
    {
        get
        {
            return m_name
        }
        
        set(newName)
        {
            m_name = newName
        }
    }
    
    public var state: String
    {
        get
        {
            return m_state
        }
        
        set(newState)
        {
            m_state = newState
        }
    }
    
    public var notes: String
    {
        get
        {
            return m_notes
        }
        
        set(newNotes)
        {
            m_notes = newNotes
        }
    }
    
    public var hasDueDate: Bool
    {
        get
        {
            return m_hasDueDate
        }
    }
    
    public var dueDate: Date
    {
        get
        {
            return m_dueDate
        }
        
        set(newDueDate)
        {
            m_dueDate = newDueDate
            m_hasDueDate = true
        }
    }
    
    
    
    // initializer (constructor)
    init(name: String, notes:String = "", hasDueDate:Bool = false, dueDate:Date = Date(), state:String = "")
    {
        m_name = name
        m_notes = notes
        m_hasDueDate = hasDueDate
        m_dueDate = dueDate
        // generate random id based on date hashValue
        m_id = "\(abs(m_dueDate.hashValue))"
        m_state = state
    }
    
    // Utility methods
    
    public func removeDueDate()-> Void
    {
        m_hasDueDate = false
        m_dueDate = Date()
    }
    
    public func display()-> Void
    {
        print("id        : \(m_id)")
        print("name      : \(name)")
        print("notes     : \(notes)")
        print("hasDueDate: \(hasDueDate)")
        if(hasDueDate)
        {
            print("date      : \(dueDate)")
        }
    }
}
