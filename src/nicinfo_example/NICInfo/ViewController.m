//
//  ViewController.m
//  NICInfo
//
//  Created by Kenial on 11. 11. 19..
//  Copyright (c) 2011 Mind in Machine. All rights reserved.
//

#import "ViewController.h"
#import "NICInfoSummary.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




#pragma mark ACTION METHODS

- (IBAction)showNICInfo:(id)sender
{
    NSMutableString* textToShow = [[NSMutableString new] autorelease];
    
    // Process NIC information
    //  performs on PC : 100 times - 39ms, 1000 times - 345 ms
    //  perfomrs on iPhone 4 : 100 times - 261ms, 1000 times - 1850ms

    NICInfoSummary* summary = [[[NICInfoSummary alloc] init] autorelease];
    NSArray *nic_array = summary.nicInfos;
    for(int i=0; i<nic_array.count; i++)
    {
        NICInfo* nic_info = [nic_array objectAtIndex:i];
        [textToShow appendFormat:@"interface : %@\r\n", nic_info.interfaceName];
        if(nic_info.macAddress != nil)
            [textToShow appendFormat:@" - MAC : %@\r\n", [nic_info getMacAddressWithSeparator:@"-"]];
        
        // ip can be multiple
        if(nic_info.nicIPInfos.count > 0)
        { 
            [textToShow appendFormat:@" - IPv4 :\r\n"];
            for(int j=0; j<nic_info.nicIPInfos.count; j++)
            {
                NICIPInfo* ip_info = [nic_info.nicIPInfos objectAtIndex:j];
                [textToShow appendFormat:
                 @"    IP : %@\r\n    netmask : %@\r\n    broadcast : %@\r\n"
                 , ip_info.ip, ip_info.netmask, ip_info.broadcastIP];
            }
        }
        
        // ipv6 can be multiple, also.
        if(nic_info.nicIPv6Infos.count > 0)
        { 
            [textToShow appendFormat:@" - IPv6 :\r\n"];
            for(int j=0; j<nic_info.nicIPv6Infos.count; j++)
            {
                NICIPInfo* ipv6_info = [nic_info.nicIPv6Infos objectAtIndex:j];
                [textToShow appendFormat:
                 @"    IP : %@\r\n    netmask : %@\r\n    broadcast : %@\r\n"
                 , ipv6_info.ip, ipv6_info.netmask, ipv6_info.broadcastIP];
            }
        }
        [textToShow appendFormat:@"\r\n"];
    }
    [textToShow appendFormat:@"\r\n"];    
    
    
    // What are those connected?
    [textToShow appendFormat:@"is3GConnected : %d\r\n", summary.is3GConnected];
    [textToShow appendFormat:@"isBluetoothConnected : %d\r\n", summary.isBluetoothConnected];
    [textToShow appendFormat:@"isPersonalHotspotActivated : %d\r\n", summary.isPersonalHotspotActivated];
    [textToShow appendFormat:@"isWifiConnected : %d\r\n", summary.isWifiConnected];
    [textToShow appendFormat:@"isWifiConnectedToNAT : %d\r\n", summary.isWifiConnectedToNAT];
    
    // append text
    [textview setText:
     [NSString stringWithFormat:@"%@%@\r\n\r\n"
      , [textview text], textToShow]];
    // scroll to last
    [textview scrollRangeToVisible:NSMakeRange([textview text].length-1, 0)];
}

- (IBAction)clear:(id)sender
{
    [textview setText:@""];
}

@end





