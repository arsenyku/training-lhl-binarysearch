//
//  main.m
//  BinarySearch
//
//  Created by asu on 2015-08-25.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>

long binarySearch(id target, NSArray *array, long searchRangeStart, long searchRangeEnd, BOOL sortFirst){

    if (sortFirst)
        array = [array sortedArrayUsingSelector:@selector(isGreaterThan:)];
    
    if ( searchRangeEnd < 0 )
        searchRangeEnd = [array count] - 1;
    
    NSLog(@"Searching range: %li to %li", searchRangeStart, searchRangeEnd);
    
    // Base case: did not find target
    if (searchRangeStart > searchRangeEnd)
        return -1;
    
    long pivotIndex = (searchRangeStart + searchRangeEnd) / 2;
    id pivotValue = array[ pivotIndex ];
    
    // Recursive case: adjust ranges
    
    if ([pivotValue isGreaterThan:target]){
        
        long newRangeStart = searchRangeStart;
        long newRangeEnd = pivotIndex - 1;
        
        return binarySearch(target, array, newRangeStart, newRangeEnd, NO);

        
    }else if ([pivotValue isLessThan:target]){
        
        long newRangeStart = pivotIndex + 1;
        long newRangeEnd = searchRangeEnd;
        
        return binarySearch(target, array, newRangeStart, newRangeEnd, NO);

    } else {
    	
        return pivotIndex;
        
    }
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *a = @[ @25, @19, @100, @10, @5 ];
        
        //NSLog(@"%@", [a sortedArrayUsingSelector:@selector(isGreaterThan:)]);
    
        long indexOfTarget = binarySearch(@100, a, 0, -1, YES);
        
        NSLog(@"Index of target: %li", indexOfTarget);

        a = @[ @10, @20, @30, @40, @50, @60 ];
        id target = @50;
        indexOfTarget = binarySearch(target, a, 0, -1, YES);
        NSLog(@"Searching for %@.  Found at index %li", target, indexOfTarget);

        target = @23;
        indexOfTarget = binarySearch(target, a, 0, -1, YES);
        NSLog(@"Searching for %@.  Found at index %li", target, indexOfTarget);

        a = @[];
        target = @50;
        indexOfTarget = binarySearch(target, a, 0, -1, YES);
        NSLog(@"Searching for %@.  Found at index %li", target, indexOfTarget);

        
        a = @[ @"banana", @"apple", @"cherry", @"dingleberry" ];
        target = @"elderberry";
        indexOfTarget = binarySearch(target, a, 0, -1, YES);
        NSLog(@"Searching for %@.  Found at index %li", target, indexOfTarget);
        
    }
    return 0;
}
