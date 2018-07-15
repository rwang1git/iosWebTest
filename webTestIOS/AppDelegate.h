//
//  AppDelegate.h
//  webTestIOS
//
//  Created by TONY WANG on 14/12/2017.
//  Copyright © 2017 tonywang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

