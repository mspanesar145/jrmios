//
//  HomeAPI.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 21/10/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import Foundation
class HomeAPI {
    
    public static var get_reiki_services = "home/allServicesApi";
    public static var get_timeslots_by_date = "home/allTimeSlotsByDate";//?currentTime=
    public static var get_user_appointments_request = "home/appointmentsByUserId";
    public static var get_service_plans_by_serviceId = "home/findServicePlanByServiceId";

    public static var post_user_notifications_request = "home/notificationsByUserId";
    public static var post_upload_healee_photo = "home/uploadPersonalImage";//?userfile=
    public static var post_stripe_payment_intent = "home/createPaymentIntent";//?currentTime=
    public static var post_stripe_create_payment_session = "home/createPaymentSession"; //api_version=2020-08-27
    public static var post_stripe_create_customer = "home/createStripeCustomer";//descrription
    public static var post_stripe_retrieve_customer = "home/retrieveStripeCustomer";//customerId
    public static var post_stripe_update_customer = "home/updateUserStripeAddressById";//address, userId

    
    

    
    
    
    
}
