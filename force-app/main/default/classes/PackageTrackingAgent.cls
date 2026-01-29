global class PackageTrackingAgent {

    @InvocableMethod(label='Get Package Tracking' description='Retrieves comprehensive package tracking information including real-time location coordinates, delivery status, carrier details, and estimated delivery date. Returns tracking data formatted for display on an interactive map.')
    global static List<PackageTrackingResponse> getPackageTracking(List<PackageTrackingRequest> req) {
        List<PackageTrackingResponse> responses = new List<PackageTrackingResponse>();

        // Hardcoding the data for example and not focusing on how we retrieve it.
        // However, consider that we are receiving package tracking data from a service,
        // and then processing the data to generate the final response.
        // This structure allows for easy scaling to query from external APIs, databases, etc.

        PackageTracking packageTracking = new PackageTracking();
        packageTracking.trackingNumber = '1Z999AA10123456784';
        packageTracking.carrier = 'UPS';
        packageTracking.status = 'In Transit';
        packageTracking.estimatedDeliveryDate = '2025-01-30 14:00:00';
        packageTracking.lastUpdate = '2025-01-28 10:30:00';
        packageTracking.destinationAddress = '123 Main St, San Francisco, CA 94102, USA';
        
        // Create location coordinates
        PackageTracking.LocationCoordinates location = new PackageTracking.LocationCoordinates();
        location.latitude = 37.7749;
        location.longitude = -122.4194;
        location.address = '456 Market Street';
        location.city = 'San Francisco';
        location.state = 'CA';
        location.country = 'USA';
        packageTracking.currentLocation = location;

        PackageTrackingResponse response = new PackageTrackingResponse();
        response.packageInfo = packageTracking;
        responses.add(response);

        return responses;
    }

    @JsonAccess(serializable='always' deserializable='always')
    global class PackageTrackingRequest {

        @InvocableVariable(required=true label='Tracking Number' description='The unique tracking number assigned by the shipping carrier (e.g., UPS, FedEx, DHL) to identify and track the package throughout its delivery journey')
        global String trackingNumber;
    }

    @JsonAccess(serializable='always' deserializable='always')
    global class PackageTrackingResponse {
    
        @InvocableVariable(label='Package Tracking Information' description='Complete package tracking information including current location coordinates, delivery status, carrier details, and estimated delivery date')
        global PackageTracking packageInfo;
    }
}