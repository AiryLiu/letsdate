//
//  HpLocationManager.m
//  HipuEnd
//
//  Created by qiyu on 2/28/13.
//  Copyright (c) 2013 Hipu.com. All rights reserved.
//

#import "HpLocationManager.h"
#import <CoreLocation/CoreLocation.h>
//#import <AMapSearchKit/AMapSearchAPI.h>

@interface HpLocationManager ()<CLLocationManagerDelegate,UIAlertViewDelegate>//,AMapSearchDelegate>
{
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
    NSDictionary * _placeInfo;
    NSDictionary * _markCity;
//    AMapSearchAPI *_search;
}
@end

@implementation HpLocationManager

+ (instancetype)sharedInstance
{
    static id s_locationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_locationManager = [[HpLocationManager alloc] init];
    });
    return s_locationManager;
}

- (id)init{
    self = [super init];
    if (self) {
//        _markCity = [NSStandardUserDefaults dictionaryForKey:@"MarkCity"];
    }
    return self;
}

- (void)dealloc
{
    [_locationManager stopUpdatingLocation];
    [_geocoder cancelGeocode];
}

- (void)startUpdatingLocation
{
    double interval = 0;//[NSStandardUserDefaults doubleForKey:kHpUploadLocationTime] - HpSharedEngine.serverTime;
    if(_locationManager || (interval > 0 && interval < 24 * 60 * 60)){
        return;
    }
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc] init];
        
        _locationManager.delegate = self;

        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        }
        _locationManager.distanceFilter = 100.0f;
        [_locationManager startUpdatingLocation];
    }
}

- (void)stopUpdatingLocation
{
    [_locationManager stopUpdatingLocation];
    _locationManager = nil;
    [_geocoder cancelGeocode];
    _geocoder = nil;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation* newLocation = [locations lastObject];
    if (newLocation) {
        //        if([newLocation.timestamp timeIntervalSinceDate:oldLocation.timestamp] < 60){
        //            return;
        //        }
        [self stopUpdatingLocation];
        
        if(!_geocoder){
            _geocoder = [[CLGeocoder alloc] init];
        }
        [_geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            if(placemarks.count == 0){
                return;
            }
            CLPlacemark *placemark = placemarks[0];
            NSMutableDictionary *placeInfo = [NSMutableDictionary dictionaryWithCapacity:10];
            if(placemark.country) {
                placeInfo[@"country"] = placemark.country;
            }
            if(placemark.locality) {
                placeInfo[@"locality"] = placemark.locality;
            }
            if(placemark.subLocality) {
                placeInfo[@"subLocality"] = placemark.subLocality;
            }
            if(placemark.thoroughfare) {
                placeInfo[@"thoroughfare"] = placemark.thoroughfare;
            }
            if(placemark.subThoroughfare) {
                placeInfo[@"subThoroughfare"] = placemark.subThoroughfare;
            }
            if(placemark.administrativeArea) {
                placeInfo[@"administrativeArea"] = placemark.administrativeArea;
            }
            if(placemark.ISOcountryCode) {
                placeInfo[@"ISOcountryCode"] = placemark.ISOcountryCode;
            }
            if(placemark.ocean) {
                placeInfo[@"ocean"] = placemark.ocean;
            }
            if(placemark.postalCode) {
                placeInfo[@"postalCode"] = placemark.postalCode;
            }
            if(placemark.areasOfInterest) {
                placeInfo[@"areasOfInterest"] = placemark.areasOfInterest;
            }
            [self isLocationChanged:placeInfo];

            NSLog(@"latitude:%.4lf longitude:%.4lf\n %@", newLocation.coordinate.latitude, newLocation.coordinate.longitude, placeInfo);
        }];
    }else{
        [self isLocationChanged:_placeInfo];
    }
}

- (BOOL)isLocationChanged:(NSDictionary *)placeInfo
{
    if (![placeInfo isEqualToDictionary:_markCity]) {
        NSString * country = placeInfo[@"country"];
        NSString * locality = placeInfo[@"locality"];
        NSString * administrativeArea = placeInfo[@"administrativeArea"];
        NSString * subLocality = placeInfo[@"subLocality"];
        
        BOOL shouldAlert = YES;
        
        NSString *newLocation;
        if ([country rangeOfString:@"中国"].length > 0) {
            newLocation = (locality&&![locality isEqualToString:@""]) ? locality : administrativeArea;
        } else {
            newLocation = country;
        }
        // alert
        if (shouldAlert) {
            [self showAlertForLocationChanged:newLocation];
        }
        
        // notification
        [[NSNotificationCenter defaultCenter] postNotificationName:HpLocationDidChangedNotifation object:nil userInfo:@{@"location":newLocation}];
        
    }
    return YES;
}

- (void)showAlertForLocationChanged:(NSString *)newLocation{
    NSString * replaceLocation = [newLocation stringByReplacingOccurrencesOfString:@"市辖区" withString:@""];
    NSString * currentLocationString = [NSString stringWithFormat:@"是否查看 %@ 信息？",replaceLocation];
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"地点发生改变" message:currentLocationString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if([newLocation.timestamp timeIntervalSinceDate:oldLocation.timestamp] < 60){
        return;
    }
    [self stopUpdatingLocation];
    
    if(!_geocoder){
        _geocoder = [[CLGeocoder alloc] init];
    }
    [_geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if(placemarks.count == 0){
            return;
        }
        CLPlacemark *placemark = placemarks[0];
        NSMutableDictionary *placeInfo = [NSMutableDictionary dictionaryWithCapacity:10];
        if(placemark.country) {
            placeInfo[@"country"] = placemark.country;
        }
        if(placemark.locality) {
            placeInfo[@"locality"] = placemark.locality;
        }
        if(placemark.subLocality) {
            placeInfo[@"subLocality"] = placemark.subLocality;
        }
        if(placemark.thoroughfare) {
            placeInfo[@"thoroughfare"] = placemark.thoroughfare;
        }
        if(placemark.subThoroughfare) {
            placeInfo[@"subThoroughfare"] = placemark.subThoroughfare;
        }
        if(placemark.administrativeArea) {
            placeInfo[@"administrativeArea"] = placemark.administrativeArea;
        }
        if(placemark.ISOcountryCode) {
            placeInfo[@"ISOcountryCode"] = placemark.ISOcountryCode;
        }
        if(placemark.ocean) {
            placeInfo[@"ocean"] = placemark.ocean;
        }
        if(placemark.postalCode) {
            placeInfo[@"postalCode"] = placemark.postalCode;
        }
        if(placemark.areasOfInterest) {
            placeInfo[@"areasOfInterest"] = placemark.areasOfInterest;
        }
        
//        [HpSharedEngine uploadLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude placeInfo:placeInfo];
        
//        [self sendLocationLogWithlatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
        
        NSLog(@"latitude:%.4lf longitude:%.4lf\n %@", newLocation.coordinate.latitude, newLocation.coordinate.longitude, placeInfo);
    }];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusDenied) {
        [manager stopUpdatingLocation];
        [manager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [self stopUpdatingLocation];
}

#pragma mark - MAMAP Delegate
/*
- (void)sendLocationLogWithlatitude:(double)latitude longitude:(double)longitude{
    _search = [[AMapSearchAPI alloc] initWithSearchKey:kHpGaodeKey Delegate:self];
    
    AMapReGeocodeSearchRequest * regroRequest = [[AMapReGeocodeSearchRequest alloc]init];
    regroRequest.searchType = AMapSearchType_ReGeocode;
    regroRequest.location = [AMapGeoPoint locationWithLatitude:latitude longitude:longitude];
    regroRequest.radius = 10000;
    regroRequest.requireExtension = YES;
    [_search AMapReGoecodeSearch:regroRequest];
    
}

- (void)searchRequest:(id)request didFailWithError:(NSError *)error{
    NSLog(@"错误信息");
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    if (response.regeocode != nil) {
        NSMutableDictionary * geo_dataDict = [[NSMutableDictionary alloc] init];
        NSArray * poiArray =  response.regeocode.pois;
        NSMutableArray * poiMArray = [[NSMutableArray alloc] init];
        for (AMapPOI * item in poiArray) {
            NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
            dict[@"type"] = item.type?item.type:@"";
            dict[@"id"] = item.uid?item.uid:@"";
            dict[@"distance"] = @(item.distance);
            dict[@"title"] = item.name?item.name:@"";
            [poiMArray addObject:dict];
        }
        
        AMapAddressComponent * addressComponent = response.regeocode.addressComponent;
        geo_dataDict[@"districtCode"]= addressComponent.adcode;
        geo_dataDict[@"district"]= addressComponent.district;
        geo_dataDict[@"address"]= [NSString stringWithFormat:@"%@ %@ %@ %@",addressComponent.province,addressComponent.city,addressComponent.district, addressComponent.streetNumber.street];
        geo_dataDict[@"street"]= addressComponent.streetNumber.street;
        geo_dataDict[@"cityCode"]= addressComponent.citycode;
        geo_dataDict[@"city"]= addressComponent.city?addressComponent.city:addressComponent.province;
        geo_dataDict[@"province"]= addressComponent.province;
        geo_dataDict[@"extras"]= addressComponent.township;
        
        NSString * clientInfoStr = [NSString stringWithFormat:@"%@,%@,%@",addressComponent.province,addressComponent.city,addressComponent.district];
        [NSStandardUserDefaults setObject:clientInfoStr forKey:kHpClientInfoRegion];
        [NSStandardUserDefaults synchronize];
        
        [HpSharedEngine uploadLatitude:addressComponent.streetNumber.location.latitude longitude:addressComponent.streetNumber.location.longitude placeInfo:geo_dataDict];

    }
}
*/
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        _markCity = _placeInfo;
//        [NSStandardUserDefaults setObject:_markCity forKey:@"MarkCity"];
//        [NSStandardUserDefaults synchronize];
    }else if (buttonIndex == 1) {
        NSString * locality = _placeInfo[@"locality"];
        NSString * subLocality = _placeInfo[@"subLocality"];
        NSString * administrativeArea = _placeInfo[@"administrativeArea"];
        NSString * country = _placeInfo[@"country"];

        NSString * filePath = [[NSBundle mainBundle]pathForResource:@"city" ofType:@"txt"];
        NSError * error;
        NSArray * tmpArray = [[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error] componentsSeparatedByString:@"\n"];
        
        /*
        BOOL isfind = NO;
        HpChannel * channel = [[HpChannel alloc] init];
        
        if ([country rangeOfString:@"中国"].length == 0) {
            channel.name = country;
            isfind = YES;
        }
        
        if (!isfind) {
            for (NSString * tempStr in tmpArray) {
                NSArray * tmp = [tempStr componentsSeparatedByString:@" "];
                NSString * cityName = [tmp lastObject];
                NSRange range = [administrativeArea rangeOfString:cityName];
                //            if ([administrativeArea containsString:cityName]) {
                if (range.length!=0) {
                    isfind = YES;
                    channel.name = cityName;
                    channel.channelId = [tmp firstObject];
                    break;
                }
            }
        }
        
        
        if (!isfind) {
            for (NSString * tempStr in tmpArray) {
                NSArray * tmp = [tempStr componentsSeparatedByString:@" "];
                NSString * cityName = [tmp lastObject];
                NSRange range = [subLocality rangeOfString:cityName];
//                if ([subLocality containsString:cityName]) {
                if (range.length!=0) {
                    isfind = YES;
                    channel.name = cityName;
                    channel.channelId = [tmp firstObject];
                    break;
                }
            }
        }
        
        if (!isfind) {
            for (NSString * tempStr in tmpArray) {
                NSArray * tmp = [tempStr componentsSeparatedByString:@" "];
                NSString * cityName = [tmp lastObject];
                NSRange range = [locality rangeOfString:cityName];
//                if ([locality containsString:cityName]) {
                if (range.length!=0) {
                    isfind = YES;
                    channel.name = cityName;
                    channel.channelId = [tmp firstObject];
                    break;
                }
            }
        }
        if (isfind) {
            NSMutableArray * channelArray = [NSMutableArray arrayWithArray:[HpSharedEngine userChannels]];
            BOOL containLoaclChannel = NO;
            for (HpChannel * chn in channelArray) {
                if ([chn.typeStr isEqualToString:@"local"]) {
                    containLoaclChannel = YES;
                    NSInteger index = [channelArray indexOfObject:chn];
                    [channelArray insertObject:channel atIndex:index];
                    [[HpEngine sharedInstance] commitHomeChannelsV2:channelArray completion:^(NSError *errror) {
                    }];
                    break;
                }
            }
            if (!containLoaclChannel) {
                [channelArray insertObject:channel atIndex:2];
                [[HpEngine sharedInstance] commitHomeChannelsV2:channelArray completion:^(NSError *errror) {
                }];
            }
        }
        
*/
    }
}
@end
