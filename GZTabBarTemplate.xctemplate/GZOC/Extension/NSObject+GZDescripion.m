//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___FULLUSERNAME___
//

#import "NSObject+GZDescripion.h"
#import <objc/runtime.h>
@implementation NSObject (GZDescripion)


-(NSString *)description{
    return [NSString stringWithFormat:@"<%@: %p, %@>",self.class,self,self.gz_properties];
}

- (NSDictionary *)getProperties{
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(self.class, &count);
    NSMutableDictionary *dicListName = [NSMutableDictionary dictionary];
    for (int i = 0; i < count; i++) {
        @autoreleasepool {
            objc_property_t property = properties[i];
            const char *cName = property_getName(property);
            NSString *key = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
            NSValue *value =[self valueForKey:key];
            if (!value) {
                [dicListName setValue:@"" forKey:key];
            }
            if ([value isKindOfClass:NSObject.class]) {
                NSString * className = NSStringFromClass(value.class);
                if ([[className substringToIndex:2] isEqualToString:@"__"]) {
                    if ([value isKindOfClass:NSArray.class]) {
                        [dicListName setValue:[self isarray:(NSArray *)value] forKey:key];
                    }else if ([value isKindOfClass:NSDictionary.class]) {
                        [dicListName setValue:[self isdic:(NSDictionary *)value] forKey:key];
                    }else{
                        [dicListName setValue:value forKey:key];
                    }
                }else{
                    [dicListName setValue:value.gz_properties forKey:key];
                }
            }
        }
        
        
    }
    return dicListName.copy;
}

-(NSArray *)isarray:(NSArray *)value{
    NSMutableArray * array =[NSMutableArray array];
    for (id obj in value) {
        @autoreleasepool {
            NSString * className = NSStringFromClass([obj class]);
            if ([[className substringToIndex:2] isEqualToString:@"__"]) {
                if ([obj isKindOfClass:[NSArray class]]) {
                    [array addObject:[self isarray:obj]];
                }else if ([obj isKindOfClass:[NSDictionary class]]){
                    [array addObject:[self isdic:obj]];
                }else{
                    [array addObject:obj];
                }
            }else{
                [array addObject:[obj performSelector:@selector(getProperties)]];
            }
        }
    }
    return array.mutableCopy;
}

-(NSDictionary *)isdic:(NSDictionary *)value{
    NSMutableDictionary * dic =[NSMutableDictionary dictionary];
    for (NSString *key in value) {
        id obj = value[key];
        @autoreleasepool {
            NSString * className = NSStringFromClass([obj class]);
            if ([[className substringToIndex:2] isEqualToString:@"__"]) {
                if ([obj isKindOfClass:[NSArray class]]) {
                    [dic setObject:[self isarray:obj] forKey:key];
                }else if ([obj isKindOfClass:[NSDictionary class]]){
                    [dic setObject:[self isdic:obj] forKey:key];
                }else{
                    [dic setObject:obj forKey:key];
                }
            }else{
                [dic setObject:[obj performSelector:@selector(getProperties)] forKey:key];
            }
        }
    }
    return dic.mutableCopy;
}



@end
