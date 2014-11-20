//
//  NICInfoSummary.h
//  NICInfo
//
//  Class for getting network interfaces address information instantly.
//  For usage, Refer to https://bitbucket.org/kenial/nicinfo/wiki
//
//
//  AUTHOR          : kenial (keniallee@gmail.com)
//

#import <Foundation/Foundation.h>
#import "NICInfo.h"

@interface NICInfoSummary : NSObject

/*!
 @property nicInfos
 @abstract
 Contains all NIC information on this devices.
 @discussion
 */
@property (retain, nonatomic, readonly) NSArray *nicInfos;

+ (NICInfoSummary *)shared;
+ (NICInfoSummary *)refresh;

/*!
 @method		findNICInfo
 @abstract		Returns an instance of AVPlayerItem for playing an AVAsset.
 @param			interface_name
                The name of network interface (eg. en0, en1, pdp_ip0, ...)
 @result		An instance of NICInfo. nil if no interface for interfaceName.
 @discussion
 */
- (NICInfo *)findNICInfo:(NSString *)interfaceName;

// iPhone's NIC :
//  pdp_ip0 : 3G
//  en0 : wifi
//  en2 : bluetooth
//  bridge0 : personal hotspot

// macbook air(late 2010)'s NIC (it varies on devices) :
//  en0 : wifi
//  en1 : iphone USB
//  en2 : bluetooth

#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
// os x only!
- (BOOL)isEthernetConnected;
- (BOOL)isEthernetConnectedToNAT;

#else
// iOS only!
- (BOOL)isWifiConnected;
- (BOOL)isWifiConnectedToNAT;
- (BOOL)isBluetoothConnected;
- (BOOL)isPersonalHotspotActivated;
- (BOOL)is3GConnected;

#endif

/*!
 @method		broadcastIPs
 @abstract		Returns all IPs for broadcast. (such as 192.168.0.255 in 192.168.0.xxx local network, depends on IP and netmask)
 @result		An array contains NSString objects.
 @discussion	valid for only IP v4. Excludes localhost IP and if the IP is same to its broadcast IP.
 */
- (NSArray *)broadcastIPs;

/*!
 @method		anyAvailableNicInfo
 @abstract		Returns any NicInfo that IP address is assigned.
 @result		An instance of NICInfo.
 @discussion	valid for only IP v4. Excludes localhost IP.
 */
- (NICInfo *)anyAvailableNicInfo;

/*!
 @method		anyAvailableIPv4
 @abstract		Returns a string form of any assigned IP from available IP addresses.
 @result		A string form of IP (such as @"11.11.11.11")
 @discussion	valid for only IP v4. Excludes localhost IP.
 */
- (NSString *)anyAvailableIPv4;

/*!
 @method		availableNicInfos
 @abstract		Returns NIC infos.
 @result		An array contains NICInfo objects.
 @discussion	valid for only IP v4. Excludes localhost IP.
 */
- (NSArray *)availableNicInfos;

/*!
 @method		availableIPInfov4
 @abstract		Returns IP infos available.
 @result		An array contains NICIPInfo objects.
 @discussion	valid for only IP v4. Excludes localhost IP.
 */
- (NSArray *)availableIPInfov4;

+ (unsigned int)intFromIPString:(NSString *)ipString;

@end
