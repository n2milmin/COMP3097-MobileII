import Foundation

class User {
    var id: Int
    var name: String
    var profilePic: String?
    var heightFt: Int
    var heightIn: Int
    var weight: Int64
    var activityLvl: String
    var activityLvlPosition: Int
    var yearJoined: Int

    init(id: Int,
         name: String,
         heightFt: Int,
         heightIn: Int,
         weight: Int64,
         activityLvl: String,
         activityLvlPosition: Int,
         yearJoined: Int,
         profilePic: String? = nil) {
        self.id = id
        self.name = name
        self.heightFt = heightFt
        self.heightIn = heightIn
        self.weight = weight
        self.activityLvl = activityLvl
        self.activityLvlPosition = activityLvlPosition
        self.yearJoined = yearJoined
        self.profilePic = profilePic
    }

    var weightAsString: String {
        return String(weight)
    }
}
