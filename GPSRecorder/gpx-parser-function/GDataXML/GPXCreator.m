//
// Created by zhangchao on 14/12/21.
// Copyright (c) 2014 zhangchao. All rights reserved.
//

#import "GPXCreator.h"

@implementation GPXCreator {

}

- (id)initWithName:(NSString *)creator {
    return [self initWithName:creator version:@"0.1"];
}
- (id)initWithName:(NSString *)creator version:(NSString *)version {
    self = [super self];
    if (self) {
        _rootElement = [GDataXMLNode elementWithName:ROOT_NAME];
        // namespace
        [_rootElement addAttribute:[GDataXMLNode attributeWithName:XML_NAMESPACE stringValue:XML_NAMESPACE_STRING]];
        [_rootElement addAttribute:[GDataXMLNode attributeWithName:XML_NAMESPACE_XSI stringValue:XML_NAMESPACE_XSI_STRING]];
        [_rootElement addAttribute:[GDataXMLNode attributeWithName:XML_NAMESPACE_SCHEMA stringValue:XML_NAMESPACE_SCHEMA_STRING]];
        // creator
        [_rootElement addAttribute:[GDataXMLNode attributeWithName:ATTRIBUTE_ROOT_CREATOR stringValue:creator]];
        // version
        [_rootElement addAttribute:[GDataXMLNode attributeWithName:ATTRIBUTE_ROOT_VERSION stringValue:version]];

        CLLocation *test = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(1.1, 2.2) altitude:0 horizontalAccuracy:0 verticalAccuracy:0 timestamp:0];
        [self addLocation:test];
        [self stop];

        NSString *documentsDir = [FileHelper getDocumentsDirectory];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDir, @"test.gpx"];

        [self saveFile:filePath];
    }
    return self;
}

- (void)addLocation:(CLLocation *)location {
    GDataXMLElement *trkptElement = [GDataXMLNode elementWithName:ELEMENT_TRACK_POINT];
    NSString *latString = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    NSString *lonString = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    [trkptElement addAttribute:[GDataXMLNode attributeWithName:ATTRIBUTE_TRACK_POINT_LATITUDE stringValue:latString]];
    [trkptElement addAttribute:[GDataXMLNode attributeWithName:ATTRIBUTE_TRACK_POINT_LONGITUDE stringValue:lonString]];

    if (location.timestamp != nil) {
        GDataXMLElement *timeElement = [GDataXMLNode elementWithName:ELEMENT_TRACK_POINT_TIME];
        [timeElement setStringValue:[GPXSchema convertTime2String:location.timestamp]];
        [trkptElement addChild:timeElement];
    }

    if (location.altitude != 0.0) {
        NSString *eleString = [NSString stringWithFormat:@"%f",location.altitude];
        GDataXMLElement *eleElement = [GDataXMLNode elementWithName:ELEMENT_TRACK_POINT_ELEVATION];
        [eleElement setStringValue:eleString];
        [trkptElement addChild:eleElement];
    }

    [self addElement:trkptElement];
}

- (void)addElement:(GDataXMLNode *)element {
    [_rootElement addChild:element];
}

- (void)stop {
    _xmlDocument = [[GDataXMLDocument alloc] initWithRootElement:_rootElement];
    [_xmlDocument setCharacterEncoding:@"UTF-8"];
}

- (void)saveFile:(NSString *)filePath {
    NSData *xmlData = _xmlDocument.XMLData;

    NSLog(@"GPXCreator filePath : %@", filePath);
    [xmlData writeToFile:filePath atomically:YES];
}
@end