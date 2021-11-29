import Foundation

class Todo
{
    private var m_id: Int64
    private var m_name: String
    private var m_notes: String
    private var m_hasDueDate: Bool
    private var m_dueDate: Date
    private var m_state: String
    private var m_isCompleted: Bool
    
    // public properties
    
    public var id: Int64
    {
        get
        {
            return m_id
        }
        
        set(newId)
        {
            m_id = newId
        }
    }
    
    public var isCompleted: Bool
    {
        get
        {
            return m_isCompleted
        }
        
        set(newIsCompleted)
        {
            m_isCompleted = newIsCompleted
        }
    }
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
    init(id: Int64, name: String, isCompleted: Bool, notes:String = "", hasDueDate:Bool = false, dueDate:Date = Date(), state:String = "")
    {
        m_name = name
        m_notes = notes
        m_hasDueDate = hasDueDate
        m_dueDate = dueDate
        // generate random id based on date hashValue
        m_id = id
        m_state = state
        m_isCompleted = isCompleted
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
