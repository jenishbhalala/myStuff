//
//  APIConstant.swift
//  Jenish
//
//  Created by Jenish on 08/09/2018.
//  Copyright © 2018  Jenish. All rights reserved.
//

import Foundation
import UIKit
let TEST_PAYMENTMODE = true

var BASE_URL: String{
    if language() == LangNames.Arab.rawValue{
        return "http://quick.r.ede.io/ar/api/v1/"
    }else{
        return "http://quick.r.ede.io/en/api/v1/"
    }
}
let DEVICE_TOKEN = "DEVICE_TOKEN"
var DEVICE_UUID : String = getUdid()
var DEVICE_ID : String = ""

var countryList = [Country]()
var cityList = [City]()
var order = [TrendingModel]()
var isGuest = false
var isGuestCheckout = false
var checkoutDictData = NSMutableDictionary()

let GET_COUNTRIES = "country"
let CONTACT = "contact/store"
let ABOUT_US = "page/about-us"
let PRIVACY = "page/privacy"
let TERM_CONDITION = "page/term-condition"
let REGISTER = "customer/register"
let LOGIN = "customer/login"
let ACTIVATE = "customer/activate"
let PASSWORD_CODE_CHECK = "customer/password/code/check"
let PASSWORD_CODE_RESEND = "customer/password/activate/resend"
let RESEND = "customer/activate/resend"
let FORGET = "customer/password/forget"
let UPDATE_PASSWORD = "customer/password/update"
let CUSTOMER_PASSWORD_CHANGE = "customer/password/change"
let LOGOUT = "customer/logout"
let CUSTOMER_PROFILE = "customer/profile"
let CUSTOMER_PROFILE_UPDATE = "customer/profile/update"
let GET_ADDRESS = "customer/address/index"
let CREATE_ADDRESS = "customer/address/store"
let ADDRESS_PRE = "customer/address/"
let UPDATE_ADDRESS_SUF = "/update"
let DELETE_ADDRESS_SUF = "/delete"
let CUSTOMER_MENU_TRENDING = "customer/menu/trending?fields[]=id&fields[]=name&fields[]=imageUrl&fields[]=price&include=vendor:fields(id|name|logoUrl|open_time)"
let CUSTOMER_MENU_MOST_POPULAR = "customer/menu/most-popular?fields[]=id&fields[]=name&fields[]=imageUrl"
let MOST_POPULAR_ITEM_VENDORS = "customer/menu/most-popular/"
let CUSTOMER_VENDOR_INDEX = "customer/vendor/index"
let CUSTOMER_VENDOR_VIEW_PRE = "customer/vendor/"
let CUSTOMER_VENDER_VIEW_SUF = "/view"
let CUSTOMER_VENDOR_ITEM_SUF = "/items"
let CUSTOMER_MENU_VIEW_PREF = "customer/menu/"
let CUSTOMER_MENU_VIEW_SUF = "/view"
let ROUTINE = "customer/routine/index?include=vendor:fields(id|name|logoUrl|open_time)"
let DEL_ROUTINE_PREF = "customer/routine/"
let DEL_ROUTINE_SUF = "/delete"
let CREATE_ROUTINE = "customer/routine/store"
let CREATE_CHECKOUT = "customer/order/create-checkout"
let CHECKOUT = "customer/cart/checkout"
let PLACE_ORDER = "customer/order/store"
let ORDER_HISTORY_LIST = "customer/order/index"
let RATE_VENDOR = "/rate"
let CUSTOMER_VENDOR_NEAR = "customer/vendor/near"
let OFFER = "customer/offers/index?include=vendor:fields(id|name|logoUrl|open_time)"
let ADD_TO_CART = "customer/cart/add"
let SHOW_CURRENT_CART = "customer/cart/index"
let REMOVE_CART = "customer/cart/remove"
let CREATE_SHOPPING_CART = "customer/cart/store"
let ORDER_HISTORY_LIST_VENDOR = "customer/order/history?include=vendor:fields(id|name|logoUrl|rating|address)"
let CUSTOMER_ORDER_VIEW = "customer/order"
let CUSTOMER_DESTROY_CART = "customer/cart/destroy"
let CUSTOMER_TRACK_ORDER = "customer/order"
let CUSTOMER_GIFTS = "customer/gifts"
let CUSTOMER_GIFT_SUMMARY = "customer/gift"
let CUSTOMER_CARDS_LIST = "customer/payment/cards"
let CUSTOMER_DESTROY_SAVECARD = "customer/payment/cards"
let ORDER_HISTORY_DELIVERED_LIST = "customer/order/history?status_id=\(STATUS_COMPLETED)&include=vendor:fields(id|name|logoUrl|rating)"
let CUSTOMER_RATE_ORDER = "customer/order"
let CUSTOMER_NOTIFICATION = "customer/notifications"
let CREATE_CHECKOUT_PLANS = "customer/plans/"
let CHECK_CUSTOMER_PLANS = "customer/plans"
let CUSTOMER_PAYMENT_CHECKOUT = "customer/payment/registration/checkout"
let CUSTOMER_PAYMENT_REG_CARD = "customer/payment/registration/status"

let CHECKOUT_ID_FOR_ROUTINE = "customer/routine"
let CHECKOUT_ROUTINE = "customer/routine/"
let CURRENT_PLAN_SUFFIX = "/current?include=plan"
let CUSTOMER_UPDATE_DEVICE_TOKEN = "customer/update-device-token"
let APPLY_OFFER_CODE = "customer/cart/apply-offer"

let CHECK_CUSTOMER_MY_GIFTS = "customer/my-gifts"
let CUSTOMER_ROUTINE = "customer/routine"


let UPDATE_MAIN_ADDRESS = "customer/address/update-main-address"


let appDelegate = UIApplication.shared.delegate as! AppDelegate

let DID_RECEIVED_PUSH_NOTIF = "DID_RECEIVED_PUSH_NOTIF"

func getUdid() -> String{
    if let udid = UserDefaults.standard.object(forKey: DEVICE_TOKEN) as? String{
        return udid
    }
    return ""
}
//MARK: Push notification

enum NOTIFICATION_TYPE : String{
    case order_accept = "order_accept"
    case order_cancelled = "order_cancelled"
    case order_completed = "order_completed"
    case order_not_collected = "order_not_collected"
    case gift_send = "gift"
    case points_free_gift = "free_drink"
}
func getAppMode() -> OPPProviderMode{
    if TEST_PAYMENTMODE == true{
        return OPPProviderMode.test
    }else{
        return OPPProviderMode.live
    }
}
let DID_RECEIVED_SILENT_PUSH = "DID_RECEIVED_SILENT_PUSH"
