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

void binarySearchWithDuplicates(id target, NSArray *searchArray, NSMutableArray *resultsArray, long searchRangeStart, long searchRangeEnd, BOOL sortFirst){
    
    if (sortFirst)
        searchArray = [searchArray sortedArrayUsingSelector:@selector(isGreaterThan:)];
    
    if ( searchRangeEnd < 0 )
        searchRangeEnd = [searchArray count] - 1;
    
    
    if (resultsArray == nil){
        resultsArray = [[NSMutableArray alloc] init];
    }
    
    // Base case: did not find target
    if (searchRangeStart > searchRangeEnd){

        return ;
    }
    
    long pivotIndex = (searchRangeStart + searchRangeEnd) / 2;
    id pivotValue = searchArray[ pivotIndex ];
    
    // Recursive case: adjust ranges
    
    if ([pivotValue isGreaterThan:target]){
        
        long newRangeStart = searchRangeStart;
        long newRangeEnd = pivotIndex - 1;
        
        binarySearchWithDuplicates(target, searchArray, resultsArray, newRangeStart, newRangeEnd, NO);
        
    }else if ([pivotValue isLessThan:target]){
        
        long newRangeStart = pivotIndex + 1;
        long newRangeEnd = searchRangeEnd;
        
        binarySearchWithDuplicates(target, searchArray, resultsArray, newRangeStart, newRangeEnd, NO);
        
    } else {
        
        [resultsArray addObject:[NSNumber numberWithLong:pivotIndex]];
        
        //left of pivot
        long newRangeStart = searchRangeStart;
        long newRangeEnd = pivotIndex - 1;

        // Don't do recursion if there is nothing to the left
        if (newRangeEnd >=0)
	        binarySearchWithDuplicates(target, searchArray, resultsArray, newRangeStart, newRangeEnd, NO);
        
        //right of pivot
        newRangeStart = pivotIndex + 1;
        newRangeEnd = searchRangeEnd;

        // Don't do recursion if there is nothing to the right
        if (newRangeStart  < [searchArray count])
	        binarySearchWithDuplicates(target, searchArray, resultsArray, newRangeStart, newRangeEnd, NO);
        
    }
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *a = @[ @25, @19, @100, @10, @5 ];
        
        //NSLog(@"%@", [a sortedArrayUsingSelector:@selector(isGreaterThan:)]);
    
        NSLog(@"------  No Duplicates in array -------\n");

        
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
        
        
        
        NSLog(@"\n\n\n------  Duplicates allowed in array -------");

        NSMutableArray* results = [[NSMutableArray alloc]init];
        
        NSLog(@"\nExpected: 1,2");
        a = @[@2, @3, @3, @5, @6, @6];
        target = @3;
        binarySearchWithDuplicates(target, a, results, 0, -1, NO);
        NSLog(@"%@", results);
        
        NSLog(@"\nExpected: not found");
        [results removeAllObjects];
        target = @4;
        binarySearchWithDuplicates(target, a, results, 0, -1, NO);
        NSLog(@"%@", results);

        NSLog(@"\nExpected: 0 1 2 3 4 5");
        [results removeAllObjects];
        a = @[@30, @30, @30, @30, @30, @30];
        target = @30;
        binarySearchWithDuplicates(target, a, results, 0, -1, NO);
        NSLog(@"%@", results);

        
        NSLog(@"\nExpected: not found");
        [results removeAllObjects];
        a = @[@30, @30, @30, @30, @30, @30];
        target = @40;
        binarySearchWithDuplicates(target, a, results, 0, -1, NO);
        NSLog(@"%@", results);

        
    }
    return 0;
}
