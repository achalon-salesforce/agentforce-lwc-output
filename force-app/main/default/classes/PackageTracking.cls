/**
 * Package Tracking data structure containing comprehensive tracking information
 * including current location coordinates displayed on a map, delivery status,
 * carrier details, and estimated delivery information.
 */
@JsonAccess(serializable='always' deserializable='always')
global class PackageTracking {

    @AuraEnabled
    global String trackingNumber;

    @AuraEnabled
    global String carrier;

    @AuraEnabled
    global String status;

    @AuraEnabled
    global LocationCoordinates currentLocation;

    @AuraEnabled
    global String estimatedDeliveryDate;

    @AuraEnabled
    global String lastUpdate;

    @AuraEnabled
    global String destinationAddress;

    global class LocationCoordinates {
        @AuraEnabled
        global Decimal latitude;

        @AuraEnabled
        global Decimal longitude;

        @AuraEnabled
        global String address;

        @AuraEnabled
        global String city;

        @AuraEnabled
        global String state;

        @AuraEnabled
        global String country;
    }
}