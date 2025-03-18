import SQLite3

class DatabaseHelper {
    
    private let database: OpaquePointer?
    
    // Constants for table and columns
    private let tableUsers = "users"
    private let columnId = "id"
    private let columnName = "name"
    private let columnProfilePic = "profile_pic"
    private let columnHeightFt = "height_ft"
    private let columnHeightIn = "height_in"
    private let columnWeight = "weight"
    private let columnActivityLvl = "activity_lvl"
    private let columnActivityLvlPosition = "activity_lvl_position"
    private let columnYearJoined = "year_joined"
    
    private let tableDietPref = "diet_pref"
    private let columnDietPrefId = "id"
    private let columnDietPrefUserId = "user_id"
    private let columnDietPrefPreference = "preference"
    
    private let tableAllergies = "allergies"
    private let columnAllergiesId = "id"
    private let columnAllergiesUserId = "user_id"
    private let columnAllergiesAllergy = "allergy"
    
    // Initialize SQLite
    init() {
        // Open database or create it if doesn't exist
        var db: OpaquePointer?
        if sqlite3_open("user_database.sqlite", &db) == SQLITE_OK {
            self.database = db
        } else {
            self.database = nil
            print("Error opening database.")
        }
    }

    // MARK: - User CRUD Operations

    // Create users table
    func createUsersTable() {
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS \(tableUsers) (
            \(columnId) INTEGER PRIMARY KEY AUTOINCREMENT,
            \(columnName) TEXT,
            \(columnProfilePic) TEXT,
            \(columnHeightFt) INTEGER,
            \(columnHeightIn) INTEGER,
            \(columnWeight) INTEGER,
            \(columnActivityLvl) TEXT,
            \(columnActivityLvlPosition) INTEGER,
            \(columnYearJoined) INTEGER
        );
        """
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(database, createTableQuery, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Table created successfully")
            } else {
                print("Table creation failed")
            }
        } else {
            print("Create table query failed.")
        }
    }

    // Insert a user
    func insertUser(user: User) {
        let insertQuery = "INSERT INTO \(tableUsers) (\(columnName), \(columnProfilePic), \(columnHeightFt), \(columnHeightIn), \(columnWeight), \(columnActivityLvl), \(columnActivityLvlPosition), \(columnYearJoined)) VALUES (?, ?, ?, ?, ?, ?, ?, ?);"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, user.name, -1, nil)
            sqlite3_bind_text(statement, 2, user.profilePic ?? "", -1, nil)
            sqlite3_bind_int(statement, 3, Int32(user.heightFt))
            sqlite3_bind_int(statement, 4, Int32(user.heightIn))
            sqlite3_bind_int64(statement, 5, user.weight)
            sqlite3_bind_text(statement, 6, user.activityLvl, -1, nil)
            sqlite3_bind_int(statement, 7, Int32(user.activityLvlPosition))
            sqlite3_bind_int(statement, 8, Int32(user.yearJoined))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("User inserted successfully.")
            } else {
                print("User insertion failed.")
            }
        }
    }

    // Fetch a user by ID
    func getUserById(userId: Int) -> User? {
        let query = "SELECT * FROM \(tableUsers) WHERE \(columnId) = ?;"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(userId))
            
            if sqlite3_step(statement) == SQLITE_ROW {
                let id = sqlite3_column_int(statement, 0)
                let name = String(cString: sqlite3_column_text(statement, 1))
                let profilePic = String(cString: sqlite3_column_text(statement, 2))
                let heightFt = sqlite3_column_int(statement, 3)
                let heightIn = sqlite3_column_int(statement, 4)
                let weight = sqlite3_column_int64(statement, 5)
                let activityLvl = String(cString: sqlite3_column_text(statement, 6))
                let activityLvlPosition = sqlite3_column_int(statement, 7)
                let yearJoined = sqlite3_column_int(statement, 8)
                
                let user = User(id: Int(id),
                                name: name,
                                heightFt: Int(heightFt),
                                heightIn: Int(heightIn),
                                weight: weight,
                                activityLvl: activityLvl,
                                activityLvlPosition: Int(activityLvlPosition),
                                yearJoined: Int(yearJoined),
                                profilePic: profilePic)
                return user
            }
        }
        return nil
    }

    // MARK: - Diet Preference CRUD Operations
    // Insert a diet preference for a user
    func insertDietPreference(userId: Int, preference: String) {
        let insertQuery = "INSERT INTO \(tableDietPref) (\(columnDietPrefUserId), \(columnDietPrefPreference)) VALUES (?, ?);"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(userId))
            sqlite3_bind_text(statement, 2, preference, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Diet preference added.")
            }
        }
    }

    // MARK: - Allergy CRUD Operations
    // Insert an allergy for a user
    func insertAllergy(userId: Int, allergy: String) {
        let insertQuery = "INSERT INTO \(tableAllergies) (\(columnAllergiesUserId), \(columnAllergiesAllergy)) VALUES (?, ?);"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(userId))
            sqlite3_bind_text(statement, 2, allergy, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Allergy added.")
            }
        }
    }

    // Fetch allergies by user ID
    func getAllergiesByUserId(userId: Int) -> [String]? {
        let query = "SELECT * FROM \(tableAllergies) WHERE \(columnAllergiesUserId) = ?;"
        var statement: OpaquePointer?
        var allergies: [String] = []
        
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(userId))
            
            while sqlite3_step(statement) == SQLITE_ROW {
                let allergy = String(cString: sqlite3_column_text(statement, 2))
                allergies.append(allergy)
            }
        }
        return allergies.isEmpty ? nil : allergies
    }
}
