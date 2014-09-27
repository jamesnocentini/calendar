import Skoobr

let booking1 = Booking(json: ["id": 1, "check_in": "2014-04-01", "check_out": "2014-04-15", "property_id": 11])
let booking2 = Booking(json: ["id": 2, "check_in": "2014-04-01", "check_out": "2014-04-15", "property_id": 12])
let booking3 = Booking(json: ["id": 3, "check_in": "2014-04-01", "check_out": "2014-04-15", "property_id": 11])
let booking4 = Booking(json: ["id": 4, "check_in": "2014-04-01", "check_out": "2014-04-15", "property_id": 13])

let fakeBookings = [booking1, booking2, booking3, booking4]