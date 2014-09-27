import Foundation
import UIKit

let RowHeight: Int = 50
let ColumnWidth: Int = 50
public var SkoobrDatesFormatter = NSDateFormatter()
let OneDayTimestamp = 24 * 60 * 60

let DayWeekend = (color: UIColor.blackColor(), backgroundColor: UIColor(hue: 0.0, saturation: 0.0, brightness: 0.945, alpha: 1))
let DayWeek = (color: UIColor(hue: 0.0, saturation: 0.0, brightness: 0.808, alpha: 1), backgroundColor: UIColor.whiteColor())
// FIXME: Could not declare a named tuple like above (else compile error in CalendarBookingCell.swift)
let BookingColor = UIColor(hue: 0.400, saturation: 0.527, brightness: 0.655, alpha: 1)
let ChannelBadgeBackgroundColor = UIColor(hue: 0.499, saturation: 0.729, brightness: 0.753, alpha: 1)
let DarkGreenEdge = UIColor(hue: 0.402, saturation: 0.533, brightness: 0.588, alpha: 1)