//
//  RecipeSegmentControl.m
//  RecipeSegmentControlDemo
//
//  Created by Derek Yang on 05/30/12.
//  Copyright (c) 2012 Derek Yang. All rights reserved.
//

#import "RecipeSegmentControl.h"
#import "SegmentButtonView.h"
#import <QuartzCore/QuartzCore.h>

@interface RecipeSegmentControl ()

@property (nonatomic, strong) NSArray *segmentButtons;
@property (nonatomic, retain) id<SegmentButtonViewDelegate> delegate;
@property float height;

- (void)setUpSegmentButtons;

@end

@implementation RecipeSegmentControl

@synthesize segmentButtons = _segmentButtons;

- (id)init:(id<SegmentButtonViewDelegate>) delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.layer.masksToBounds = YES;

        // Set up segment buttons
        [self setUpSegmentButtons];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setUpSegmentButtons {
    SegmentButtonView *segment1 = [[SegmentButtonView alloc] initWithTitle:@"首页"
                                                               normalImage:[UIImage imageNamed:@"recipe_tab_1.png"]
            highlightImage:[UIImage imageNamed:@"recipe_tab_1_active.png"]
            delegate:self.delegate];
    segment1.tag = 1;
    SegmentButtonView *segment2 = [[SegmentButtonView alloc] initWithTitle:@"个人中心"
                                                               normalImage:[UIImage imageNamed:@"recipe_tab_2.png"]
            highlightImage:[UIImage imageNamed:@"recipe_tab_2_active.png"]
            delegate:self.delegate];
    segment2.tag = 2;
    SegmentButtonView *segment3 = [[SegmentButtonView alloc] initWithTitle:@"设置"
                                                               normalImage:[UIImage imageNamed:@"recipe_tab_3.png"]
            highlightImage:[UIImage imageNamed:@"recipe_tab_3_active.png"]
            delegate:self.delegate];
    segment3.tag = 3;
    segment1.frame = CGRectOffset(segment1.frame, 0, 0);
    segment2.frame = CGRectOffset(segment2.frame, segment1.frame.size.width, 0);
    segment3.frame = CGRectOffset(segment3.frame, segment1.frame.size.width + segment2.frame.size.width, 0);
    self.height = segment1.frame.size.height;

    // Highlight the first segment
    [segment1 setHighlighted:YES animated:NO];

    [self addSubview:segment1];
    [self addSubview:segment2];
    [self addSubview:segment3];

    self.segmentButtons = [NSArray arrayWithObjects:segment1, segment2, segment3, nil];
}

- (void)segmentButtonHighlighted:(SegmentButtonView *)highlightedSegmentButton {
    for (SegmentButtonView *segmentButton in self.segmentButtons) {
        if ([segmentButton isEqual:highlightedSegmentButton]) {
            [segmentButton setHighlighted:YES animated:YES];
        } else {
            [segmentButton setHighlighted:NO animated:YES];
        }
    }
}

@end
