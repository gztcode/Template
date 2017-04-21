//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___FULLUSERNAME___
//

#import <Foundation/Foundation.h>

@interface NSObject (GZDescripion)
/**
 *  获取当前类的属性
 */
@property (nonatomic, readonly, copy, getter=getProperties) NSDictionary *gz_properties;

@end
