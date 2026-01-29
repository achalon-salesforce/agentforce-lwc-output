import { LightningElement, api } from 'lwc';

export default class PackageTrackingMap extends LightningElement {
    @api value;
    
    packageData = {};
    mapMarkers = [];
    zoomLevel = 10;

    // Method to format location information for map marker description
    formatLocationInfo(packageInfo) {
        let info = '';
        const currentLocation = packageInfo?.currentLocation;
        
        if (packageInfo?.status) {
            info += `Status: ${packageInfo.status}\n`;
        }
        
        if (currentLocation && currentLocation.address) {
            info += `Address: ${currentLocation.address}`;
            if (currentLocation.city) {
                info += `, ${currentLocation.city}`;
            }
            if (currentLocation.state) {
                info += `, ${currentLocation.state}`;
            }
            if (currentLocation.country) {
                info += `, ${currentLocation.country}`;
            }
            info += '\n';
        }
        
        if (packageInfo?.lastUpdate) {
            info += `Last Update: ${packageInfo.lastUpdate}\n`;
        }
        
        if (packageInfo?.estimatedDeliveryDate) {
            info += `Estimated Delivery: ${packageInfo.estimatedDeliveryDate}`;
        }
        
        return info.trim();
    }

    connectedCallback() {
        // Handle both direct PackageTracking object or wrapped in packageInfo
        const packageInfo = this.value?.packageInfo || this.value || {};
        this.packageData = {
            ...packageInfo,
            trackingNumber: packageInfo.trackingNumber || 'N/A',
            carrier: packageInfo.carrier || 'N/A',
            status: packageInfo.status || 'N/A',
            estimatedDeliveryDate: packageInfo.estimatedDeliveryDate || 'N/A',
            lastUpdate: packageInfo.lastUpdate || 'N/A',
            destinationAddress: packageInfo.destinationAddress || 'N/A'
        };

        // Set up map markers if location data is available
        const currentLocation = packageInfo?.currentLocation;
        if (currentLocation && currentLocation.latitude && currentLocation.longitude) {
            this.mapMarkers = [{
                location: {
                    Latitude: currentLocation.latitude,
                    Longitude: currentLocation.longitude
                },
                title: `Package ${packageInfo.trackingNumber || ''}`,
                description: this.formatLocationInfo(packageInfo),
                icon: 'standard:package'
            }];
        }
    }

    get hasLocationData() {
        const currentLocation = this.packageData?.currentLocation;
        return currentLocation && 
               currentLocation.latitude && 
               currentLocation.longitude;
    }

    get mapCenter() {
        const currentLocation = this.packageData?.currentLocation;
        if (currentLocation && currentLocation.latitude && currentLocation.longitude) {
            return {
                location: {
                    Latitude: currentLocation.latitude,
                    Longitude: currentLocation.longitude
                }
            };
        }
        return null;
    }

    get displayInfo() {
        return {
            trackingNumber: this.packageData.trackingNumber,
            carrier: this.packageData.carrier,
            status: this.packageData.status,
            estimatedDeliveryDate: this.packageData.estimatedDeliveryDate,
            lastUpdate: this.packageData.lastUpdate,
            destinationAddress: this.packageData.destinationAddress
        };
    }
}