//
//  SHAllTableViewCell.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHAllTableViewCell.h"

@interface SHAllTableViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;

@property (weak, nonatomic) IBOutlet UILabel *majorLabel;

@property (weak, nonatomic) IBOutlet UILabel *minorLabel;

@property (weak, nonatomic) IBOutlet UILabel *proximityLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;

@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;


@end

@implementation SHAllTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBeacon:(CLBeacon *)beacon {
    
    _beacon = beacon;
    
    self.uuidLabel.text = beacon.proximityUUID.UUIDString;
    self.majorLabel.text = [NSString stringWithFormat:@"Major: %@", beacon.major];
    
    self.minorLabel.text = [NSString stringWithFormat:@"Minor: %@", beacon.minor];
    
    self.accuracyLabel.text = [NSString stringWithFormat:@"%.2f meters", beacon.accuracy];
    
    self.proximityLabel.text = [NSString stringWithFormat:@"%@", [self proximityString:beacon.proximity]];
    
    self.rssiLabel.text = [NSString stringWithFormat:@"Rssi: %zd", beacon.rssi];
}

/// 返回CLProximity对应的字符串
- (NSString *)proximityString:(CLProximity)proximity {
    switch (proximity) {
        case CLProximityUnknown:
            return @"Unknown";
            
            
        case CLProximityImmediate:
            return @"Immediate";
            
        case CLProximityNear:
            return @"Near";
            
        case CLProximityFar:
            return @"Far";
            break;
            
        default:
            break;
    }
}

/// 行高
+ (CGFloat)cellRowHeight {
    
    return 85;
}

@end
